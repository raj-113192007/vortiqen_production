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
Object.defineProperty(exports, "__esModule", { value: true });
exports.ChatService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let ChatService = class ChatService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async createGroup(schoolId, name, creatorId) {
        return this.prisma.chatGroup.create({
            data: {
                schoolId,
                name,
                members: {
                    create: {
                        userId: creatorId,
                        role: 'ADMIN',
                    },
                },
            },
        });
    }
    async addMemberToGroup(groupId, userId, role = 'MEMBER') {
        return this.prisma.chatGroupMember.create({
            data: {
                groupId,
                userId,
                role,
            },
        });
    }
    async getMyGroups(userId) {
        const memberships = await this.prisma.chatGroupMember.findMany({
            where: { userId },
            include: {
                group: {
                    include: {
                        members: true,
                    },
                },
            },
        });
        return memberships.map((m) => m.group);
    }
    async getGroupMessages(groupId, take = 50) {
        return this.prisma.message.findMany({
            where: { groupId },
            orderBy: { createdAt: 'desc' },
            take,
            include: {
                sender: {
                    select: { id: true, name: true, role: true },
                },
            },
        });
    }
    async getDirectMessages(userId1, userId2, take = 50) {
        return this.prisma.message.findMany({
            where: {
                OR: [
                    { senderId: userId1, receiverId: userId2 },
                    { senderId: userId2, receiverId: userId1 },
                ],
            },
            orderBy: { createdAt: 'desc' },
            take,
            include: {
                sender: {
                    select: { id: true, name: true, role: true },
                },
                receiver: {
                    select: { id: true, name: true, role: true },
                },
            },
        });
    }
    async saveGroupMessage(schoolId, senderId, groupId, content) {
        return this.prisma.message.create({
            data: {
                schoolId,
                senderId,
                groupId,
                content,
            },
            include: {
                sender: {
                    select: { id: true, name: true, role: true },
                },
            },
        });
    }
    async saveDirectMessage(schoolId, senderId, receiverId, content) {
        return this.prisma.message.create({
            data: {
                schoolId,
                senderId,
                receiverId,
                content,
            },
            include: {
                sender: {
                    select: { id: true, name: true, role: true },
                },
                receiver: {
                    select: { id: true, name: true, role: true },
                },
            },
        });
    }
};
exports.ChatService = ChatService;
exports.ChatService = ChatService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], ChatService);
//# sourceMappingURL=chat.service.js.map