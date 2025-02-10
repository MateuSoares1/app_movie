import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_cast_model.dart';
import 'package:movie_app/pages/movie_cast/movie_cast_page.dart';
import 'package:movie_app/pages/movie_details/widgets/casts_card.dart';
import 'package:movie_app/pages/movie_details/widgets/empty_section_text.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/widgets/see_all_button.dart';

class CastSection extends StatelessWidget {
  final List<MovieCastModel> casts;
  const CastSection({super.key, required this.casts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Elenco',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),
        if (casts.isEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: EmptySectionText(
              text: 'Elenco não informado, por enquanto.',
            ),
          )
        ] else ...[
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: casts.length > 7 ? 7 : casts.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemBuilder: (context, index) {
                if (casts.length > 7 && index == 6) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 100,
                      child: SeeAllButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieCastPage(
                                casts: casts,
                              ),
                            ),
                          );
                        },
                        margin: 0,
                        padding: 6,
                      ),
                    ),
                  );
                }
                return SizedBox(width: 100, child: CastsCard(cast: casts[index]));
              },
            ),
          ),
        ],
      ],
    );
  }
}
