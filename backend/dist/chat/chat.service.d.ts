import { PrismaService } from '../prisma/prisma.service';
export declare class ChatService {
    private prisma;
    constructor(prisma: PrismaService);
    createGroup(schoolId: string, name: string, creatorId: string): Promise<{
        name: string;
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        isGroup: boolean;
    }>;
    addMemberToGroup(groupId: string, userId: string, role?: string): Promise<{
        id: string;
        role: string;
        userId: string;
        joinedAt: Date;
        groupId: string;
    }>;
    getMyGroups(userId: string): Promise<({
        members: {
            id: string;
            role: string;
            userId: string;
            joinedAt: Date;
            groupId: string;
        }[];
    } & {
        name: string;
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        isGroup: boolean;
    })[]>;
    getGroupMessages(groupId: string, take?: number): Promise<({
        sender: {
            name: string;
            id: string;
            role: string;
        };
    } & {
        id: string;
        schoolId: string;
        createdAt: Date;
        content: string;
        groupId: string | null;
        senderId: string;
        receiverId: string | null;
        isRead: boolean;
    })[]>;
    getDirectMessages(userId1: string, userId2: string, take?: number): Promise<({
        sender: {
            name: string;
            id: string;
            role: string;
        };
        receiver: {
            name: string;
            id: string;
            role: string;
        } | null;
    } & {
        id: string;
        schoolId: string;
        createdAt: Date;
        content: string;
        groupId: string | null;
        senderId: string;
        receiverId: string | null;
        isRead: boolean;
    })[]>;
    saveGroupMessage(schoolId: string, senderId: string, groupId: string, content: string): Promise<{
        sender: {
            name: string;
            id: string;
            role: string;
        };
    } & {
        id: string;
        schoolId: string;
        createdAt: Date;
        content: string;
        groupId: string | null;
        senderId: string;
        receiverId: string | null;
        isRead: boolean;
    }>;
    saveDirectMessage(schoolId: string, senderId: string, receiverId: string, content: string): Promise<{
        sender: {
            name: string;
            id: string;
            role: string;
        };
        receiver: {
            name: string;
            id: string;
            role: string;
        } | null;
    } & {
        id: string;
        schoolId: string;
        createdAt: Date;
        content: string;
        groupId: string | null;
        senderId: string;
        receiverId: string | null;
        isRead: boolean;
    }>;
}
