import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/repositories/favorites_repository.dart';

class FavoritesController with ChangeNotifier {
  FavoritesController._internal();
  factory FavoritesController() => _instance;
  static final FavoritesController _instance = FavoritesController._internal();

  final List<MovieModel> favoritesList = [];

  Future<void> fetchFavoritesMovies() async {
    final response = await FavoritesRepository().fetchFavoriteMovies();

    favoritesList.clear();
    favoritesList.addAll(response);
  }

  Future<bool> addMovieToFavorites({required MovieModel movie}) async {
    final result = await FavoritesRepository().addMovieToFavorites(movie: movie);

    favoritesList.add(movie);
    notifyListeners();

    return result;
  }

  Future<bool> removeMovieFromFavorites({required MovieModel movie}) async {
    final result = await FavoritesRepository().removeMovieFromFavorites(movie: movie);

    favoritesList.removeWhere((element) => element.id == movie.id);
    notifyListeners();

    return result;
  }

  Future<bool> isMovieFavorite({required int movieId}) async {
    return await FavoritesRepository().isMovieInFavorites(movieId: movieId);
  }
}
