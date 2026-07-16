import { Module } from '@nestjs/common';
import { APP_GUARD } from '@nestjs/core';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module';
import { AuthModule } from './auth/auth.module';
import { JwtAuthGuard } from './common/guards/jwt-auth.guard';
import { SchoolScopeGuard } from './common/guards/school-scope.guard';
import { SchoolsModule } from './schools/schools.module';
import { UsersModule } from './users/users.module';
import { AcademicsModule } from './academics/academics.module';
import { SubjectsModule } from './subjects/subjects.module';
import { StudentsModule } from './students/students.module';
import { TransportModule } from './transport/transport.module';
import { AttendanceModule } from './attendance/attendance.module';
import { FeesModule } from './fees/fees.module';
import { AssignmentsModule } from './assignments/assignments.module';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';
import { ExamsModule } from './exams/exams.module';
import { ChatModule } from './chat/chat.module';
import { SuperadminModule } from './superadmin/superadmin.module';
import { AdmissionsModule } from './admissions/admissions.module';
import { InventoryModule } from './inventory/inventory.module';
import { AnalyticsModule } from './analytics/analytics.module';
import { CctvModule } from './cctv/cctv.module';
import { HrModule } from './hr/hr.module';
import { ScheduleModule } from '@nestjs/schedule';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, '..', 'uploads'),
      serveRoot: '/uploads',
    }),
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    ScheduleModule.forRoot(),
    PrismaModule,
    AuthModule,
    SchoolsModule,
    UsersModule,
    AcademicsModule,
    SubjectsModule,
    StudentsModule,
    TransportModule,
    AttendanceModule,
    FeesModule,
    AssignmentsModule,
    ExamsModule,
    ChatModule,
    SuperadminModule,
    AdmissionsModule,
    InventoryModule,
    AnalyticsModule,
    CctvModule,
    HrModule,
  ],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: APP_GUARD,
      useClass: JwtAuthGuard,
    },
    {
      provide: APP_GUARD,
      useClass: SchoolScopeGuard,
    },
  ],
})
export class AppModule {}
