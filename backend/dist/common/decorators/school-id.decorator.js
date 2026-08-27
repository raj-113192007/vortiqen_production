"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.SchoolId = void 0;
const common_1 = require("@nestjs/common");
exports.SchoolId = (0, common_1.createParamDecorator)((data, ctx) => {
    const request = ctx.switchToHttp().getRequest();
    const user = request.user;
    return user?.schoolId || undefined;
});
//# sourceMappingURL=school-id.decorator.js.map