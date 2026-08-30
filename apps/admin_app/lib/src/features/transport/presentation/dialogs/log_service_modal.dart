import 'package:flutter/material.dart';

class LogServiceModal extends StatefulWidget {
  final Function(Map<String, String>) onSave;

  const LogServiceModal({
    super.key,
    required this.onSave,
  });

  @override
  State<LogServiceModal> createState() => _LogServiceModalState();
}

class _LogServiceModalState extends State<LogServiceModal> {
  final _formKey = GlobalKey<FormState>();
  final _busNumberController = TextEditingController(text: 'DL 01 PB 4488 (Bus #04)');
  final _serviceTypeController = TextEditingController(text: 'Periodic 50K Engine & Brake Overhaul');
  final _serviceCenterController = TextEditingController(text: 'Tata Authorized Service Center, Mayapuri');
  final _costController = TextEditingController(text: '₹ 14,800');

  @override
  void dispose() {
    _busNumberController.dispose();
    _serviceTypeController.dispose();
    _serviceCenterController.dispose();
    _costController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 480,
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
                      Icon(Icons.build_rounded, color: Color(0xFF6C5CE7), size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Log Servicing & Maintenance',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF1E293B)),
                      ),
                    ],
                  ),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded)),
                ],
              ),
              const SizedBox(height: 18),

              TextFormField(
                controller: _busNumberController,
                decoration: const InputDecoration(labelText: 'Bus Plate Number', border: OutlineInputBorder()),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _serviceTypeController,
                decoration: const InputDecoration(labelText: 'Service Type / Work Done', border: OutlineInputBorder()),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _serviceCenterController,
                      decoration: const InputDecoration(labelText: 'Workshop / Center', border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _costController,
                      decoration: const InputDecoration(labelText: 'Service Invoice (₹)', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSave({
                          'busNumber': _busNumberController.text,
                          'serviceType': _serviceTypeController.text,
                          'center': _serviceCenterController.text,
                          'cost': _costController.text,
                        });
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C5CE7),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Log Record'),
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
