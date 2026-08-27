"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ChatGateway = void 0;
const websockets_1 = require("@nestjs/websockets");
const socket_io_1 = require("socket.io");
const chat_service_1 = require("./chat.service");
const jwt_1 = require("@nestjs/jwt");
let ChatGateway = class ChatGateway {
    chatService;
    jwtService;
    server;
    userSockets = new Map();
    constructor(chatService, jwtService) {
        this.chatService = chatService;
        this.jwtService = jwtService;
    }
    async handleConnection(client) {
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
            client.data = { ...client.data, user: payload };
            this.userSockets.set(payload.sub, client.id);
            const groups = await this.chatService.getMyGroups(payload.sub);
            groups.forEach((g) => {
                void client.join(`group_${g.id}`);
            });
            console.log(`Client connected: ${payload.sub} (${client.id})`);
        }
        catch (e) {
            console.log('Socket connection rejected due to invalid token', e.message);
            client.disconnect();
        }
    }
    handleDisconnect(client) {
        const user = client.data.user;
        if (user) {
            this.userSockets.delete(user.sub);
            console.log(`Client disconnected: ${user.sub}`);
        }
    }
    async handleGroupMessage(client, payload) {
        const user = client.data.user;
        if (!user)
            return;
        const message = await this.chatService.saveGroupMessage(user.schoolId, user.sub, payload.groupId, payload.content);
        this.server
            .to(`group_${payload.groupId}`)
            .emit('receiveGroupMessage', message);
    }
    async handleDirectMessage(client, payload) {
        const user = client.data.user;
        if (!user)
            return;
        const message = await this.chatService.saveDirectMessage(user.schoolId, user.sub, payload.receiverId, payload.content);
        const receiverSocketId = this.userSockets.get(payload.receiverId);
        if (receiverSocketId) {
            this.server.to(receiverSocketId).emit('receiveDirectMessage', message);
        }
        client.emit('receiveDirectMessage', message);
    }
};
exports.ChatGateway = ChatGateway;
__decorate([
    (0, websockets_1.WebSocketServer)(),
    __metadata("design:type", socket_io_1.Server)
], ChatGateway.prototype, "server", void 0);
__decorate([
    (0, websockets_1.SubscribeMessage)('sendGroupMessage'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", Promise)
], ChatGateway.prototype, "handleGroupMessage", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('sendDirectMessage'),
    __param(0, (0, websockets_1.ConnectedSocket)()),
    __param(1, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [socket_io_1.Socket, Object]),
    __metadata("design:returntype", Promise)
], ChatGateway.prototype, "handleDirectMessage", null);
exports.ChatGateway = ChatGateway = __decorate([
    (0, websockets_1.WebSocketGateway)({
        cors: {
            origin: '*',
        },
    }),
    __metadata("design:paramtypes", [chat_service_1.ChatService,
        jwt_1.JwtService])
], ChatGateway);
//# sourceMappingURL=chat.gateway.js.map