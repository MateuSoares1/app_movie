import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_trailer_model.dart';
import 'package:movie_app/pages/movie_details/widgets/empty_section_text.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class TrailersSection extends StatelessWidget {
  final List<MovieTrailerModel> trailers;
  const TrailersSection({
    super.key,
    required this.trailers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Trailers',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        if (trailers.isEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: EmptySectionText(text: 'Sem trailers, por enquanto.'),
          ),
        ] else ...[
          ListView.separated(
            itemCount: trailers.length,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (context, index) {
              return const SizedBox(height: 14);
            },
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: Text(
                      trailers[index].name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackCoral,
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  OutlinedButton(
                    onPressed: () async {
                      await launchUrl(Uri.parse(trailers[index].url));
                    },
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                      color: AppColors.primaryColor,
                    )),
                    child: Text(
                      'Abrir vídeo',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ],
    );
  }
}
