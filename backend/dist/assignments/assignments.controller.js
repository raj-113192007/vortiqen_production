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
exports.AssignmentsController = void 0;
const common_1 = require("@nestjs/common");
const assignments_service_1 = require("./assignments.service");
const create_assignment_dto_1 = require("./dto/create-assignment.dto");
const roles_guard_1 = require("../common/guards/roles.guard");
const roles_decorator_1 = require("../common/decorators/roles.decorator");
const platform_express_1 = require("@nestjs/platform-express");
const multer_1 = require("multer");
const path_1 = require("path");
const storage = (0, multer_1.diskStorage)({
    destination: './uploads/assignments',
    filename: (req, file, cb) => {
        const randomName = Array(32)
            .fill(null)
            .map(() => Math.round(Math.random() * 16).toString(16))
            .join('');
        cb(null, `${randomName}${(0, path_1.extname)(file.originalname)}`);
    },
});
let AssignmentsController = class AssignmentsController {
    assignmentsService;
    constructor(assignmentsService) {
        this.assignmentsService = assignmentsService;
    }
    create(createAssignmentDto, req, file) {
        const attachmentUrl = file
            ? `/uploads/assignments/${file.filename}`
            : undefined;
        return this.assignmentsService.create(createAssignmentDto, req.user.schoolId, req.user.userId, attachmentUrl);
    }
    findAllBySection(sectionId, req) {
        return this.assignmentsService.findAllBySection(sectionId, req.user.schoolId);
    }
    findAllByTeacher(req) {
        return this.assignmentsService.findAllByTeacher(req.user.userId, req.user.schoolId);
    }
    submitAssignment(id, studentId, content, file) {
        const attachmentUrl = file
            ? `/uploads/assignments/${file.filename}`
            : undefined;
        return this.assignmentsService.submitAssignment(id, studentId, content, attachmentUrl);
    }
    getSubmissions(id, req) {
        return this.assignmentsService.getSubmissions(id, req.user.schoolId);
    }
    gradeSubmission(submissionId, grade, teacherNotes) {
        return this.assignmentsService.gradeSubmission(submissionId, grade, teacherNotes);
    }
};
exports.AssignmentsController = AssignmentsController;
__decorate([
    (0, common_1.Post)(),
    (0, roles_decorator_1.Roles)('TEACHER'),
    (0, common_1.UseInterceptors)((0, platform_express_1.FileInterceptor)('file', { storage })),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Request)()),
    __param(2, (0, common_1.UploadedFile)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_assignment_dto_1.CreateAssignmentDto, Object, Object]),
    __metadata("design:returntype", void 0)
], AssignmentsController.prototype, "create", null);
__decorate([
    (0, common_1.Get)('section/:sectionId'),
    (0, roles_decorator_1.Roles)('TEACHER', 'STUDENT', 'PARENT'),
    __param(0, (0, common_1.Param)('sectionId')),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", void 0)
], AssignmentsController.prototype, "findAllBySection", null);
__decorate([
    (0, common_1.Get)('teacher'),
    (0, roles_decorator_1.Roles)('TEACHER'),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], AssignmentsController.prototype, "findAllByTeacher", null);
__decorate([
    (0, common_1.Post)(':id/submit'),
    (0, roles_decorator_1.Roles)('STUDENT', 'PARENT'),
    (0, common_1.UseInterceptors)((0, platform_express_1.FileInterceptor)('file', { storage })),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)('studentId')),
    __param(2, (0, common_1.Body)('content')),
    __param(3, (0, common_1.UploadedFile)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String, String, Object]),
    __metadata("design:returntype", void 0)
], AssignmentsController.prototype, "submitAssignment", null);
__decorate([
    (0, common_1.Get)(':id/submissions'),
    (0, roles_decorator_1.Roles)('TEACHER', 'SCHOOL_ADMIN'),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", void 0)
], AssignmentsController.prototype, "getSubmissions", null);
__decorate([
    (0, common_1.Patch)('submissions/:submissionId/grade'),
    (0, roles_decorator_1.Roles)('TEACHER'),
    __param(0, (0, common_1.Param)('submissionId')),
    __param(1, (0, common_1.Body)('grade')),
    __param(2, (0, common_1.Body)('teacherNotes')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String, String]),
    __metadata("design:returntype", void 0)
], AssignmentsController.prototype, "gradeSubmission", null);
exports.AssignmentsController = AssignmentsController = __decorate([
    (0, common_1.Controller)('assignments'),
    (0, common_1.UseGuards)(roles_guard_1.RolesGuard),
    __metadata("design:paramtypes", [assignments_service_1.AssignmentsService])
], AssignmentsController);
//# sourceMappingURL=assignments.controller.js.map