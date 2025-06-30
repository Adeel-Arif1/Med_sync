import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:med_sync/core/constants/app_colors.dart';
import 'package:med_sync/features/application/provider/medicine_provider.dart';
import 'package:med_sync/features/domain/model/medicine_model.dart';
import 'package:med_sync/presentation/screens/add_med_screen.dart';
import 'package:med_sync/presentation/screens/medinfo_screen.dart';
import 'package:med_sync/presentation/widgets/date_selector.dart';
import 'package:med_sync/presentation/widgets/medicine_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _loadMedicines();
  }

  Future<void> _loadMedicines() async {
    await Provider.of<MedicineProvider>(context, listen: false).loadMedicines();
    Future.delayed(Duration(milliseconds: 500), () {
      final provider = Provider.of<MedicineProvider>(context, listen: false);
      print("🚀 Loaded medicines on app start:");
      provider.medicines.forEach((med) {
        print(
          "• ${med.name} - ${med.dosage} - ${med.time.format(context)} - Taken: ${med.isTaken}",
        );
      });
    });
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

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: _navigateToAddMedicine,
      backgroundColor: AppColors.primary,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  Widget _buildIntakeStatus() {
    return Consumer<MedicineProvider>(
      builder: (context, medicineProvider, _) {
        int takenCount =
            medicineProvider.medicines.where((med) => med.isTaken).length;
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
                      text: '$takenCount',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                    TextSpan(
                      text: '/${medicineProvider.medicines.length} Completed',
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
      },
    );
  }

  Widget _buildMedicineList() {
    return Consumer<MedicineProvider>(
      builder: (context, medicineProvider, _) {
        final filteredMedicines = medicineProvider.medicines;
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: filteredMedicines.length,
          itemBuilder: (context, index) {
            final medicine = filteredMedicines[index];
            return Dismissible(
              key: Key(medicine.id),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.delete, color: Colors.white, size: 28),
              ),
              onDismissed: (_) {
                Provider.of<MedicineProvider>(context, listen: false)
                    .deleteMedicine(medicine);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${medicine.name} deleted')),
                );
              },
              child: MedicineCard(
                medicine: medicine,
                onMarkTaken: () => _navigateToInfoScreen(medicine),
                onEdit: () => _navigateToEditMedicine(medicine),
              ),
            );
          },
        );
      },
    );
  }

  void _navigateToInfoScreen(Medicine medicine) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MedicineInfoScreen(
          medicine: medicine,
          selectedDate: _selectedDate,
        ),
      ),
    );
  }

  void _navigateToAddMedicine() async {
    final newMedicine = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddMedicinePage(selectedDate: _selectedDate),
      ),
    );
    if (newMedicine != null) {
      final provider = Provider.of<MedicineProvider>(context, listen: false);
      provider.addMedicine(newMedicine);
      print("✅ Added new medicine: ${newMedicine.name}");
      Future.delayed(Duration(milliseconds: 500), () {
        print("📦 Medicines in Provider after add:");
        provider.medicines.forEach((med) {
          print(
            "• ${med.name} - ${med.dosage} - ${med.time.format(context)} - Taken: ${med.isTaken}",
          );
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Medicine saved successfully!')),
      );
    }
  }

  void _navigateToEditMedicine(Medicine medicine) async {
    final updatedMedicine = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddMedicinePage(
          selectedDate: _selectedDate,
          existingMedicine: medicine,
        ),
      ),
    );
    if (updatedMedicine != null) {
      final provider = Provider.of<MedicineProvider>(context, listen: false);
      provider.updateMedicine(updatedMedicine);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${updatedMedicine.name} updated')),
      );
    }
  }
}