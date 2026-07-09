export class CreateSchoolDto {
  name: string;
  code?: string;
  address?: string;
  city?: string;
  state?: string;

  adminName?: string;
  adminUsername?: string;
  adminPassword?: string;
}
