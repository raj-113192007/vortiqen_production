import { SchoolsService } from './schools.service';
import { CreateSchoolDto } from './dto/create-school.dto';
import { UpdateSchoolDto } from './dto/update-school.dto';
export declare class SchoolsController {
    private readonly schoolsService;
    constructor(schoolsService: SchoolsService);
    create(createSchoolDto: CreateSchoolDto): Promise<{
        name: string;
        id: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        deletedAt: Date | null;
        code: string | null;
        address: string | null;
        city: string | null;
        state: string | null;
    }>;
    findAll(): Promise<{
        name: string;
        id: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        deletedAt: Date | null;
        code: string | null;
        address: string | null;
        city: string | null;
        state: string | null;
    }[]>;
    findOne(id: string): Promise<{
        users: {
            name: string;
            id: string;
            role: string;
            status: string;
        }[];
    } & {
        name: string;
        id: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        deletedAt: Date | null;
        code: string | null;
        address: string | null;
        city: string | null;
        state: string | null;
    }>;
    update(id: string, updateSchoolDto: UpdateSchoolDto): Promise<{
        name: string;
        id: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        deletedAt: Date | null;
        code: string | null;
        address: string | null;
        city: string | null;
        state: string | null;
    }>;
    remove(id: string): Promise<{
        name: string;
        id: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        deletedAt: Date | null;
        code: string | null;
        address: string | null;
        city: string | null;
        state: string | null;
    }>;
}
