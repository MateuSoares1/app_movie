import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_rating_model.dart';
import 'package:movie_app/pages/movie_details/widgets/empty_section_text.dart';
import 'package:movie_app/utils/app_colors.dart';

class RatingsSection extends StatelessWidget {
  final List<MovieRatingModel> ratings;

  const RatingsSection({
    super.key,
    required this.ratings,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Avaliações',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 30),
        if (ratings.isEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: EmptySectionText(
              text: 'Sem avaliações, por enquanto.',
            ),
          )
        ] else ...[
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: ratings.length > 5 ? 5 : ratings.length,
            separatorBuilder: (context, index) {
              return Center(
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Divider(
                            thickness: 3,
                            endIndent: 8,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '•',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Divider(
                            thickness: 3,
                            indent: 8,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemBuilder: (context, index) {
              if (ratings.length > 5 && index == 4) {
                return OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    'Ver todas avaliações',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackCoral,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        ratings[index].author,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackCoral,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 10),
                      if (ratings[index].rating != null) ...[
                        Text(
                          '${ratings[index].rating}/10',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                  if (ratings[index].content != null) ...[
                    const SizedBox(height: 10),
                    AnimatedReadMoreText(
                      ratings[index].content!,
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackCoral,
                        height: 1.2,
                      ),
                      maxLines: 4,
                      readMoreText: '...ver mais',
                      readLessText: ' ver menos',
                      buttonTextStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ],
    );
  }
}
