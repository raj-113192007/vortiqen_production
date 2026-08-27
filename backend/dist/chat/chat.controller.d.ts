import { ChatService } from './chat.service';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';
export declare class ChatController {
    private readonly chatService;
    constructor(chatService: ChatService);
    createGroup(req: AuthenticatedRequest, name: string): Promise<{
        name: string;
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        isGroup: boolean;
    }>;
    addMember(groupId: string, userId: string): Promise<{
        id: string;
        role: string;
        userId: string;
        joinedAt: Date;
        groupId: string;
    }>;
    getMyGroups(req: AuthenticatedRequest): Promise<({
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
    getGroupMessages(groupId: string): Promise<({
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
    getDirectMessages(req: AuthenticatedRequest, otherUserId: string): Promise<({
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
}
