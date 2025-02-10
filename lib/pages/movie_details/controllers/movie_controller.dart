import 'package:movie_app/models/movie_cast_model.dart';
import 'package:movie_app/models/movie_details_model.dart';
import 'package:movie_app/models/movie_rating_model.dart';
import 'package:movie_app/models/movie_trailer_model.dart';
import 'package:movie_app/repositories/movie_app_repository.dart';

class MovieController {
  MovieController._internal();
  factory MovieController() => _instance;
  static final MovieController _instance = MovieController._internal();

  final MovieAppRepository _repository = MovieAppRepository();

  MovieDetailsModel? movie;
  List<MovieCastModel>? acting;
  List<MovieCastModel>? directing;
  List<MovieRatingModel>? ratings;
  List<MovieTrailerModel>? trailers;

  Future<bool> fetchMovieDetails({required int movieId}) async {
    final result = await _repository.fetchMovieDetails(movieId);
    result.fold(
      (error) {
        print('===== Movie Controller =====');
        print('* fetchMovieDetails *');
        print(error);
        print('===========================');

        return false;
      },
      (details) {
        movie = details;
      },
    );

    return true;
  }

  Future<bool> fetchMovieCasts({required int movieId}) async {
    final result = await _repository.fetchMovieCasts(movieId);
    result.fold(
      (error) {
        print('===== Movie Controller =====');
        print('* fetchMovieCatsts *');
        print(error);
        print('===========================');

        return false;
      },
      (response) {
        acting = response.casts
            .where(
              (cast) => cast.knowFor == KnowFor.acting,
            )
            .toList()
            .toSet()
            .toList();

        directing = response.crew
            .where(
              (crew) => crew.job != null && crew.job == Job.director,
            )
            .toList()
            .toSet()
            .toList();
      },
    );

    return true;
  }

  Future<bool> fetchMovieRatings({required int movieId}) async {
    final result = await _repository.fetchMovieRatings(movieId);
    result.fold(
      (error) {
        print('===== Movie Controller =====');
        print('* fetchMovieRatings *');
        print(error);
        print('===========================');

        return false;
      },
      (details) {
        ratings = details;
      },
    );

    return true;
  }

  Future<bool> fetchMovieTrailers({required int movieId}) async {
    final result = await _repository.fetchMovieTrailers(movieId);
    result.fold(
      (error) {
        print('===== Movie Controller =====');
        print('* fetchMovieTrailers *');
        print(error);
        print('===========================');

        return false;
      },
      (details) {
        trailers = details;
      },
    );

    return true;
  }
}
