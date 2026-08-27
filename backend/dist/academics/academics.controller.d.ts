import { AcademicsService } from './academics.service';
import { CreateClassDto } from './dto/create-class.dto';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';
export declare class AcademicsController {
    private readonly academicsService;
    constructor(academicsService: AcademicsService);
    createClass(createDto: CreateClassDto, req: AuthenticatedRequest): Promise<{
        success: boolean;
        data: {
            sections: {
                name: string;
                id: string;
                createdAt: Date;
                updatedAt: Date;
                classId: string;
            }[];
        } & {
            name: string;
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
            monthlyFee: number;
        };
    }>;
    getClasses(req: AuthenticatedRequest): Promise<{
        success: boolean;
        data: ({
            sections: {
                name: string;
                id: string;
                createdAt: Date;
                updatedAt: Date;
                classId: string;
            }[];
        } & {
            name: string;
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
            monthlyFee: number;
        })[];
    }>;
}
