import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:movie_app/utils/app_colors.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.desertSand,
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(30),
          ),
        ),
        child: Icon(
          FontAwesome.arrow_left,
          color: AppColors.blackCoral,
          size: 28,
        ),
      ),
    );
  }
}
