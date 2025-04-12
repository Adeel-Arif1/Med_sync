import 'package:flutter/material.dart';

import 'package:med_sync/core/constants/app_colors.dart';
import 'package:med_sync/features/domain/model/medicine_model.dart';

import 'package:med_sync/presentation/screens/home_page_screen.dart';

class MedicineCard extends StatelessWidget {
  final Medicine medicine;
  final VoidCallback onMarkTaken;

  const MedicineCard({
    super.key,
    required this.medicine,
    required this.onMarkTaken,
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
        contentPadding: const EdgeInsets.all(16),
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
        trailing: _buildStatusIndicator(),
      ),
    );
  }

  Widget _buildMedicineIcon() {
    return Container(
      width: 50,
      height: 50,
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
        medicine.type == MedicineType.capsule
            ? Icons.medication_liquid
            : Icons.water_drop_rounded,
        color: AppColors.primary,
        size: 28,
      ),
    );
  }

  Widget _buildMedicineDetails(String time, String timeLeft) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        Text(
          medicine.dosage,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.access_time, size: 16, color: AppColors.primary),
            const SizedBox(width: 4),
            Text(
              time,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              timeLeft,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusIndicator() {
    return medicine.isTaken
        ? Icon(Icons.check_circle_rounded, color: AppColors.primary)
        : IconButton(
          icon: Icon(Icons.add_alarm_rounded, color: AppColors.primary),
          onPressed: onMarkTaken,
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
