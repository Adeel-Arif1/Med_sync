import 'package:flutter/material.dart';
import 'package:med_sync/core/constants/app_colors.dart';

class PrimaryHeading extends StatelessWidget {
  final String text;

  const PrimaryHeading(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }
}

class SecondaryHeading extends StatelessWidget {
  final String text;

  const SecondaryHeading(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.textSecondary,
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }
}
