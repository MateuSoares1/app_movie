import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
  });

  final bool isFavorite;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.backgroundColor,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
        maximumSize: const Size(250, 46),
      ),
      child: Row(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.center,
        children: isFavorite
            ? [
                Icon(
                  Icons.favorite_rounded,
                  color: AppColors.backgroundColor,
                ),
                const Text('Remover dos favoritos'),
              ]
            : [
                Icon(
                  Icons.favorite_border_rounded,
                  color: AppColors.backgroundColor,
                ),
                const Text('Adicionar aos favoritos'),
              ],
      ),
    );
  }
}
