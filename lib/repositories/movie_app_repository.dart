import 'package:fpdart/fpdart.dart';
import 'package:movie_app/api/core_api.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/api/repository_errors.dart';
import 'package:movie_app/models/movie_cast_response_model.dart';
import 'package:movie_app/models/movie_details_model.dart';
import 'package:movie_app/models/movie_rating_model.dart';
import 'package:movie_app/models/movie_trailer_model.dart';
import 'package:movie_app/models/movies_response_model.dart';

class MovieAppRepository {
  final Dio _dio = Dio(kBaseClientOptions);

  Future<Either<AppError, MovieResponseModel>> fetchMovies(int page) async {
    try {
      final response = await _dio.get('/movie/popular?page=$page');
      final model = MovieResponseModel.fromMap(response.data);

      return Right(model);
    } on DioException catch (error) {
      return Left(RepositoryError(error.response!.data['status_message']));
    } on Exception catch (error) {
      return Left(RepositoryError(error.toString()));
    }
  }

  Future<Either<AppError, MovieDetailsModel>> fetchMovieDetails(int id) async {
    try {
      final response = await _dio.get('/movie/$id');
      final model = MovieDetailsModel.fromMap(response.data);

      return Right(model);
    } on DioException catch (error) {
      return Left(RepositoryError(error.response!.data['status_message']));
    } on Exception catch (error) {
      return Left(RepositoryError(error.toString()));
    }
  }

  Future<Either<AppError, MovieCastResponseModel>> fetchMovieCasts(int id) async {
    try {
      final response = await _dio.get('/movie/$id/credits');
      final model = MovieCastResponseModel.fromMap(response.data);

      return Right(model);
    } on DioException catch (error) {
      return Left(RepositoryError(error.response!.data['status_message']));
    } on Exception catch (error) {
      return Left(RepositoryError(error.toString()));
    }
  }

  Future<Either<AppError, MovieResponseModel>> fetchOscarMovies(int page) async {
    try {
      final response = await _dio.get('/list/28-best-picture-winners-the-academy-awards?page=$page');
      final model = MovieResponseModel.fromMap(response.data);

      return Right(model);
    } on DioException catch (error) {
      return Left(RepositoryError(error.response!.data['status_message']));
    } on Exception catch (error) {
      return Left(RepositoryError(error.toString()));
    }
  }

  Future<Either<AppError, List<MovieRatingModel>>> fetchMovieRatings(int id) async {
    try {
      final response = await _dio.get('/movie/$id/reviews');
      final model =
          List<MovieRatingModel>.from(response.data['results'].map((rating) => MovieRatingModel.fromMap(rating)));

      return Right(model);
    } on DioException catch (error) {
      return Left(RepositoryError(error.response!.data['status_message']));
    } on Exception catch (error) {
      return Left(RepositoryError(error.toString()));
    }
  }

  Future<Either<AppError, List<MovieTrailerModel>>> fetchMovieTrailers(int id) async {
    try {
      final response = await _dio.get('/movie/$id/videos');
      final model =
          List<MovieTrailerModel>.from(response.data['results'].map((trailer) => MovieTrailerModel.fromMap(trailer)));

      return Right(model);
    } on DioException catch (error) {
      return Left(RepositoryError(error.response!.data['status_message']));
    } on Exception catch (error) {
      return Left(RepositoryError(error.toString()));
    }
  }
}
