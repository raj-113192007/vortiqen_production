import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import type { AuthenticatedRequest } from '../interfaces/authenticated-request.interface';

export const CurrentUser = createParamDecorator(
  (
    data: keyof AuthenticatedRequest['user'] | undefined,
    ctx: ExecutionContext,
  ) => {
    const request = ctx.switchToHttp().getRequest<AuthenticatedRequest>();
    const user = request.user;
    return data ? user?.[data] : user;
  },
);

export const CurrentSchoolId = createParamDecorator(
  (data: unknown, ctx: ExecutionContext): string | undefined => {
    const request = ctx
      .switchToHttp()
      .getRequest<AuthenticatedRequest & { schoolId?: string }>();
    return request.schoolId || request.user?.schoolId || undefined;
  },
);
