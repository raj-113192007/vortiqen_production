import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:go_router/go_router.dart';

class AddSchoolScreen extends ConsumerStatefulWidget {
  const AddSchoolScreen({super.key});

  @override
  ConsumerState<AddSchoolScreen> createState() => _AddSchoolScreenState();
}

class _AddSchoolScreenState extends ConsumerState<AddSchoolScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // School Details
  String _name = '';
  String _code = '';
  String _address = '';

  // Admin Details
  String _adminName = '';
  String _adminUsername = '';
  String _adminPassword = '';

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _isLoading = true);
    try {
      await ref.read(schoolsRepositoryProvider).createSchool({
        'name': _name,
        'code': _code,
        'address': _address,
        'adminName': _adminName,
        'adminUsername': _adminUsername,
        'adminPassword': _adminPassword,
      });
      if (mounted) {
        ref.invalidate(schoolsProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('School & Admin Account Created Successfully!')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New School')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('School Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomTextField(
                          label: 'School Name',
                          onSaved: (v) => _name = v ?? '',
                          validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          label: 'School Code (e.g. VTS01)',
                          onSaved: (v) => _code = v ?? '',
                          validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Address',
                    onSaved: (v) => _address = v ?? '',
                  ),
                  
                  const SizedBox(height: 48),
                  
                  const Text('Initial School Admin', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('This account will be used by the school to configure their portal.', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Admin Name',
                    onSaved: (v) => _adminName = v ?? '',
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          label: 'Admin Username',
                          onSaved: (v) => _adminUsername = v ?? '',
                          validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          label: 'Admin Password',
                          obscureText: true,
                          onSaved: (v) => _adminPassword = v ?? '',
                          validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    onPressed: _isLoading ? null : _submit,
                    text: 'Register School & Create Admin',
                    isLoading: _isLoading,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.label,
    this.onSaved,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      onSaved: onSaved,
      validator: validator,
      obscureText: obscureText,
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: isLoading ? const CircularProgressIndicator() : Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}
