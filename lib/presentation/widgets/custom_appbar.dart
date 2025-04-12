import 'package:flutter/material.dart';
import 'package:med_sync/core/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final IconData leadingIcon;
  final Color backgroundColor;
  final Color textColor;
  final double elevation;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.leadingIcon = Icons.arrow_back,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      title: title != null 
          ? Text(
              title!,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading
          ? IconButton(
              icon: Icon(
                leadingIcon,
                color: textColor,
                size: 24,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
      iconTheme: IconThemeData(color: textColor),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}