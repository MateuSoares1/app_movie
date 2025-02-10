import 'package:flutter/material.dart';
import 'package:movie_app/pages/home/widgets/movie_card.dart';
import 'package:movie_app/pages/home/widgets/title_widget.dart';
import 'package:movie_app/pages/oscar_movies/controllers/oscar_controller.dart';
import 'package:movie_app/widgets/app_back_button.dart';
import 'package:movie_app/widgets/app_scaffold.dart';

class OscarMoviesPage extends StatelessWidget {
  const OscarMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Stack(children: [
        CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 90),
                  TitleWidget(title: 'Ganhadores do ORSCAR'),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 30),
              sliver: ValueListenableBuilder(
                valueListenable: OscarController().oscarListLenght,
                builder: (context, lenght, _) {
                  return SliverGrid.builder(
                    itemCount: lenght + (OscarController().isOscarFinalPage ? 0 : 1),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.45,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      if (index == lenght - 3 && !OscarController().isOscarFinalPage) {
                        OscarController().fetchMoreOscarMovies();
                      }
                      if (index == lenght + 1) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return MovieCard(
                        movie: OscarController().oscarMoviesList[index],
                      );
                    },
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
      ]),
    );
  }
}
