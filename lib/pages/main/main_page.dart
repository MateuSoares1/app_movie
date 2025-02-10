import 'package:flutter/material.dart';
import 'package:movie_app/pages/favorites/controllers/favorites_controller.dart';
import 'package:movie_app/pages/favorites/favorites_page.dart';
import 'package:movie_app/pages/home/controllers/home_controller.dart';
import 'package:movie_app/pages/home/home_page.dart';
import 'package:movie_app/pages/main/widgets/bottom_navigator.dart';
import 'package:movie_app/pages/oscar_movies/controllers/oscar_controller.dart';
import 'package:movie_app/pages/profile/profile_page.dart';
import 'package:movie_app/services/global_service.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({super.key});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  @override
  void initState() {
    super.initState();

    FavoritesController().fetchFavoritesMovies();
    OscarController().fetchOscarMovies();
    HomeController().fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: GlobalService().mainPageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              FavoritesPage(),
              HomePage(),
              ProfilePage(),
            ],
          ),
          const BottomNavigator()
        ],
      ),
    );
  }
}
