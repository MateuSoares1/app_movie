import 'package:flutter/material.dart';
import 'package:movie_app/pages/home/widgets/movie_card.dart';
import 'package:movie_app/pages/home/widgets/title_widget.dart';
import 'package:movie_app/pages/oscar_movies/controllers/oscar_controller.dart';
import 'package:movie_app/pages/oscar_movies/oscar_movies_page.dart';
import 'package:movie_app/widgets/page_loading.dart';
import 'package:movie_app/widgets/see_all_button.dart';

class OscarWinnersSection extends StatelessWidget {
  const OscarWinnersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const TitleWidget(title: 'Ganhadores do OSCAR'),
      const SizedBox(height: 25),
      SizedBox(
        height: 275,
        child: ValueListenableBuilder(
            valueListenable: OscarController().isFetchingOscarMovies,
            builder: (context, isFetching, _) {
              return isFetching
                  ? const PageLoading()
                  : ListView.separated(
                      itemCount: 7,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 8);
                      },
                      itemBuilder: (context, index) {
                        if (index == 6) {
                          return Container(
                            width: 122,
                            margin: const EdgeInsets.only(bottom: 90),
                            child: SeeAllButton(onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OscarMoviesPage(),
                                ),
                              );
                            }),
                          );
                        }
                        return SizedBox(
                          width: 122,
                          child: MovieCard(
                            movie: OscarController().oscarMoviesList[index],
                          ),
                        );
                      },
                    );
            }),
      )
    ]);
  }
}
