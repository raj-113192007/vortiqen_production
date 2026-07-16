import { ExtractJwt, Strategy } from 'passport-jwt';
import { PassportStrategy } from '@nestjs/passport';
import { Injectable } from '@nestjs/common';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor() {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey:
        process.env.JWT_SECRET || 'super-secret-key-change-me-in-prod',
    });
  }

  validate(payload: Record<string, unknown>) {
    // This payload is attached to the Request object as request.user
    return {
      id: payload.sub as string,
      email: payload.email as string,
      role: payload.role as string,
      schoolId: (payload.schoolId as string | undefined) || null,
    };
  }
}
