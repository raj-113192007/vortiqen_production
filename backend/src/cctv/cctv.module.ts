import { Module } from '@nestjs/common';
import { CctvController } from './cctv.controller';
import { CctvService } from './cctv.service';
import { PrismaModule } from '../prisma/prisma.module';

@Module({
  imports: [PrismaModule],
  controllers: [CctvController],
  providers: [CctvService],
})
export class CctvModule {}
