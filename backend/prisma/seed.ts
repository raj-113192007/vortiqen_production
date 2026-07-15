import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcrypt';

const prisma = new PrismaClient();

async function main() {
  console.log('Seeding database...');

  // Create Test School
  const school = await prisma.school.upsert({
    where: { id: 'test-school-01' },
    update: {},
    create: {
      id: 'test-school-01',
      name: 'Vortiqen Test School',
      code: 'VTS01',
      address: '123 Tech Lane, Innovation City',
      status: 'ACTIVE',
    },
  });

  console.log(`School created: ${school.name}`);

  // Create Super Admin User
  const hashedPassword = await bcrypt.hash('password123', 10);
  
  const admin = await prisma.user.upsert({
    where: { email: 'admin@vortiqen.com' },
    update: {},
    create: {
      email: 'admin@vortiqen.com',
      password: hashedPassword,
      name: 'Super Admin',
      role: 'SUPER_ADMIN',
      schoolId: school.id,
      status: 'ACTIVE',
    },
  });

  console.log(`User created: ${admin.email} (SUPER_ADMIN)`);

  // Create Test School Admin User
  const schoolAdmin = await prisma.user.upsert({
    where: { email: 'schooladmin@vortiqen.com' },
    update: {},
    create: {
      email: 'schooladmin@vortiqen.com',
      password: hashedPassword,
      name: 'Principal Sharma',
      role: 'SCHOOL_ADMIN',
      schoolId: school.id,
      status: 'ACTIVE',
    },
  });
  console.log(`User created: ${schoolAdmin.email} (SCHOOL_ADMIN)`);

  // Create Test Teacher User
  const teacher = await prisma.user.upsert({
    where: { email: 'teacher@vortiqen.com' },
    update: {},
    create: {
      email: 'teacher@vortiqen.com',
      password: hashedPassword,
      name: 'Raj Teacher',
      role: 'TEACHER',
      schoolId: school.id,
      status: 'ACTIVE',
    },
  });
  console.log(`User created: ${teacher.email} (TEACHER)`);

  // Create Test Student User
  const student = await prisma.user.upsert({
    where: { email: 'student@vortiqen.com' },
    update: {},
    create: {
      email: 'student@vortiqen.com',
      password: hashedPassword,
      name: 'Rahul Student',
      role: 'STUDENT',
      schoolId: school.id,
      status: 'ACTIVE',
    },
  });
  console.log(`User created: ${student.email} (STUDENT)`);

  // Create Test Driver User
  const driver = await prisma.user.upsert({
    where: { email: 'driver@vortiqen.com' },
    update: {},
    create: {
      email: 'driver@vortiqen.com',
      password: hashedPassword,
      name: 'Ramesh Driver',
      role: 'DRIVER',
      schoolId: school.id,
      status: 'ACTIVE',
    },
  });

  console.log(`User created: ${driver.email} (DRIVER)`);

  const existingVehicle = await prisma.vehicle.findUnique({
    where: { driverId: driver.id }
  });
  
  if (!existingVehicle) {
    const vehicle = await prisma.vehicle.create({
      data: {
        plateNumber: 'DL-10-AB-1234',
        capacity: 40,
        schoolId: school.id,
        driverId: driver.id,
      },
    });
    console.log(`Vehicle created: ${vehicle.plateNumber}`);
  }
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
