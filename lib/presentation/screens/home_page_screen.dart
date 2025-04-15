import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_sync/features/application/provider/medicine_provider.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    super.initState();
    
    _selectedDate = DateTime.now();

Future<void> _loadMedicines() async {
  await Provider.of<MedicineProvider>(context, listen: false).loadMedicines();
  // Debug prints can go here
      // Wait for provider to initialize then print
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
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: medicineProvider.medicines.length,
        itemBuilder: (context, index) {
          final medicine = medicineProvider.medicines[index];

          return Dismissible(
            key: Key(medicine.id), // Make sure id is unique in your model
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
                  .deleteMedicine(medicine); // ID-based delete
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${medicine.name} deleted')),
              );
            },
          child: MedicineCard(
  medicine: medicine,
  onMarkTaken: () => _markAsTaken(medicine, medicineProvider),
  onEdit: () => _navigateToEditMedicine(medicine),
),

          );
        },
      );
    },
  );
}


  void _markAsTaken(
    Medicine medicine,
    MedicineProvider medicineProvider,
  ) async {
    setState(() {
      medicine.isTaken = true;
    });

    // Update medicine status in the database and the provider
    await medicineProvider.updateMedicineStatus(medicine);
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
      MaterialPageRoute(builder: (context) => AddMedicinePage( selectedDate: _selectedDate, )),
    );

    if (newMedicine != null && newMedicine is Medicine) {
      final provider = Provider.of<MedicineProvider>(context, listen: false);
      provider.addMedicine(newMedicine);

      // Debug print
      print("✅ Added new medicine: ${newMedicine.name}");

      // Delay to let provider update, then log the list
      Future.delayed(Duration(milliseconds: 500), () {
        print("📦 Medicines in Provider after add:");
        provider.medicines.forEach((med) {
          print(
            "• ${med.name} - ${med.dosage} - ${med.time.format(context)} - Taken: ${med.isTaken}",
          );
        });
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Medicine saved successfully!')));
    }
  }
  void _navigateToEditMedicine(Medicine medicine) async {
  final updatedMedicine = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AddMedicinePage(
        selectedDate: _selectedDate,
        existingMedicine: medicine, // <-- Pass medicine to pre-fill form
      ),
    ),
  );

  if (updatedMedicine != null && updatedMedicine is Medicine) {
    final provider = Provider.of<MedicineProvider>(context, listen: false);
    provider.updateMedicine(updatedMedicine); // <-- Update medicine in provider
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${updatedMedicine.name} updated')),
    );
  }
}

}