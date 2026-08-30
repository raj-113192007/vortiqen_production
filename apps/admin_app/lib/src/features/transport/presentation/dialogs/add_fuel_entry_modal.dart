import 'package:flutter/material.dart';

class AddFuelEntryModal extends StatefulWidget {
  final Function(Map<String, String>) onSave;

  const AddFuelEntryModal({
    super.key,
    required this.onSave,
  });

  @override
  State<AddFuelEntryModal> createState() => _AddFuelEntryModalState();
}

class _AddFuelEntryModalState extends State<AddFuelEntryModal> {
  final _formKey = GlobalKey<FormState>();
  final _busNumberController = TextEditingController(text: 'DL 01 PB 4488 (Bus #04)');
  final _litresController = TextEditingController();
  final _costController = TextEditingController();
  final _odometerController = TextEditingController();
  final _pumpController = TextEditingController(text: 'Indian Oil Corp Fuel Station');

  @override
  void dispose() {
    _busNumberController.dispose();
    _litresController.dispose();
    _costController.dispose();
    _odometerController.dispose();
    _pumpController.dispose();
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
                      Icon(Icons.local_gas_station_rounded, color: Color(0xFF0984E3), size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Log Fuel / Diesel Slip',
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

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _litresController,
                      decoration: const InputDecoration(labelText: 'Quantity (Litres)', hintText: '60 L', border: OutlineInputBorder()),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _costController,
                      decoration: const InputDecoration(labelText: 'Total Cost (₹)', hintText: '₹ 5,400', border: OutlineInputBorder()),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _odometerController,
                      decoration: const InputDecoration(labelText: 'Current Odometer (KM)', hintText: '48,500 KM', border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _pumpController,
                      decoration: const InputDecoration(labelText: 'Fuel Station / Pump', border: OutlineInputBorder()),
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
                          'litres': _litresController.text,
                          'cost': _costController.text.startsWith('₹') ? _costController.text : '₹ ${_costController.text}',
                          'odometer': _odometerController.text,
                          'fuelPump': _pumpController.text,
                        });
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0984E3),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Save Slip'),
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
