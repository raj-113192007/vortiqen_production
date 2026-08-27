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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ExamsController = void 0;
const common_1 = require("@nestjs/common");
const exams_service_1 = require("./exams.service");
const create_exam_dto_1 = require("./dto/create-exam.dto");
const roles_guard_1 = require("../common/guards/roles.guard");
const roles_decorator_1 = require("../common/decorators/roles.decorator");
let ExamsController = class ExamsController {
    examsService;
    constructor(examsService) {
        this.examsService = examsService;
    }
    create(createExamDto, req) {
        return this.examsService.create(createExamDto, req.user.schoolId);
    }
    findAll(req) {
        return this.examsService.findAllBySchool(req.user.schoolId);
    }
    findOne(id, req) {
        return this.examsService.findOne(id, req.user.schoolId);
    }
    addExamSubject(id, dto, req) {
        return this.examsService.addExamSubject(id, dto, req.user.schoolId);
    }
    bulkSubmitResults(subjectId, dto, req) {
        return this.examsService.bulkSubmitResults(subjectId, dto, req.user.schoolId);
    }
    getStudentReportCard(studentId, req) {
        return this.examsService.getStudentReportCard(studentId, req.user.schoolId);
    }
};
exports.ExamsController = ExamsController;
__decorate([
    (0, common_1.Post)(),
    (0, roles_decorator_1.Roles)('SCHOOL_ADMIN', 'TEACHER'),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_exam_dto_1.CreateExamDto, Object]),
    __metadata("design:returntype", void 0)
], ExamsController.prototype, "create", null);
__decorate([
    (0, common_1.Get)(),
    (0, roles_decorator_1.Roles)('SCHOOL_ADMIN', 'TEACHER', 'STUDENT', 'PARENT'),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], ExamsController.prototype, "findAll", null);
__decorate([
    (0, common_1.Get)(':id'),
    (0, roles_decorator_1.Roles)('SCHOOL_ADMIN', 'TEACHER', 'STUDENT', 'PARENT'),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", void 0)
], ExamsController.prototype, "findOne", null);
__decorate([
    (0, common_1.Post)(':id/subjects'),
    (0, roles_decorator_1.Roles)('SCHOOL_ADMIN', 'TEACHER'),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __param(2, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, create_exam_dto_1.AddExamSubjectDto, Object]),
    __metadata("design:returntype", void 0)
], ExamsController.prototype, "addExamSubject", null);
__decorate([
    (0, common_1.Post)('subjects/:subjectId/marks'),
    (0, roles_decorator_1.Roles)('TEACHER', 'SCHOOL_ADMIN'),
    __param(0, (0, common_1.Param)('subjectId')),
    __param(1, (0, common_1.Body)()),
    __param(2, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, create_exam_dto_1.BulkSubmitExamResultsDto, Object]),
    __metadata("design:returntype", void 0)
], ExamsController.prototype, "bulkSubmitResults", null);
__decorate([
    (0, common_1.Get)('student/:studentId/report-card'),
    (0, roles_decorator_1.Roles)('SCHOOL_ADMIN', 'TEACHER', 'STUDENT', 'PARENT'),
    __param(0, (0, common_1.Param)('studentId')),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", void 0)
], ExamsController.prototype, "getStudentReportCard", null);
exports.ExamsController = ExamsController = __decorate([
    (0, common_1.Controller)('exams'),
    (0, common_1.UseGuards)(roles_guard_1.RolesGuard),
    __metadata("design:paramtypes", [exams_service_1.ExamsService])
], ExamsController);
//# sourceMappingURL=exams.controller.js.map