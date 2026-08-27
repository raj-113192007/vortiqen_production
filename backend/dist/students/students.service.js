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
exports.StudentsService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
const bcrypt = __importStar(require("bcrypt"));
let StudentsService = class StudentsService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async create(createStudentDto) {
        const studentUser = await this.prisma.user.create({
            data: {
                schoolId: createStudentDto.schoolId,
                username: createStudentDto.studentUsername,
                name: `${createStudentDto.firstName} ${createStudentDto.lastName || ''}`.trim(),
                password: await bcrypt.hash(createStudentDto.password || 'Student@123', 10),
                role: 'STUDENT',
            },
        });
        const parentUser = await this.prisma.user.create({
            data: {
                schoolId: createStudentDto.schoolId,
                username: createStudentDto.parentUsername,
                name: `${createStudentDto.firstName}'s Parent`,
                password: await bcrypt.hash(createStudentDto.password || 'Parent@123', 10),
                role: 'PARENT',
            },
        });
        return this.prisma.student.create({
            data: {
                schoolId: createStudentDto.schoolId,
                classId: createStudentDto.classId,
                sectionId: createStudentDto.sectionId,
                userId: studentUser.id,
                parentId: parentUser.id,
                rollNo: createStudentDto.rollNo,
                firstName: createStudentDto.firstName,
                lastName: createStudentDto.lastName,
                gender: createStudentDto.gender,
            },
            include: {
                user: { select: { id: true, username: true } },
                parent: { select: { id: true, username: true } },
                academicClass: { select: { id: true, name: true } },
                section: { select: { id: true, name: true } },
            },
        });
    }
    async findAll(schoolId, classId, sectionId, parentId, userId) {
        const where = { schoolId };
        if (classId)
            where.classId = classId;
        if (sectionId)
            where.sectionId = sectionId;
        if (parentId)
            where.parentId = parentId;
        if (userId)
            where.userId = userId;
        return this.prisma.student.findMany({
            where,
            include: {
                academicClass: { select: { id: true, name: true } },
                section: { select: { id: true, name: true } },
                user: { select: { id: true, username: true, status: true } },
                parent: { select: { id: true, username: true, status: true } },
            },
            orderBy: { rollNo: 'asc' },
        });
    }
    async findOne(id) {
        const student = await this.prisma.student.findUnique({
            where: { id },
            include: {
                academicClass: true,
                section: true,
                user: { select: { id: true, username: true, status: true } },
                parent: { select: { id: true, username: true, status: true } },
            },
        });
        if (!student)
            throw new common_1.NotFoundException('Student not found');
        return student;
    }
};
exports.StudentsService = StudentsService;
exports.StudentsService = StudentsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], StudentsService);
//# sourceMappingURL=students.service.js.map