import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ChatService {
  constructor(private prisma: PrismaService) {}

  async createGroup(schoolId: string, name: string, creatorId: string) {
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

  async addMemberToGroup(groupId: string, userId: string, role: string = 'MEMBER') {
    return this.prisma.chatGroupMember.create({
      data: {
        groupId,
        userId,
        role,
      },
    });
  }

  async getMyGroups(userId: string) {
    const memberships = await this.prisma.chatGroupMember.findMany({
      where: { userId },
      include: {
        group: {
          include: {
            members: true, // Just to get member count
          }
        },
      },
    });
    return memberships.map(m => m.group);
  }

  async getGroupMessages(groupId: string, take: number = 50) {
    return this.prisma.message.findMany({
      where: { groupId },
      orderBy: { createdAt: 'desc' },
      take,
      include: {
        sender: {
          select: { id: true, name: true, role: true }
        }
      }
    });
  }

  async getDirectMessages(userId1: string, userId2: string, take: number = 50) {
    return this.prisma.message.findMany({
      where: {
        OR: [
          { senderId: userId1, receiverId: userId2 },
          { senderId: userId2, receiverId: userId1 },
        ]
      },
      orderBy: { createdAt: 'desc' },
      take,
      include: {
        sender: {
          select: { id: true, name: true, role: true }
        },
        receiver: {
          select: { id: true, name: true, role: true }
        }
      }
    });
  }

  async saveGroupMessage(schoolId: string, senderId: string, groupId: string, content: string) {
    return this.prisma.message.create({
      data: {
        schoolId,
        senderId,
        groupId,
        content,
      },
      include: {
        sender: {
          select: { id: true, name: true, role: true }
        }
      }
    });
  }

  async saveDirectMessage(schoolId: string, senderId: string, receiverId: string, content: string) {
    return this.prisma.message.create({
      data: {
        schoolId,
        senderId,
        receiverId,
        content,
      },
      include: {
        sender: {
          select: { id: true, name: true, role: true }
        },
        receiver: {
          select: { id: true, name: true, role: true }
        }
      }
    });
  }
}
