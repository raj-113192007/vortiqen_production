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

  async handleConnection(client: Socket) {
    try {
      const authHeader = client.handshake.headers.authorization;
      if (!authHeader) {
        client.disconnect();
        return;
      }

      const token = authHeader.split(' ')[1];
      const payload = this.jwtService.verify(token, { secret: process.env.JWT_SECRET || 'super-secret' });
      
      // Store user info on socket
      client.data.user = payload;
      this.userSockets.set(payload.sub, client.id);

      // Join all user's group rooms
      const groups = await this.chatService.getMyGroups(payload.sub);
      groups.forEach(g => {
        client.join(`group_${g.id}`);
      });

      console.log(`Client connected: ${payload.sub} (${client.id})`);
    } catch (e) {
      console.log('Socket connection rejected due to invalid token', e.message);
      client.disconnect();
    }
  }

  handleDisconnect(client: Socket) {
    if (client.data.user) {
      this.userSockets.delete(client.data.user.sub);
      console.log(`Client disconnected: ${client.data.user.sub}`);
    }
  }

  @SubscribeMessage('sendGroupMessage')
  async handleGroupMessage(
    @ConnectedSocket() client: Socket,
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
    this.server.to(`group_${payload.groupId}`).emit('receiveGroupMessage', message);
  }

  @SubscribeMessage('sendDirectMessage')
  async handleDirectMessage(
    @ConnectedSocket() client: Socket,
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
