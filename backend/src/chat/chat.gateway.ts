import { WebSocketGateway, WebSocketServer, SubscribeMessage, OnGatewayConnection, OnGatewayDisconnect, ConnectedSocket, MessageBody } from '@nestjs/websockets';
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

  private connectedClients = new Map<string, string>(); // userId -> socketId

  constructor(
    private chatService: ChatService,
    private jwtService: JwtService,
  ) {}

  async handleConnection(client: Socket) {
    try {
      const token = client.handshake.auth.token?.split(' ')[1];
      if (!token) throw new Error('No token');
      
      const decoded = this.jwtService.verify(token, { secret: process.env.JWT_SECRET });
      const userId = decoded.sub;
      
      this.connectedClients.set(userId, client.id);
      client.data.user = decoded;
      console.log(`Client connected: ${userId} (${client.id})`);
    } catch (e) {
      console.log('Socket connection rejected:', e.message);
      client.disconnect();
    }
  }

  handleDisconnect(client: Socket) {
    const userId = client.data.user?.sub;
    if (userId) {
      this.connectedClients.delete(userId);
      console.log(`Client disconnected: ${userId}`);
    }
  }

  @SubscribeMessage('sendMessage')
  async handleSendMessage(
    @ConnectedSocket() client: Socket,
    @MessageBody() payload: { receiverId: string, content: string }
  ) {
    const sender = client.data.user;
    const schoolId = sender.schoolId;
    
    // 1. Save message to DB
    const message = await this.chatService.saveMessage(
      schoolId,
      sender.sub,
      payload.receiverId,
      payload.content
    );

    // 2. Emit back to sender (to confirm)
    client.emit('newMessage', message);

    // 3. Emit to receiver if online
    const receiverSocketId = this.connectedClients.get(payload.receiverId);
    if (receiverSocketId) {
      this.server.to(receiverSocketId).emit('newMessage', message);
    }
  }
}
