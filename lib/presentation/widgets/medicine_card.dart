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

  IconData _getMedicineIcon() {
    if (medicine.isTaken) {
      return Icons.check_circle;
    }
    switch (medicine.type) {
      case MedicineType.tablet:
        return Icons.medication;
      case MedicineType.drops:
        return Icons.water_drop;
      case MedicineType.capsule:
        return Icons.medication_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.white, const Color(0xFFF8FBFF).withOpacity(0.5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Medicine Icon with Gradient Background
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.15),
                      AppColors.primary.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Icon(
                    _getMedicineIcon(),
                    color: medicine.isTaken ? AppColors.primary : AppColors.textSecondary,
                    size: 28,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Medicine Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicine.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    medicine.dosage,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary.withOpacity(0.85),
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: AppColors.textSecondary.withOpacity(0.7),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        medicine.time.format(context),
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Action Buttons
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: IconButton(
                    icon: const Icon(Icons.edit, size: 18, color: AppColors.primary),
                    onPressed: onEdit,
                    tooltip: 'Edit Medicine',
                  ),
                ),
                const SizedBox(height: 8),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: IconButton(
                    icon: const Icon(Icons.alarm, size: 18, color: AppColors.primary),
                    onPressed: onMarkTaken,
                    tooltip: 'View Reminder',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}