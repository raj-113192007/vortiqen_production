import { Request } from 'express';

export type AuthenticatedRequest = Request & {
  user: {
    userId: string;
    sub: string;
    email: string;
    role: string;
    schoolId: string | null;
  };
};
