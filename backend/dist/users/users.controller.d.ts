import { UsersService } from './users.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
export declare class UsersController {
    private readonly usersService;
    constructor(usersService: UsersService);
    create(createUserDto: CreateUserDto): Promise<{
        name: string;
        id: string;
        schoolId: string | null;
        username: string | null;
        email: string | null;
        role: string;
        status: string;
    }>;
    findAll(schoolId?: string, role?: string): Promise<{
        name: string;
        id: string;
        schoolId: string | null;
        username: string | null;
        email: string | null;
        role: string;
        status: string;
        createdAt: Date;
    }[]>;
    findOne(id: string): Promise<{
        name: string;
        id: string;
        schoolId: string | null;
        username: string | null;
        email: string | null;
        role: string;
        status: string;
    }>;
    update(id: string, updateUserDto: UpdateUserDto): Promise<{
        name: string;
        id: string;
        username: string | null;
        email: string | null;
        role: string;
        status: string;
    }>;
    remove(id: string): Promise<{
        name: string;
        id: string;
        schoolId: string | null;
        username: string | null;
        email: string | null;
        phone: string | null;
        password: string;
        role: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        deletedAt: Date | null;
    }>;
}
