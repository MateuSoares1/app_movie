class MovieModel {
  final int id;
  final String title;
  final String poster;
  final String background;

  const MovieModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.background,
  });

  factory MovieModel.fromMap(Map<String, dynamic> json) => MovieModel(
        id: json['id'],
        title: json['title'],
        poster: json['poster_path'] != null
            ? 'https://image.tmdb.org/t/p/original/${json['poster_path']}'
            : 'https://images.unsplash.com/photo-1620145648299-f926ac0a9470?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
        background: json['backdrop_path'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'poster_path': poster,
        'background': background,
      };
}
