import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:movie_app/api/repository_errors.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/movies_response_model.dart';
import 'package:movie_app/repositories/movie_app_repository.dart';

class HomeController {
  HomeController._internal();
  factory HomeController() => _instance;
  static final HomeController _instance = HomeController._internal();

  final MovieAppRepository _repository = MovieAppRepository();

  MovieResponseModel? _movieResponseModel;

  int _currentPage = 1;

  ValueNotifier<int> listLenght = ValueNotifier(0);
  ValueNotifier<bool> isFetchingMovies = ValueNotifier(false);

  int get totalPages => _movieResponseModel?.totalPages ?? 1;
  List<MovieModel> get moviesList => _movieResponseModel?.movies ?? [];

  bool get isFinalPage => _currentPage == totalPages;

  Future<bool> fetchMovies() async {
    isFetchingMovies.value = true;

    final result = await _repository.fetchMovies(1);
    result.fold(
      (error) {
        print('===== Home Controller =====');
        print('* fetchMovies *');
        print(error);
        print('===========================');

        isFetchingMovies.value = false;
        return false;
      },
      (movies) {
        _movieResponseModel = movies;
        listLenght.value = movies.movies.length;
      },
    );

    isFetchingMovies.value = false;
    return true;
  }

  Future<Either<AppError, MovieResponseModel>> fetchMoreMovies() async {
    _currentPage++;
    final result = await _repository.fetchMovies(_currentPage);

    result.fold(
      (error) {
        print('===== Home Controller =====');
        print('* fetchMoreMovies *');
        print(error);
        print('===========================');
      },
      (movie) {
        if (_movieResponseModel != null) {
          _movieResponseModel!.page = movie.page;
          _movieResponseModel!.movies.addAll(movie.movies);
        } else {
          _movieResponseModel = movie;
        }

        listLenght.value = _movieResponseModel!.movies.length;
      },
    );

    return result;
  }
}
