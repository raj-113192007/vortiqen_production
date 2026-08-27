import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';

const apps = [
  { name: 'admin_app', path: 'apps/admin_app', output: 'dist/admin', baseHref: '/admin/' },
  { name: 'teacher_app', path: 'apps/teacher_app', output: 'dist/teacher', baseHref: '/teacher/' },
  { name: 'student_app', path: 'apps/student_app', output: 'dist/student', baseHref: '/student/' },
  { name: 'parent_app', path: 'apps/parent_app', output: 'dist/parent', baseHref: '/parent/' },
  { name: 'driver_app', path: 'apps/driver_app', output: 'dist/driver', baseHref: '/driver/' },
  { name: 'director_app', path: 'apps/director_app', output: 'dist/director', baseHref: '/director/' },
  { name: 'superadmin_app', path: 'apps/superadmin_app', output: 'dist/superadmin', baseHref: '/superadmin/' },
];

console.log('🚀 Starting VortiQen Flutter Web Monorepo Build for Vercel...');

// Ensure dist directory exists
if (!fs.existsSync('dist')) {
  fs.mkdirSync('dist', { recursive: true });
}

// Check which apps to build (pass app name as arg, or build all)
const targetApp = process.argv[2];
const appsToBuild = targetApp ? apps.filter(a => a.name === targetApp || a.path.includes(targetApp)) : apps;

for (const app of appsToBuild) {
  console.log(`\n📦 Building ${app.name} (Base HREF: ${app.baseHref})...`);
  try {
    const cmd = `flutter build web --release --base-href ${app.baseHref}`;
    execSync(cmd, { cwd: app.path, stdio: 'inherit' });

    // Copy build output to dist/
    const srcBuild = path.join(app.path, 'build', 'web');
    const destDir = app.output;

    if (fs.existsSync(srcBuild)) {
      if (fs.existsSync(destDir)) {
        fs.rmSync(destDir, { recursive: true, force: true });
      }
      fs.cpSync(srcBuild, destDir, { recursive: true });
      console.log(`✅ ${app.name} successfully deployed to ${destDir}`);
    }
  } catch (err) {
    console.error(`❌ Failed to build ${app.name}:`, err.message);
  }
}

console.log('\n🎉 Build completed! Open dist/index.html or run "npx serve dist" to preview.');
