import 'movie_model.dart';

class MovieResponseModel {
  int page;
  final int totalPages;
  final List<MovieModel> movies;

  MovieResponseModel({
    required this.page,
    required this.totalPages,
    required this.movies,
  });

  factory MovieResponseModel.fromMap(Map<String, dynamic> json) => MovieResponseModel(
        page: json['page'],
        totalPages: json['total_pages'],
        movies: json.containsKey('results')
            ? List<MovieModel>.from(
                json["results"].map(
                  (movie) => MovieModel.fromMap(movie),
                ),
              )
            : List<MovieModel>.from(
                json["items"].map(
                  (movie) => MovieModel.fromMap(movie),
                ),
              ),
      );
}
