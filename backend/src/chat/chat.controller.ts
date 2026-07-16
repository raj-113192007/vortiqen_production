import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  UseGuards,
  Request,
} from '@nestjs/common';
import { ChatService } from './chat.service';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';

@UseGuards(JwtAuthGuard)
@Controller('chat')
export class ChatController {
  constructor(private readonly chatService: ChatService) {}

  @Post('groups')
  createGroup(
    @Request() req: AuthenticatedRequest,
    @Body('name') name: string,
  ) {
    return this.chatService.createGroup(
      req.user.schoolId!,
      name,
      req.user.userId,
    );
  }

  @Post('groups/:id/members')
  addMember(@Param('id') groupId: string, @Body('userId') userId: string) {
    return this.chatService.addMemberToGroup(groupId, userId);
  }

  @Get('groups')
  getMyGroups(@Request() req: AuthenticatedRequest) {
    return this.chatService.getMyGroups(req.user.userId);
  }

  @Get('groups/:id/messages')
  getGroupMessages(@Param('id') groupId: string) {
    return this.chatService.getGroupMessages(groupId);
  }

  @Get('direct/:userId/messages')
  getDirectMessages(
    @Request() req: AuthenticatedRequest,
    @Param('userId') otherUserId: string,
  ) {
    return this.chatService.getDirectMessages(req.user.userId, otherUserId);
  }
}
