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
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
