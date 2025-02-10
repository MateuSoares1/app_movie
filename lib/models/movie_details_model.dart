class MovieDetailsModel {
  final int id;
  final String title;
  final String poster;
  final String background;
  final String releaseDate;
  final String overview;

  const MovieDetailsModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.background,
    required this.releaseDate,
    required this.overview,
  });

  factory MovieDetailsModel.fromMap(Map<String, dynamic> json) => MovieDetailsModel(
        id: json['id'],
        title: json['title'],
        poster: json['poster_path'] != null
            ? 'https://image.tmdb.org/t/p/original/${json['poster_path']}'
            : 'https://images.unsplash.com/photo-1620145648299-f926ac0a9470?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
        background: json['backdrop_path'] != null
            ? 'https://image.tmdb.org/t/p/original/${json['backdrop_path']}'
            : 'https://images.unsplash.com/photo-1574267432553-4b4628081c31?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1331&q=80',
        releaseDate: json['release_date'] ?? '',
        overview: json['overview'] ?? '',
      );
}
