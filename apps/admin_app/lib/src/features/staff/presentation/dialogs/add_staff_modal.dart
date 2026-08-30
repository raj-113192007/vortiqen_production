import 'package:flutter/material.dart';

class AddStaffModal extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  const AddStaffModal({
    super.key,
    required this.onSave,
  });

  @override
  State<AddStaffModal> createState() => _AddStaffModalState();
}

class _AddStaffModalState extends State<AddStaffModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _designationController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String _department = 'Science & Math';
  final _roomController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _designationController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _roomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        width: 520,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.person_add_alt_1_rounded, color: Color(0xFF4F46E5), size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Register Faculty Member',
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: Color(0xFF1E293B)),
                      ),
                    ],
                  ),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded)),
                ],
              ),
              const SizedBox(height: 18),

              // Name & Designation
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Full Name', hintText: 'Dr. Rohit Sen', border: OutlineInputBorder()),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _designationController,
                      decoration: const InputDecoration(labelText: 'Designation', hintText: 'Senior Faculty', border: OutlineInputBorder()),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Department Dropdown
              DropdownButtonFormField<String>(
                initialValue: _department,
                decoration: const InputDecoration(labelText: 'Department', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'Science & Math', child: Text('Science & Math')),
                  DropdownMenuItem(value: 'Humanities & Languages', child: Text('Humanities & Languages')),
                  DropdownMenuItem(value: 'IT & Computer Science', child: Text('IT & Computer Science')),
                  DropdownMenuItem(value: 'Commerce & Economics', child: Text('Commerce & Economics')),
                  DropdownMenuItem(value: 'Sports & Arts', child: Text('Sports & Arts')),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _department = v);
                },
              ),
              const SizedBox(height: 12),

              // Email & Phone
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email Address', hintText: 'faculty@school.edu', border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Contact Phone', hintText: '+91 98111 XXXXX', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // Footer Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSave({
                          'name': _nameController.text,
                          'designation': _designationController.text,
                          'department': _department,
                          'email': _emailController.text,
                          'phone': _phoneController.text,
                        });
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F46E5),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Save Faculty'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
