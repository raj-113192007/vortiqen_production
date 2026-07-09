import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:intl/intl.dart';

class FeesScreen extends ConsumerStatefulWidget {
  const FeesScreen({super.key});

  @override
  ConsumerState<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends ConsumerState<FeesScreen> {
  String? _selectedClassId;

  @override
  Widget build(BuildContext context) {
    final classesAsync = ref.watch(classesProvider);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fees Management',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Show generate fees dialog
                },
                icon: const Icon(Icons.receipt),
                label: const Text('Generate Fees'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Filters
          VortiqenCard(
            child: classesAsync.when(
              data: (classes) => DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Filter by Class (Optional)'),
                value: _selectedClassId,
                items: [
                  const DropdownMenuItem(value: null, child: Text('All Classes')),
                  ...classes.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))),
                ],
                onChanged: (val) {
                  setState(() {
                    _selectedClassId = val;
                  });
                },
              ),
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Error loading classes: $e'),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Data
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final ledgersAsync = ref.watch(feeLedgersProvider({
                  if (_selectedClassId != null) 'classId': _selectedClassId,
                }));

                return ledgersAsync.when(
                  data: (ledgers) {
                    if (ledgers.isEmpty) {
                      return const Center(child: Text('No fee records found.'));
                    }
                    
                    return ListView.builder(
                      itemCount: ledgers.length,
                      itemBuilder: (context, index) {
                        final ledger = ledgers[index];
                        final student = ledger.student;
                        final category = ledger.category;
                        
                        return Card(
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.payment),
                            ),
                            title: Text('${student?.firstName} ${student?.lastName ?? ''} - ${category?.name}'),
                            subtitle: Text('Due: \u20B9${ledger.amountDue} | Paid: \u20B9${ledger.amountPaid}'),
                            trailing: Chip(
                              label: Text(ledger.status),
                              backgroundColor: ledger.status == 'PAID' 
                                  ? Colors.green.withOpacity(0.2) 
                                  : ledger.status == 'PARTIAL' 
                                      ? Colors.orange.withOpacity(0.2)
                                      : Colors.red.withOpacity(0.2),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
