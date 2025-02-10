import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_cast_model.dart';
import 'package:movie_app/pages/home/widgets/title_widget.dart';
import 'package:movie_app/pages/movie_details/controllers/movie_controller.dart';
import 'package:movie_app/pages/movie_details/widgets/casts_card.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/widgets/app_back_button.dart';
import 'package:movie_app/widgets/app_scaffold.dart';

class MovieCastPage extends StatelessWidget {
  final List<MovieCastModel> casts;
  const MovieCastPage({super.key, required this.casts});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 90),
                    const TitleWidget(title: 'Elenco'),
                    const SizedBox(height: 20),
                    Text(
                      MovieController().movie!.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackCoral,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 30),
                sliver: SliverGrid.builder(
                  itemCount: casts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return CastsCard(
                      cast: casts[index],
                    );
                  },
                ),
              ),
            ],
          ),
          const Positioned(
            left: 0,
            top: 35,
            child: AppBackButton(),
          )
        ],
      ),
    );
  }
}
