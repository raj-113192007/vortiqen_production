import { OnGatewayConnection, OnGatewayDisconnect } from '@nestjs/websockets';
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
export declare class ChatGateway implements OnGatewayConnection, OnGatewayDisconnect {
    private chatService;
    private jwtService;
    server: Server;
    private userSockets;
    constructor(chatService: ChatService, jwtService: JwtService);
    handleConnection(client: Socket<any, any, any, SocketData>): Promise<void>;
    handleDisconnect(client: Socket<any, any, any, SocketData>): void;
    handleGroupMessage(client: Socket<any, any, any, SocketData>, payload: {
        groupId: string;
        content: string;
    }): Promise<void>;
    handleDirectMessage(client: Socket<any, any, any, SocketData>, payload: {
        receiverId: string;
        content: string;
    }): Promise<void>;
}
export {};
