import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async create(createUserDto: CreateUserDto) {
    if (createUserDto.email) {
      const existingUser = await this.prisma.user.findUnique({
        where: { email: createUserDto.email },
      });
      if (existingUser) {
        throw new BadRequestException('Email already in use');
      }
    }

    if (createUserDto.username) {
      const existingUser = await this.prisma.user.findUnique({
        where: { username: createUserDto.username },
      });
      if (existingUser) {
        throw new BadRequestException('Username already in use');
      }
    }

    const rawPassword = createUserDto.password || 'Vortiqen@123';
    const hashedPassword = await bcrypt.hash(rawPassword, 10);

    return this.prisma.user.create({
      data: {
        ...createUserDto,
        password: hashedPassword,
      },
      select: {
        id: true,
        username: true,
        email: true,
        name: true,
        role: true,
        status: true,
        schoolId: true,
      }
    });
  }

  async findAll(schoolId?: string, role?: string) {
    const whereClause: any = {};
    if (schoolId) whereClause.schoolId = schoolId;
    if (role) whereClause.role = role;
    
    return this.prisma.user.findMany({
      where: whereClause,
      select: {
        id: true,
        username: true,
        email: true,
        name: true,
        role: true,
        status: true,
        schoolId: true,
        createdAt: true,
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async findOne(id: string) {
    const user = await this.prisma.user.findUnique({
      where: { id },
      select: {
        id: true,
        username: true,
        email: true,
        name: true,
        role: true,
        status: true,
        schoolId: true,
      },
    });
    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }
    return user;
  }

  async update(id: string, updateUserDto: UpdateUserDto) {
    await this.findOne(id);

    const updateData: any = { ...updateUserDto };
    if (updateUserDto.password) {
      updateData.password = await bcrypt.hash(updateUserDto.password, 10);
    }

    return this.prisma.user.update({
      where: { id },
      data: updateData,
      select: {
        id: true,
        username: true,
        email: true,
        name: true,
        role: true,
        status: true,
      }
    });
  }

  async remove(id: string) {
    await this.findOne(id);
    return this.prisma.user.delete({
      where: { id },
    });
  }

  async findByEmailForAuth(email: string) {
    return this.prisma.user.findFirst({
      where: {
        OR: [
          { email: email },
          { username: email }
        ]
      },
    });
  }
}
