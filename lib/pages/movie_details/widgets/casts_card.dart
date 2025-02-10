import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:movie_app/models/movie_cast_model.dart';
import 'package:movie_app/utils/app_colors.dart';

class CastsCard extends StatelessWidget {
  final MovieCastModel cast;
  const CastsCard({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        cast.picture == null
            ? const Icon(FontAwesome5Regular.user_circle, size: 64)
            : CircleAvatar(
                radius: 32,
                backgroundColor: Colors.grey[400],
                backgroundImage: CachedNetworkImageProvider(
                  cast.picture!,
                ),
              ),
        Text(
          cast.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.blackCoral,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        if (cast.character != null)
          Text(
            cast.character!,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.lightBrown,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
