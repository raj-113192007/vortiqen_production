"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AcademicsService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let AcademicsService = class AcademicsService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async createClass(schoolId, createDto) {
        return this.prisma.academicClass.create({
            data: {
                schoolId,
                name: createDto.name,
                monthlyFee: createDto.monthlyFee || 0,
                sections: {
                    create: createDto.sections.map((section) => ({
                        name: section.name,
                    })),
                },
            },
            include: {
                sections: true,
            },
        });
    }
    async getClasses(schoolId) {
        return this.prisma.academicClass.findMany({
            where: { schoolId },
            include: {
                sections: {
                    orderBy: { name: 'asc' },
                },
            },
            orderBy: {
                name: 'asc',
            },
        });
    }
};
exports.AcademicsService = AcademicsService;
exports.AcademicsService = AcademicsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], AcademicsService);
//# sourceMappingURL=academics.service.js.map