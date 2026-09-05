import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class ParentPtmBookingScreen extends StatefulWidget {
  final String childName;
  const ParentPtmBookingScreen({super.key, this.childName = 'Aarav Sharma'});

  @override
  State<ParentPtmBookingScreen> createState() => _ParentPtmBookingScreenState();
}

class _ParentPtmBookingScreenState extends State<ParentPtmBookingScreen> {
  String _selectedTeacher = 'Dr. Priya Verma (Physics & Class Teacher)';
  String _selectedSlot = '10:15 AM - 10:30 AM';
  String _meetingMode = 'IN_PERSON';
  final TextEditingController _agendaController = TextEditingController();

  final List<String> _availableTeachers = [
    'Dr. Priya Verma (Physics & Class Teacher)',
    'Mr. Anil Kapoor (Mathematics)',
    'Mrs. Kavita Roy (Chemistry)',
    'Ms. Sarah Jenkins (English Literature)',
    'Mr. Vikram Rathore (Physical Education)',
  ];

  final List<String> _slots = [
    '09:30 AM - 09:45 AM',
    '09:45 AM - 10:00 AM',
    '10:15 AM - 10:30 AM',
    '10:45 AM - 11:00 AM',
    '11:15 AM - 11:30 AM',
    '02:00 PM - 02:15 PM',
  ];

  final List<Map<String, dynamic>> _confirmedBookings = [
    {
      'id': 'ptm_101',
      'teacher': 'Dr. Priya Verma',
      'subject': 'Physics & Class Teacher',
      'date': '12 Sep 2026',
      'time': '10:15 AM - 10:30 AM',
      'mode': 'In-Person (Room 204)',
      'agenda': 'Term 1 progress review & Olympiad preparation guidance',
      'status': 'CONFIRMED',
    },
    {
      'id': 'ptm_102',
      'teacher': 'Mr. Anil Kapoor',
      'subject': 'Mathematics',
      'date': '12 Sep 2026',
      'time': '11:15 AM - 11:30 AM',
      'mode': 'Virtual Video Call',
      'agenda': 'Calculus problem-solving speed discussion',
      'status': 'CONFIRMED',
    },
  ];

  @override
  void dispose() {
    _agendaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Parent-Teacher Meeting (PTM)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Student: ${widget.childName} • Next PTM: 12 Sep 2026', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ResponsiveContainer(
          maxWidth: 1200,
          child: ResponsiveTwoPane(
            breakpoint: 860,
            leftFlex: 6,
            rightFlex: 5,
            leftPane: _buildBookingForm(),
            rightPane: _buildConfirmedSlots(),
          ),
        ),
      ),
    );
  }

  Widget _buildBookingForm() {
    return AnimatedCard(
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE2E8F0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Book 1-on-1 Consultation Slot', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
          const SizedBox(height: 6),
          Text('Reserve 15-minute dedicated slot for academic discussion', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
          const SizedBox(height: 20),
          const Text('Select Faculty / Subject Teacher', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedTeacher,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            items: _availableTeachers
                .map((t) => DropdownMenuItem(value: t, child: Text(t, style: const TextStyle(fontSize: 13))))
                .toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedTeacher = val);
            },
          ),
          const SizedBox(height: 16),
          const Text('Available Time Slots (Saturday, 12 Sep 2026)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _slots.map((slot) {
              final isSelected = _selectedSlot == slot;
              return ChoiceChip(
                label: Text(slot, style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : const Color(0xFF334155))),
                selected: isSelected,
                selectedColor: const Color(0xFF6366F1),
                backgroundColor: const Color(0xFFF1F5F9),
                onSelected: (val) {
                  if (val) setState(() => _selectedSlot = slot);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          const Text('Consultation Mode', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  value: 'IN_PERSON',
                  groupValue: _meetingMode,
                  title: const Text('In-Person (School)', style: TextStyle(fontSize: 13)),
                  contentPadding: EdgeInsets.zero,
                  onChanged: (val) => setState(() => _meetingMode = val!),
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  value: 'VIRTUAL',
                  groupValue: _meetingMode,
                  title: const Text('Virtual (Google Meet)', style: TextStyle(fontSize: 13)),
                  contentPadding: EdgeInsets.zero,
                  onChanged: (val) => setState(() => _meetingMode = val!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Discussion Agenda / Questions for Teacher', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 6),
          TextField(
            controller: _agendaController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'e.g. Inquire about science project deadlines and math problem-solving support...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('PTM Consultation Slot Booked Successfully!'),
                    backgroundColor: Color(0xFF10B981),
                  ),
                );
              },
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Confirm Appointment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmedSlots() {
    return AnimatedCard(
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE2E8F0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Confirmed Consultations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(4)),
                child: const Text('2 Booked', style: TextStyle(color: Color(0xFF16A34A), fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _confirmedBookings.length,
            separatorBuilder: (_, __) => const Divider(height: 24),
            itemBuilder: (context, index) {
              final b = _confirmedBookings[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(b['teacher'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(b['time'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF6366F1))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('${b['subject']} • ${b['date']}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(b['mode'].toString().contains('Virtual') ? Icons.videocam_outlined : Icons.room_outlined, size: 14, color: const Color(0xFF334155)),
                      const SizedBox(width: 4),
                      Text(b['mode'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(6)),
                    child: Text('Agenda: ${b['agenda']}', style: const TextStyle(fontSize: 11, color: Color(0xFF475569))),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to Google Calendar!')),
                          );
                        },
                        icon: const Icon(Icons.event, size: 14),
                        label: const Text('Add to Calendar', style: TextStyle(fontSize: 11)),
                      ),
                      if (b['mode'].toString().contains('Virtual')) ...[
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Launching Google Meet session...')),
                            );
                          },
                          icon: const Icon(Icons.video_call, size: 14),
                          label: const Text('Join Room', style: TextStyle(fontSize: 11)),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981), foregroundColor: Colors.white),
                        ),
                      ],
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
