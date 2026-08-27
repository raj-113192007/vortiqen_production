import { AuthService } from './auth.service';
import { SignInDto } from './dto/sign-in.dto';
export declare class AuthController {
    private authService;
    constructor(authService: AuthService);
    login(signInDto: SignInDto): Promise<{
        access_token: string;
        user: {
            id: string;
            email: string | null;
            name: string;
            role: string;
            schoolId: string | null;
            status: string;
        };
    }>;
}
