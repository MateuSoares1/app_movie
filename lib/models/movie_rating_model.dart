class MovieRatingModel {
  final double? rating;
  final String author;
  final String? content;

  const MovieRatingModel({
    required this.rating,
    required this.author,
    required this.content,
  });

  factory MovieRatingModel.fromMap(Map<String, dynamic> json) => MovieRatingModel(
        rating: json['author_details']['rating'],
        author: json['author'],
        content: json.containsKey('content') ? json['content'] : null,
      );
}
