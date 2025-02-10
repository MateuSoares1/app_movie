import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/favorites/controllers/favorites_controller.dart';
import 'package:movie_app/pages/movie_details/controllers/movie_controller.dart';
import 'package:movie_app/pages/movie_details/sections/cast_section.dart';
import 'package:movie_app/pages/movie_details/sections/directing_section.dart';
import 'package:movie_app/pages/movie_details/sections/ratings_section.dart';
import 'package:movie_app/pages/movie_details/sections/trailers_section.dart';
import 'package:movie_app/pages/movie_details/widgets/favorite_button.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/widgets/app_back_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key, required this.movie});

  final MovieModel movie;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final MovieController _movieController = MovieController();
  final FavoritesController _favoritesController = FavoritesController();

  bool isLoading = false;
  bool isMovieFavorite = false;

  @override
  void initState() {
    if (_movieController.movie == null || widget.movie.id != _movieController.movie!.id) {
      initialize();
    }
    checkIsFavorite();

    super.initState();
  }

  void checkIsFavorite() async {
    isMovieFavorite = await _favoritesController.isMovieFavorite(
      movieId: widget.movie.id,
    );

    if (mounted) {
      setState(() {});
    }
  }

  initialize() async {
    if (mounted) {
      setState(() => isLoading = true);
    }
    await _movieController.fetchMovieDetails(
      movieId: widget.movie.id,
    );
    await _movieController.fetchMovieCasts(
      movieId: widget.movie.id,
    );
    await _movieController.fetchMovieRatings(
      movieId: widget.movie.id,
    );
    await _movieController.fetchMovieTrailers(
      movieId: widget.movie.id,
    );

    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Skeletonizer(
            enabled: isLoading,
            containersColor: Colors.grey[350],
            child: Container(
              height: screenWidth * 0.58,
              width: screenWidth,
              decoration: BoxDecoration(
                color: AppColors.blackCoral,
                border: Border(
                  bottom: BorderSide(color: AppColors.desertSand, width: 5),
                ),
              ),
              child: isLoading
                  ? const Bone(
                      width: double.maxFinite,
                      height: double.maxFinite,
                    )
                  : FadeInImage.assetNetwork(
                      placeholder: 'assets/popcorn.png',
                      fadeInDuration: const Duration(milliseconds: 300),
                      image: _movieController.movie?.background ?? '',
                      fit: BoxFit.cover,
                      placeholderFit: BoxFit.scaleDown,
                    ),
            ),
          ),
          ListView(
            padding: EdgeInsets.only(top: screenWidth * 0.2, bottom: 50),
            children: [
              Hero(
                tag: widget.movie.id,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.28),
                  height: screenWidth * 0.65,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(7),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.movie.poster,
                      width: screenWidth * 0.23,
                      height: 150,
                      fit: BoxFit.cover,
                      memCacheHeight: (150 * MediaQuery.of(context).devicePixelRatio).toInt(),
                    ),
                  ),
                ),
              ),
              Container(
                color: AppColors.backgroundColor,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        widget.movie.title,
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 15),
                    FavoriteButton(
                      isFavorite: isMovieFavorite,
                      onPressed: () {
                        if (isMovieFavorite) {
                          _favoritesController.removeMovieFromFavorites(
                            movie: widget.movie,
                          );
                        } else {
                          _favoritesController.addMovieToFavorites(
                            movie: widget.movie,
                          );
                        }

                        setState(() => isMovieFavorite = !isMovieFavorite);
                      },
                    ),
                    const SizedBox(height: 30),
                    if (_movieController.movie != null && _movieController.movie?.overview != '') ...[
                      Skeletonizer(
                        enabled: isLoading,
                        containersColor: Colors.grey[350],
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(16, 32, 16, 20),
                              decoration: BoxDecoration(
                                color: const Color(0xFFfbf0d9),
                                border: Border.all(color: AppColors.primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(18.0, 24, 18, 18),
                                child: Text(
                                  _movieController.movie?.overview ?? '',
                                  style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: const EdgeInsets.only(left: 30),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.blackCoral,
                                  border: Border.all(color: AppColors.primaryColor, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Sinopse',
                                  style: GoogleFonts.anton(
                                    fontSize: 18,
                                    color: AppColors.desertSand,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 18),
                    Skeletonizer(
                      enabled: isLoading,
                      containersColor: Colors.grey[350],
                      child: CastSection(
                        casts: _movieController.acting ?? [],
                      ),
                    ),
                    const SizedBox(height: 36),
                    Skeletonizer(
                      enabled: isLoading,
                      containersColor: Colors.grey[350],
                      child: DirectingSection(
                        directing: _movieController.directing ?? [],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Skeletonizer(
                      enabled: isLoading,
                      containersColor: Colors.grey[350],
                      child: RatingsSection(ratings: _movieController.ratings ?? []),
                    ),
                    const SizedBox(height: 39),
                    Skeletonizer(
                      enabled: isLoading,
                      containersColor: Colors.grey[350],
                      child: TrailersSection(trailers: _movieController.trailers ?? []),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Positioned(left: 0, top: 30, child: AppBackButton()),
        ],
      ),
    );
  }
}
