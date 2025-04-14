import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:med_sync/core/constants/app_colors.dart';
import 'package:med_sync/features/application/provider/medicine_provider.dart';
import 'package:med_sync/features/domain/model/medicine_model.dart';
import 'package:med_sync/presentation/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class AddMedicinePage extends StatefulWidget {
  final DateTime selectedDate;

  const AddMedicinePage({
    super.key,
    required this.selectedDate,
  });

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

// class AddMedicinePage extends StatefulWidget {
//   const AddMedicinePage({super.key});

//   @override
//   State<AddMedicinePage> createState() => _AddMedicinePageState();
// }

class _AddMedicinePageState extends State<AddMedicinePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _selectedType;
  bool _alarmEnabled = true;
  TimeOfDay? _selectedTime;
  

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Add New Medicine'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fill out the fields and hit the Save Button to add it!',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Medicine Name Field
                      _buildSectionTitle('Name*'),
                      _buildTextField(
                        controller: _nameController,
                        hintText: 'Name (e.g. Ibuprofen)',
                        validator:
                            (value) =>
                                value?.isEmpty ?? true
                                    ? 'Please enter medicine name'
                                    : null,
                      ),
                      const SizedBox(height: 16),

                      // Medicine Type Dropdown
                      _buildSectionTitle('Type*'),
                      _buildTypeDropdown(),
                      const SizedBox(height: 16),

                      // Dose Field
                      _buildSectionTitle('Dose*'),
                      _buildTextField(
                        controller: _doseController,
                        hintText: 'Dose (e.g. 100mg)',
                        validator:
                            (value) =>
                                value?.isEmpty ?? true
                                    ? 'Please enter medicine dose'
                                    : null,
                      ),
                      const SizedBox(height: 16),

                      // Amount Field
                      _buildSectionTitle('Amount*'),
                      _buildTextField(
                        controller: _amountController,
                        hintText: 'Amount (e.g. 3)',
                        keyboardType: TextInputType.number,
                        validator:
                            (value) =>
                                value?.isEmpty ?? true
                                    ? 'Please enter amount'
                                    : null,
                      ),
                      const SizedBox(height: 24),

                      // Reminders Section
                      _buildSectionTitle('Reminders'),
                      const SizedBox(height: 8),
                      _buildDateField(),
                      const SizedBox(height: 16),

                      // Alarm Toggle
                      _buildAlarmToggle(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Save Button (always visible at bottom)
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.lightGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedType,
      decoration: _buildInputDecoration('Select Option'),
      items:
          _medicineTypes.map((type) {
            return DropdownMenuItem(value: type, child: Text(type));
          }).toList(),
      onChanged: (value) => setState(() => _selectedType = value),
      validator:
          (value) => value == null ? 'Please select medicine type' : null,
      style: TextStyle(color: AppColors.textPrimary),
      dropdownColor: Colors.white,
      icon: Icon(Icons.arrow_drop_down, color: AppColors.primary),
    );
  }

  Widget _buildDateField() {
    return InkWell(
      onTap: () => _selectDateTime(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _dateController.text.isEmpty
                  ? 'dd/mm/yyyy, 00:00'
                  : _dateController.text,
              style: TextStyle(
                color:
                    _dateController.text.isEmpty
                        ? Colors.grey.shade400
                        : AppColors.textPrimary,
              ),
            ),
            Icon(Icons.calendar_today, size: 20, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildAlarmToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGrey),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Turn on Alarm',
            style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
          ),
          Switch(
            value: _alarmEnabled,
            onChanged: (value) => setState(() => _alarmEnabled = value),
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: _saveMedicine,
        child: const Text(
          'Save Medicine',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.lightGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.lightGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        final now = DateTime.now();
        final formatted = DateFormat('dd/MM/yyyy, HH:mm').format(
          DateTime(
            now.year,
            now.month,
            now.day,
            pickedTime.hour,
            pickedTime.minute,
          ),
        );
        _dateController.text = formatted;
      });
    }
  }

  
void _saveMedicine() async {
  if (_formKey.currentState!.validate()) {
    final newMedicine = Medicine.withTimeOfDay(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      dosage:
          '${_amountController.text} ${_selectedType?.toLowerCase() ?? ''}, ${_doseController.text}',
      type: _mapType(_selectedType),
      time: _selectedTime ?? TimeOfDay.now(),
    );

    // Save medicine to Hive and update the provider
    await context.read<MedicineProvider>().addMedicine(newMedicine);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Medicine saved successfully!'),
        backgroundColor: AppColors.primary,
      ),
    );

    Navigator.pop(context); // Return to the previous page
  }
}



  MedicineType _mapType(String? type) {
    switch (type?.toLowerCase()) {
      case 'capsule':
        return MedicineType.capsule;
      case 'drop':
        return MedicineType.drops;
      case 'tablet':
        return MedicineType.tablet;
      default:
        return MedicineType.capsule;
    }
  }
}
