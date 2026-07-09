import { CanActivate, ExecutionContext, Injectable, ForbiddenException } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { IS_PUBLIC_KEY } from '../decorators/public.decorator';

@Injectable()
export class SchoolScopeGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const isPublic = this.reflector.getAllAndOverride<boolean>(IS_PUBLIC_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);
    
    if (isPublic) {
      return true;
    }

    const request = context.switchToHttp().getRequest();
    const user = request.user;

    // If no user is attached (e.g., JwtAuthGuard wasn't applied or failed silently), block.
    if (!user) {
      throw new ForbiddenException('Access Denied: Missing authentication context.');
    }

    // SuperAdmins bypass school scope isolation
    if (user.role === 'SUPER_ADMIN') {
      return true;
    }

    // All other roles MUST be bound to a school
    if (!user.schoolId) {
      throw new ForbiddenException('Access Denied: User is not associated with a school context.');
    }

    // Attach schoolId directly to the request for easier access downstream
    request.schoolId = user.schoolId;

    return true;
  }
}
