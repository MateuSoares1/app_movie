import 'package:flutter/material.dart';
import 'package:movie_app/pages/favorites/controllers/favorites_controller.dart';
import 'package:movie_app/pages/home/widgets/movie_card.dart';
import 'package:movie_app/pages/home/widgets/title_widget.dart';
import 'package:movie_app/widgets/app_scaffold.dart';
import 'package:movie_app/widgets/page_loading.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> with AutomaticKeepAliveClientMixin {
  final FavoritesController favoritesController = FavoritesController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    initialize();
  }

  void initialize() async {
    await favoritesController.fetchFavoritesMovies();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return isLoading
        ? const PageLoading()
        : AppScaffold(
            body: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 90),
                      TitleWidget(title: 'Filmes Favoritos'),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16, top: 30),
                  sliver: ListenableBuilder(
                      listenable: favoritesController,
                      builder: (context, _) {
                        return SliverGrid.builder(
                          itemCount: favoritesController.favoritesList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.45,
                            crossAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            return MovieCard(
                              movie: favoritesController.favoritesList[index],
                            );
                          },
                        );
                      }),
                ),
              ],
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
