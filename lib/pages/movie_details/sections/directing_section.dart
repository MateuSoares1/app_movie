import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_cast_model.dart';
import 'package:movie_app/pages/movie_details/widgets/casts_card.dart';
import 'package:movie_app/pages/movie_details/widgets/empty_section_text.dart';
import 'package:movie_app/utils/app_colors.dart';

class DirectingSection extends StatelessWidget {
  final List<MovieCastModel> directing;

  const DirectingSection({super.key, required this.directing});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            directing.length > 1 ? 'Diretores' : 'Diretor',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        if (directing.isEmpty) ...[
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: EmptySectionText(text: 'Diretor não informado, por enquanto.')),
        ] else ...[
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: directing.length,
            itemBuilder: (context, index) {
              return CastsCard(cast: directing[index]);
            },
          ),
        ],
      ],
    );
  }
}
