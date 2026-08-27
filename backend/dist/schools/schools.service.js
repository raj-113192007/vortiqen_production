"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.SchoolsService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
const bcrypt = __importStar(require("bcrypt"));
let SchoolsService = class SchoolsService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async create(createSchoolDto) {
        const { adminName, adminUsername, adminPassword, ...schoolData } = createSchoolDto;
        return this.prisma.$transaction(async (tx) => {
            const school = await tx.school.create({
                data: schoolData,
            });
            if (adminName && adminUsername && adminPassword) {
                const hashedPassword = await bcrypt.hash(adminPassword, 10);
                await tx.user.create({
                    data: {
                        schoolId: school.id,
                        username: adminUsername,
                        name: adminName,
                        password: hashedPassword,
                        role: 'SCHOOL_ADMIN',
                    },
                });
            }
            return school;
        });
    }
    async findAll() {
        return this.prisma.school.findMany({
            orderBy: { createdAt: 'desc' },
        });
    }
    async findOne(id) {
        const school = await this.prisma.school.findUnique({
            where: { id },
            include: {
                users: {
                    select: { id: true, name: true, role: true, status: true },
                },
            },
        });
        if (!school) {
            throw new common_1.NotFoundException(`School with ID ${id} not found`);
        }
        return school;
    }
    async update(id, updateSchoolDto) {
        await this.findOne(id);
        return this.prisma.school.update({
            where: { id },
            data: updateSchoolDto,
        });
    }
    async remove(id) {
        await this.findOne(id);
        return this.prisma.school.delete({
            where: { id },
        });
    }
};
exports.SchoolsService = SchoolsService;
exports.SchoolsService = SchoolsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], SchoolsService);
//# sourceMappingURL=schools.service.js.map