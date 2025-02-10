import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';

class EmptySectionText extends StatelessWidget {
  const EmptySectionText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.blackCoral,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
