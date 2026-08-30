import 'package:flutter/material.dart';

class AddVehicleModal extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  const AddVehicleModal({
    super.key,
    required this.onSave,
  });

  @override
  State<AddVehicleModal> createState() => _AddVehicleModalState();
}

class _AddVehicleModalState extends State<AddVehicleModal> {
  final _formKey = GlobalKey<FormState>();
  final _busNumberController = TextEditingController();
  final _modelController = TextEditingController();
  final _capacityController = TextEditingController(text: '40');
  final _routeController = TextEditingController();
  final _driverNameController = TextEditingController();
  final _driverPhoneController = TextEditingController();

  @override
  void dispose() {
    _busNumberController.dispose();
    _modelController.dispose();
    _capacityController.dispose();
    _routeController.dispose();
    _driverNameController.dispose();
    _driverPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                      Icon(Icons.directions_bus_filled_rounded, color: Color(0xFF6C5CE7), size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Register Fleet Bus & Route',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded)),
                ],
              ),
              const SizedBox(height: 18),

              // Bus Plate No & Model
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _busNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Plate Number',
                        hintText: 'DL 01 PB 8822',
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _capacityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Seating Capacity',
                        hintText: '40',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Bus Model
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(
                  labelText: 'Vehicle Model & Type',
                  hintText: 'Tata Starbus Ultra AC / Ashok Leyland',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),

              // Route Name
              TextFormField(
                controller: _routeController,
                decoration: const InputDecoration(
                  labelText: 'Route Name / Corridor',
                  hintText: 'Route 09: Vasant Kunj to Campus',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 14),

              // Driver Name & Phone
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _driverNameController,
                      decoration: const InputDecoration(
                        labelText: 'Driver Name',
                        hintText: 'Mr. Surendra Pal',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _driverPhoneController,
                      decoration: const InputDecoration(
                        labelText: 'Driver Phone',
                        hintText: '+91 98111 XXXXX',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Modal Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSave({
                          'busNumber': _busNumberController.text,
                          'model': _modelController.text.isEmpty ? 'Commercial Bus' : _modelController.text,
                          'capacity': int.tryParse(_capacityController.text) ?? 40,
                          'routeName': _routeController.text,
                          'driverName': _driverNameController.text.isEmpty ? 'Assigned Driver' : _driverNameController.text,
                          'driverPhone': _driverPhoneController.text,
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
                    child: const Text('Save Fleet Bus'),
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
