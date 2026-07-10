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
  if (filePath.endsWith('.controller.spec.ts')) {
    let content = fs.readFileSync(filePath, 'utf8');
    
    const controllerMatch = content.match(/controllers: \[([^\]]+)\]/);
    if (controllerMatch) {
      const controllerName = controllerMatch[1].trim();
      const serviceName = controllerName.replace('Controller', 'Service');
      
      // Add import if missing from the top imports
      if (!content.includes(`import { ${serviceName} }`)) {
          const fileName = path.basename(filePath).replace('.controller.spec.ts', '.service');
          content = `import { ${serviceName} } from './${fileName}';\n` + content;
      }

      fs.writeFileSync(filePath, content, 'utf8');
      console.log('Fixed imports in', filePath);
    }
  }
});

// Fix AppController spec
let appSpecPath = './src/app.controller.spec.ts';
let appSpec = fs.readFileSync(appSpecPath, 'utf8');
if (appSpec.includes('useValue: {}')) {
    appSpec = appSpec.replace('useValue: {}', "useValue: { getHello: () => 'Hello World!' }");
    fs.writeFileSync(appSpecPath, appSpec, 'utf8');
}
