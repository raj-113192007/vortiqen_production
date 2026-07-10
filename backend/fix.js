const fs = require('fs');
const path = require('path');

function walkDir(dir, callback) {
  fs.readdirSync(dir).forEach(f => {
    let dirPath = path.join(dir, f);
    let isDirectory = fs.statSync(dirPath).isDirectory();
    isDirectory ? walkDir(dirPath, callback) : callback(path.join(dir, f));
  });
}

walkDir('./src', function(filePath) {
  if (filePath.endsWith('.spec.ts')) {
    let content = fs.readFileSync(filePath, 'utf8');
    if (content.includes('providers: [') && !content.includes('PrismaService')) {
      // We need to import PrismaService. Let's find the depth.
      const depth = filePath.split(path.sep).length - 2; // relative to src/
      let prefix = '';
      for (let i = 0; i < depth; i++) prefix += '../';
      if (prefix === '') prefix = './';
      const importStmt = `import { PrismaService } from '${prefix}prisma/prisma.service';\n`;
      
      content = importStmt + content;
      // Also add to providers
      content = content.replace(/providers:\s*\[(.*?)\]/g, (match, p1) => {
        return `providers: [${p1}, { provide: PrismaService, useValue: {} }]`;
      });
      fs.writeFileSync(filePath, content, 'utf8');
      console.log('Fixed', filePath);
    }
  }
});
