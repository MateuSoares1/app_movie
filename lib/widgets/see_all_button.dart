import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:movie_app/utils/app_colors.dart';

class SeeAllButton extends StatelessWidget {
  final Function() onTap;
  final double? margin;
  final double? padding;

  const SeeAllButton({
    super.key,
    required this.onTap,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(margin ?? 12),
        padding: EdgeInsets.all(padding ?? 0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.lightDesertSand,
          border: Border.all(
            color: AppColors.primaryColor,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ver\ntodos',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.blackCoral,
              ),
              textAlign: TextAlign.center,
            ),
            Icon(
              FontAwesome5Solid.arrow_right,
              color: AppColors.blackCoral,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
