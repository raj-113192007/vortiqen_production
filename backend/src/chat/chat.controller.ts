import { Controller, Get, Param, UseGuards, Request } from '@nestjs/common';
import { ChatService } from './chat.service';
import { RolesGuard } from '../common/guards/roles.guard';

@Controller('chat')
@UseGuards(RolesGuard)
export class ChatController {
  constructor(private readonly chatService: ChatService) {}

  @Get('contacts')
  getContacts(@Request() req) {
    const user = req.user;
    if (user.role === 'STUDENT') {
      return this.chatService.getStudentContacts(user.id, user.schoolId);
    } else if (user.role === 'TEACHER') {
      return this.chatService.getTeacherContacts(user.id, user.schoolId);
    }
    return [];
  }

  @Get('history/:otherUserId')
  getChatHistory(@Param('otherUserId') otherUserId: string, @Request() req) {
    return this.chatService.getChatHistory(req.user.schoolId, req.user.id, otherUserId);
  }
}
