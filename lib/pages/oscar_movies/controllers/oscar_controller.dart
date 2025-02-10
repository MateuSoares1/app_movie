import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/movies_response_model.dart';
import 'package:movie_app/repositories/movie_app_repository.dart';

class OscarController {
  OscarController._internal();
  factory OscarController() => _instance;
  static final OscarController _instance = OscarController._internal();

  final MovieAppRepository _repository = MovieAppRepository();

  MovieResponseModel? _orscarMoviesResponseModel;

  int _oscarCurrentPage = 1;

  ValueNotifier<int> oscarListLenght = ValueNotifier(0);
  ValueNotifier<bool> isFetchingOscarMovies = ValueNotifier(false);

  int get oscarTotalPages => _orscarMoviesResponseModel?.totalPages ?? 1;
  List<MovieModel> get oscarMoviesList => _orscarMoviesResponseModel?.movies ?? [];

  bool get isOscarFinalPage => _oscarCurrentPage == oscarTotalPages;

  Future<bool> fetchOscarMovies() async {
    isFetchingOscarMovies.value = true;

    final result = await _repository.fetchOscarMovies(1);
    result.fold(
      (error) {
        print('===== Oscar Controller =====');
        print('* fetchOscarMovies *');
        print(error);
        print('===========================');

        isFetchingOscarMovies.value = false;
        return false;
      },
      (movies) {
        _orscarMoviesResponseModel = movies;
        oscarListLenght.value = movies.movies.length;
      },
    );

    isFetchingOscarMovies.value = false;

    return true;
  }

  Future<bool> fetchMoreOscarMovies() async {
    _oscarCurrentPage++;
    final result = await _repository.fetchOscarMovies(_oscarCurrentPage);

    result.fold(
      (error) {
        print('===== Oscar Controller =====');
        print('* fetchMoreOscarMovies *');
        print(error);
        print('===========================');
      },
      (movie) {
        if (_orscarMoviesResponseModel != null) {
          _orscarMoviesResponseModel!.page = movie.page;
          _orscarMoviesResponseModel!.movies.addAll(movie.movies);
        } else {
          _orscarMoviesResponseModel = movie;
        }

        oscarListLenght.value = _orscarMoviesResponseModel!.movies.length;
      },
    );

    return true;
  }
}
