enum VideoType { trailer, notMapped }

class MovieTrailerModel {
  final String name;
  final String url;
  final String id;
  final VideoType type;

  const MovieTrailerModel({
    required this.name,
    required this.url,
    required this.id,
    required this.type,
  });

  static VideoType _getVideoType(String type) {
    return switch (type) {
      'Trailer' => VideoType.trailer,
      _ => VideoType.notMapped,
    };
  }

  factory MovieTrailerModel.fromMap(Map<String, dynamic> json) {
    return MovieTrailerModel(
      name: json['name'],
      url: 'https://www.youtube.com/watch?v=${json['key']}',
      id: json['id'],
      type: _getVideoType(json['type']),
    );
  }
}
