import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_sync/core/constants/app_colors.dart';
import 'package:med_sync/features/domain/model/medicine_model.dart';
import 'package:med_sync/presentation/screens/add_med_screen.dart';
import 'package:med_sync/presentation/widgets/date_selector.dart';
import 'package:med_sync/presentation/widgets/medicine_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime _selectedDate;
  int _takenCount = 1;
  final List<Medicine> _medicines = [
    Medicine(
      id: '1',
      name: 'Vitamin D',
      dosage: '1 Capsule, 1000mg',
      time: TimeOfDay(hour: 9, minute: 41),
      type: MedicineType.capsule,
    ),
    Medicine(
      id: '2',
      name: 'B12 Drops',
      dosage: '5 Drops, 1200mg',
      time: TimeOfDay(hour: 6, minute: 13),
      type: MedicineType.drops,
      isTaken: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _calculateTakenCount();
  }

  void _calculateTakenCount() {
    _takenCount = _medicines.where((med) => med.isTaken).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      floatingActionButton: _buildFAB(),
      body: Column(
        children: [
          SizedBox(height: 25),
          DateSelector(
            selectedDate: _selectedDate,
            onDateSelected: (date) => setState(() => _selectedDate = date),
          ),
          _buildIntakeStatus(),
          Expanded(child: _buildMedicineList()),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Today',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      centerTitle: false,
      elevation: 2,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildIntakeStatus() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$_takenCount',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
                TextSpan(
                  text: '/${_medicines.length} Completed',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateFormat('MMMM d, y').format(DateTime.now()),
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicineList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _medicines.length,
      itemBuilder: (context, index) {
        final medicine = _medicines[index];
        return MedicineCard(
          medicine: medicine,
          onMarkTaken: () => _markAsTaken(medicine),
        );
      },
    );
  }

  void _markAsTaken(Medicine medicine) {
    setState(() {
      medicine.isTaken = true;
      _calculateTakenCount();
    });
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Icon(Icons.add, color: Colors.white, size: 28),
      onPressed: _navigateToAddMedicine,
    );
  }
void _navigateToAddMedicine() async {
  final newMedicine = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AddMedicinePage()),
  );

  if (newMedicine != null && newMedicine is Medicine) {
    setState(() {
      _medicines.add(newMedicine);
      _calculateTakenCount();
    });
  }
}

}
