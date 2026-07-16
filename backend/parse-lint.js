const fs = require('fs');

let content = fs.readFileSync('lint_report.json', 'utf16le');
if (content.charCodeAt(0) === 0xFEFF) {
  content = content.slice(1);
}
const report = JSON.parse(content);

let totalErrors = 0;
report.forEach(file => {
  if (file.errorCount > 0 || file.warningCount > 0) {
    console.log(`File: ${file.filePath} - Errors: ${file.errorCount}, Warnings: ${file.warningCount}`);
    totalErrors += file.errorCount;
  }
});
console.log(`\nTotal Errors: ${totalErrors}`);
