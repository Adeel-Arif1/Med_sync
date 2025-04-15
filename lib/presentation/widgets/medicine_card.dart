import 'package:flutter/material.dart';
import 'package:med_sync/core/constants/app_colors.dart';
import 'package:med_sync/features/domain/model/medicine_model.dart';

class MedicineCard extends StatelessWidget {
  final Medicine medicine;
  final VoidCallback onMarkTaken;
  final VoidCallback onEdit;

  const MedicineCard({
    super.key,
    required this.medicine,
    required this.onMarkTaken,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final time = medicine.time.format(context);
    final timeLeft = _calculateTimeLeft(medicine.time);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        minVerticalPadding: 0, // Reduces minimum vertical padding
        dense: true, // Makes the ListTile more compact
        leading: _buildMedicineIcon(),
        title: Text(
          medicine.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        subtitle: _buildMedicineDetails(time, timeLeft),
        trailing: SizedBox(
          height: 48, // Fixed height for trailing widget
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Edit button - smaller with less padding
              GestureDetector(
                onTap: onEdit,
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.edit,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // Status indicator - more compact
              medicine.isTaken
                  ? const Icon(
                      Icons.check_circle_rounded,
                      size: 18,
                      color: AppColors.primary,
                    )
                  : GestureDetector(
                      onTap: onMarkTaken,
                      child: const Icon(
                        Icons.add_alarm_rounded,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMedicineIcon() {
    return Container(
      width: 40, // Reduced from 50
      height: 40, // Reduced from 50
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.2),
            AppColors.primary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        (medicine.type == MedicineType.capsule || medicine.type == MedicineType.tablet)
            ? Icons.medication_liquid
            : Icons.water_drop_rounded,
        color: AppColors.primary,
        size: 22, // Reduced from 28
      ),
    );
  }

  Widget _buildMedicineDetails(String time, String timeLeft) {
    final String unit = (medicine.type == MedicineType.capsule || medicine.type == MedicineType.tablet)
        ? 'mg'
        : 'ml';

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${medicine.dosage} $unit',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13), // Slightly smaller
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: AppColors.primary), // Smaller
              const SizedBox(width: 4),
              Text(
                time,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13, // Smaller
                ),
              ),
              const Spacer(),
              Text(
                timeLeft,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11, // Smaller
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _calculateTimeLeft(TimeOfDay medicineTime) {
    final now = DateTime.now();
    final scheduled = DateTime(
      now.year,
      now.month,
      now.day,
      medicineTime.hour,
      medicineTime.minute,
    );
    final difference = scheduled.difference(now);

    if (difference.isNegative) return 'Overdue';
    if (difference.inMinutes < 60) return 'in ${difference.inMinutes}m';
    return 'in ${difference.inHours}h ${difference.inMinutes.remainder(60)}m';
  }
}