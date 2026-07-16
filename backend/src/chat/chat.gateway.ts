/* eslint-disable @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-member-access, @typescript-eslint/no-unsafe-argument */
import {
  WebSocketGateway,
  SubscribeMessage,
  MessageBody,
  ConnectedSocket,
  WebSocketServer,
  OnGatewayConnection,
  OnGatewayDisconnect,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { ChatService } from './chat.service';
import { JwtService } from '@nestjs/jwt';

interface JwtPayload {
  sub: string;
  email: string;
  role: string;
  schoolId: string;
}

interface SocketData {
  user?: JwtPayload;
}

@WebSocketGateway({
  cors: {
    origin: '*',
  },
})
export class ChatGateway implements OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  // Map userId to socketId for 1-to-1 DMs
  private userSockets = new Map<string, string>();

  constructor(
    private chatService: ChatService,
    private jwtService: JwtService,
  ) {}

  async handleConnection(client: Socket<any, any, any, SocketData>) {
    try {
      const authHeader = client.handshake.headers.authorization;
      if (!authHeader) {
        client.disconnect();
        return;
      }

      const token = authHeader.split(' ')[1];
      const payload = this.jwtService.verify(token, {
        secret: process.env.JWT_SECRET || 'super-secret',
      });

      // Store user info on socket
      client.data = { ...client.data, user: payload };
      this.userSockets.set(payload.sub, client.id);

      // Join all user's group rooms
      const groups = await this.chatService.getMyGroups(payload.sub);
      groups.forEach((g: { id: string }) => {
        void client.join(`group_${g.id}`);
      });

      console.log(`Client connected: ${payload.sub} (${client.id})`);
    } catch (e) {
      console.log(
        'Socket connection rejected due to invalid token',
        (e as Error).message,
      );
      client.disconnect();
    }
  }

  handleDisconnect(client: Socket<any, any, any, SocketData>) {
    const user = client.data.user;
    if (user) {
      this.userSockets.delete(user.sub);
      console.log(`Client disconnected: ${user.sub}`);
    }
  }

  @SubscribeMessage('sendGroupMessage')
  async handleGroupMessage(
    @ConnectedSocket() client: Socket<any, any, any, SocketData>,
    @MessageBody() payload: { groupId: string; content: string },
  ) {
    const user = client.data.user;
    if (!user) return;

    const message = await this.chatService.saveGroupMessage(
      user.schoolId,
      user.sub, // senderId
      payload.groupId,
      payload.content,
    );

    // Broadcast to the group room
    this.server
      .to(`group_${payload.groupId}`)
      .emit('receiveGroupMessage', message);
  }

  @SubscribeMessage('sendDirectMessage')
  async handleDirectMessage(
    @ConnectedSocket() client: Socket<any, any, any, SocketData>,
    @MessageBody() payload: { receiverId: string; content: string },
  ) {
    const user = client.data.user;
    if (!user) return;

    const message = await this.chatService.saveDirectMessage(
      user.schoolId,
      user.sub,
      payload.receiverId,
      payload.content,
    );

    // Send to receiver if online
    const receiverSocketId = this.userSockets.get(payload.receiverId);
    if (receiverSocketId) {
      this.server.to(receiverSocketId).emit('receiveDirectMessage', message);
    }

    // Also send back to sender so their UI updates if they're listening on socket
    client.emit('receiveDirectMessage', message);
  }
}
