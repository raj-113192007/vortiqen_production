const fs = require('fs');
const path = require('path');
const glob = require('glob'); // Not available? We can just use basic recursion.

function findFiles(dir, filter, fileList = []) {
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const stat = fs.statSync(path.join(dir, file));
    if (stat.isDirectory()) {
      findFiles(path.join(dir, file), filter, fileList);
    } else if (filter.test(file)) {
      fileList.push(path.join(dir, file));
    }
  }
  return fileList;
}

const controllerFiles = findFiles('./src', /\.controller\.ts$/);

controllerFiles.forEach(file => {
  let content = fs.readFileSync(file, 'utf8');
  if (content.includes('@Request() req: any')) {
    // Check if AuthenticatedRequest is imported
    if (!content.includes('AuthenticatedRequest')) {
      // Find the last import
      const lastImportIndex = content.lastIndexOf('import ');
      const endOfLastImport = content.indexOf(';', lastImportIndex) + 1;
      
      // Calculate relative path to src/common/interfaces/authenticated-request.interface
      const fileDir = path.dirname(file);
      let relativePath = path.relative(fileDir, './src/common/interfaces/authenticated-request.interface');
      relativePath = relativePath.replace(/\\/g, '/');
      if (!relativePath.startsWith('.')) {
        relativePath = './' + relativePath;
      }
      
      const importStatement = `\nimport { AuthenticatedRequest } from '${relativePath}';`;
      content = content.slice(0, endOfLastImport) + importStatement + content.slice(endOfLastImport);
    }
    
    // Replace all occurrences of req: any with req: AuthenticatedRequest
    content = content.replace(/@Request\(\) req: any/g, '@Request() req: AuthenticatedRequest');
    
    fs.writeFileSync(file, content, 'utf8');
    console.log(`Updated ${file}`);
  }
});
