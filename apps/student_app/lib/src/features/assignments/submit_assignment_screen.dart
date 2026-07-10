import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart' as fp;

class SubmitAssignmentScreen extends ConsumerStatefulWidget {
  final String assignmentId;

  const SubmitAssignmentScreen({super.key, required this.assignmentId});

  @override
  ConsumerState<SubmitAssignmentScreen> createState() => _SubmitAssignmentScreenState();
}

class _SubmitAssignmentScreenState extends ConsumerState<SubmitAssignmentScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _content = '';
  fp.PlatformFile? _attachment;

  Future<void> _pickFile() async {
    fp.FilePickerResult? result = await fp.FilePicker.pickFiles(
      type: fp.FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _attachment = result.files.first;
      });
    }
  }

  Future<void> _submit(Student student) async {
    if (!_formKey.currentState!.validate()) return;
    if (_attachment == null && _content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please attach a file or add content')));
      return;
    }

    _formKey.currentState!.save();
    setState(() => _isLoading = true);
    
    try {
      await ref.read(assignmentsRepositoryProvider).submitAssignment(
        assignmentId: widget.assignmentId,
        studentId: student.id,
        content: _content.isEmpty ? null : _content,
        file: _attachment,
      );
      
      if (mounted) {
        ref.invalidate(assignmentSubmissionsProvider(widget.assignmentId));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Assignment Submitted')));
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
    final user = ref.watch(authProvider).value?.user;
    if (user == null || user.schoolId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    
    final studentAsync = ref.watch(studentProfileProvider({
      'schoolId': user.schoolId,
      'userId': user.id,
    }));
    
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Assignment')),
      body: studentAsync.when(
        data: (student) {
          if (student == null) return const Center(child: Text('Student not found'));

          // Using the current logic, we don't have the specific assignment details fetched here directly,
          // but we can assume we only submit. Real app should show the Assignment details.
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Submit your homework', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Notes (Optional)'),
                    maxLines: 4,
                    onSaved: (v) => _content = v ?? '',
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text(_attachment == null ? 'Attach PDF' : 'Attached: ${_attachment!.name}'),
                    trailing: const Icon(Icons.attach_file),
                    onTap: _pickFile,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.withValues(alpha: 0.5)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  if (_attachment != null)
                    TextButton(
                      onPressed: () => setState(() => _attachment = null),
                      child: const Text('Remove Attachment', style: TextStyle(color: Colors.red)),
                    ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _isLoading ? null : () => _submit(student),
                    child: _isLoading ? const CircularProgressIndicator() : const Text('Submit'),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

