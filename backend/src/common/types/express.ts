import { Request } from 'express';

export interface JwtPayload {
  sub: string;
  email: string;
  role: string;
  schoolId?: string;
}

declare global {
  // eslint-disable-next-line @typescript-eslint/no-namespace
  namespace Express {
    // eslint-disable-next-line @typescript-eslint/no-empty-object-type
    interface User extends JwtPayload {}
    interface Request {
      schoolId?: string;
    }
  }
}
