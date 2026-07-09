import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';

class CreateAssignmentScreen extends ConsumerStatefulWidget {
  const CreateAssignmentScreen({super.key});

  @override
  ConsumerState<CreateAssignmentScreen> createState() => _CreateAssignmentScreenState();
}

class _CreateAssignmentScreenState extends ConsumerState<CreateAssignmentScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String? _selectedClassId;
  String? _selectedSectionId;
  String? _selectedSubjectId;
  String _title = '';
  String _description = '';
  DateTime? _dueDate;
  PlatformFile? _attachment;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _attachment = result.files.first;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedSectionId == null || _selectedSubjectId == null || _dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select all required fields and due date')));
      return;
    }

    _formKey.currentState!.save();
    setState(() => _isLoading = true);
    
    try {
      await ref.read(assignmentsRepositoryProvider).createAssignment(
        sectionId: _selectedSectionId!,
        subjectId: _selectedSubjectId!,
        title: _title,
        dueDate: _dueDate!.toIso8601String(),
        description: _description.isEmpty ? null : _description,
        file: _attachment,
      );
      
      if (mounted) {
        ref.invalidate(teacherAssignmentsProvider);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Assignment Created')));
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final classesAsync = ref.watch(classesProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Create Assignment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                label: 'Title',
                onSaved: (v) => _title = v ?? '',
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Description (Optional)',
                maxLines: 3,
                onSaved: (v) => _description = v ?? '',
              ),
              const SizedBox(height: 16),
              classesAsync.when(
                data: (classes) {
                  return DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Class'),
                    value: _selectedClassId,
                    items: classes.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                    onChanged: (v) => setState(() {
                      _selectedClassId = v;
                      _selectedSectionId = null;
                      _selectedSubjectId = null;
                    }),
                  );
                },
                loading: () => const LinearProgressIndicator(),
                error: (e, st) => const Text('Failed to load classes'),
              ),
              const SizedBox(height: 16),
              if (_selectedClassId != null) ...[
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Section'),
                  value: _selectedSectionId,
                  items: ref.read(classesProvider).value!
                      .firstWhere((c) => c.id == _selectedClassId)
                      .sections
                      .map((s) => DropdownMenuItem(value: s.id, child: Text(s.name)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedSectionId = v),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Subject'),
                  value: _selectedSubjectId,
                  items: ref.read(classesProvider).value!
                      .firstWhere((c) => c.id == _selectedClassId)
                      .subjects
                      .map((s) => DropdownMenuItem(value: s.id, child: Text(s.name)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedSubjectId = v),
                ),
                const SizedBox(height: 16),
              ],
              ListTile(
                title: Text(_dueDate == null ? 'Select Due Date' : 'Due: ${_dueDate.toString().split(' ')[0]}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) setState(() => _dueDate = date);
                },
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(_attachment == null ? 'Attach PDF (Optional)' : 'Attached: ${_attachment!.name}'),
                trailing: const Icon(Icons.attach_file),
                onTap: _pickFile,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              if (_attachment != null)
                TextButton(
                  onPressed: () => setState(() => _attachment = null),
                  child: const Text('Remove Attachment', style: TextStyle(color: Colors.red)),
                ),
              const SizedBox(height: 32),
              PrimaryButton(
                onPressed: _isLoading ? null : _submit,
                text: 'Create Assignment',
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
