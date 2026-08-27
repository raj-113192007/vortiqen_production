export interface JwtPayload {
    sub: string;
    email: string;
    role: string;
    schoolId?: string;
}
declare global {
    namespace Express {
        interface User extends JwtPayload {
        }
        interface Request {
            schoolId?: string;
        }
    }
}
