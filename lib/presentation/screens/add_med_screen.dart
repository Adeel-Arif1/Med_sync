import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_sync/presentation/widgets/custom_appbar.dart';
import 'package:med_sync/presentation/widgets/custom_buttons.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({super.key});

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _selectedType;
  bool _alarmEnabled = true;

  final List<String> _medicineTypes = ['Capsule', 'Drop', 'Tablet'];

  @override
  void dispose() {
    _nameController.dispose();
    _doseController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Add New Medicine',),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: const Text(
                  'Fill out the fields and hit the Save \nButton to add it!',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              const SizedBox(height: 24),
              
              // Medicine Name Field
              _buildSectionTitle('Name*'),
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration('Name (e.g. Ibuprofen)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter medicine name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Medicine Type Dropdown
              _buildSectionTitle('Type*'),
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: _inputDecoration('Select Option'),
                items: _medicineTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select medicine type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Dose Field
              _buildSectionTitle('Dose*'),
              TextFormField(
                controller: _doseController,
                decoration: _inputDecoration('Dose (e.g. 100mg)'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter medicine dose';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Amount Field
              _buildSectionTitle('Amount*'),
              TextFormField(
                controller: _amountController,
                decoration: _inputDecoration('Amount (e.g. 3)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              
              // Reminders Section
              const Text(
                'Reminders',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              
              // Date Row
              InkWell(
                onTap: () => _selectDateTime(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _dateController.text.isEmpty
                            ? 'dd/mm/yyyy, 00:00'
                            : _dateController.text,
                        style: TextStyle(
                          color: _dateController.text.isEmpty
                              ? Colors.grey.shade400
                              : Colors.black,
                        ),
                      ),
                      const Icon(Icons.calendar_today, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Alarm Toggle Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Turn on Alarm',
                    style: TextStyle(fontSize: 16),
                  ),
                  Switch(
                    value: _alarmEnabled,
                    onChanged: (value) {
                      setState(() {
                        _alarmEnabled = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              // Save Button
        PrimaryButton(
                  text: 'Save Medicine',
                  onPressed: () {
                    // Add login logic
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      filled: true,
      fillColor: Colors.grey.shade50,
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      
      if (pickedTime != null) {
        setState(() {
          _dateController.text =
              '${DateFormat('dd/MM/yyyy').format(pickedDate)}, ${pickedTime.format(context)}';
        });
      }
    }
  }

  void _saveMedicine() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with saving
      final medicineData = {
        'name': _nameController.text,
        'type': _selectedType,
        'dose': _doseController.text,
        'amount': _amountController.text,
        'reminder': _dateController.text,
        'alarmEnabled': _alarmEnabled,
      };
      
      // TODO: Save to database or state management
      print(medicineData); // For testing
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medicine saved successfully!')),
      );
      
      // Optionally navigate back
      Navigator.pop(context);
    }
  }
}