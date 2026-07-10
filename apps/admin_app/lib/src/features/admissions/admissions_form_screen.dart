import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'admissions_provider.dart';

class AdmissionsFormScreen extends ConsumerStatefulWidget {
  const AdmissionsFormScreen({super.key});

  @override
  ConsumerState<AdmissionsFormScreen> createState() => _AdmissionsFormScreenState();
}

class _AdmissionsFormScreenState extends ConsumerState<AdmissionsFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();
  final _parentNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _classAppliedController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _studentNameController.dispose();
    _parentNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _classAppliedController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final apiClient = ref.read(apiClientProvider);
      await apiClient.dio.post('/admissions/enquiry', data: {
        'studentName': _studentNameController.text,
        'parentName': _parentNameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text.isNotEmpty ? _emailController.text : null,
        'classApplied': _classAppliedController.text.isNotEmpty ? _classAppliedController.text : null,
      });
      ref.invalidate(admissionsProvider);
      if (mounted) context.go('/dashboard');
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
    return Scaffold(
      appBar: AppBar(title: const Text('New Admission Enquiry')),
      body: Center(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _studentNameController,
                  decoration: const InputDecoration(labelText: 'Student Name', border: OutlineInputBorder()),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _parentNameController,
                  decoration: const InputDecoration(labelText: 'Parent Name', border: OutlineInputBorder()),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email (Optional)', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _classAppliedController,
                  decoration: const InputDecoration(labelText: 'Class Applied (Optional)', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                  child: _isLoading 
                      ? const CircularProgressIndicator() 
                      : const Text('Save Enquiry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
