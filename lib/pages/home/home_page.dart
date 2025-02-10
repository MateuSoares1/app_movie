import 'package:flutter/material.dart';
import 'package:movie_app/pages/home/controllers/home_controller.dart';
import 'package:movie_app/pages/home/sections/oscar_winners_section.dart';
import 'package:movie_app/pages/home/widgets/movie_card.dart';
import 'package:movie_app/pages/home/widgets/title_widget.dart';
import 'package:movie_app/services/global_service.dart';
import 'package:movie_app/widgets/app_scaffold.dart';
import 'package:movie_app/widgets/custom_appbar.dart';
import 'package:movie_app/widgets/page_loading.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: ValueListenableBuilder(
        valueListenable: HomeController().isFetchingMovies,
        builder: (context, isFetching, _) {
          return isFetching
              ? const PageLoading()
              : CustomScrollView(
                  controller: GlobalService().homeScrollController,
                  slivers: [
                    const CustomAppbar(),
                    const SliverToBoxAdapter(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 25),
                          OscarWinnersSection(),
                        ],
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TitleWidget(title: 'Descubra mais filmes'),
                          SizedBox(height: 25),
                        ],
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: ValueListenableBuilder(
                        valueListenable: HomeController().listLenght,
                        builder: (context, lenght, _) {
                          return SliverGrid.builder(
                            itemCount: lenght + (HomeController().isFinalPage ? 0 : 1),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.45,
                              crossAxisSpacing: 8,
                            ),
                            itemBuilder: (context, index) {
                              if (index == lenght - 3 && !HomeController().isFinalPage) {
                                HomeController().fetchMoreMovies();
                              }
                              if (index == lenght + 1) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return MovieCard(
                                movie: HomeController().moviesList[index],
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
