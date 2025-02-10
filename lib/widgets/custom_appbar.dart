import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      floating: true,
      elevation: 8,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.primaryColor),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
      backgroundColor: AppColors.lightDesertSand,
      title: Image.asset(
        'assets/logo.png',
        width: 150,
      ),
    );
  }
}
