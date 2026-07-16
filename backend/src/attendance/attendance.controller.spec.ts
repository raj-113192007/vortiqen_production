import { AttendanceService } from './attendance.service';
import { Test, TestingModule } from '@nestjs/testing';
import { AttendanceController } from './attendance.controller';

describe('AttendanceController', () => {
  let controller: AttendanceController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [AttendanceController],
      providers: [{ provide: AttendanceService, useValue: {} }],
    }).compile();

    controller = module.get<AttendanceController>(AttendanceController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
