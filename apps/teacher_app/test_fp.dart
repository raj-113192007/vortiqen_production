import 'dart:mirrors';
import 'package:file_picker/file_picker.dart';

void main() {
  ClassMirror classMirror = reflectClass(FilePicker);
  for (var method in classMirror.staticMembers.values) {
    print(method.simpleName);
  }
}
