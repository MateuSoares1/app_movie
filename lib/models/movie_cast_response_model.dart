import 'package:movie_app/models/movie_cast_model.dart';

class MovieCastResponseModel {
  final List<MovieCastModel> casts;
  final List<MovieCastModel> crew;

  const MovieCastResponseModel({
    required this.casts,
    required this.crew,
  });

  factory MovieCastResponseModel.fromMap(Map<String, dynamic> json) {
    return MovieCastResponseModel(
      casts: List<MovieCastModel>.from(json['cast'].map((cast) => MovieCastModel.fromMap(cast))),
      crew: List<MovieCastModel>.from(json['crew'].map((crew) => MovieCastModel.fromMap(crew))),
    );
  }
}
