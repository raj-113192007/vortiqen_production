import { JwtService } from '@nestjs/jwt';
import { PrismaService } from '../prisma/prisma.service';
import { User } from '@prisma/client';
export declare class AuthService {
    private prisma;
    private jwtService;
    constructor(prisma: PrismaService, jwtService: JwtService);
    validateUser(email: string, pass: string): Promise<Omit<User, 'password'> | null>;
    login(user: Omit<User, 'password'>): {
        access_token: string;
        user: {
            id: string;
            email: string | null;
            name: string;
            role: string;
            schoolId: string | null;
            status: string;
        };
    };
}
