enum Job { director, notMapped }

enum KnowFor { acting, notMapped }

class MovieCastModel {
  final int id;
  final KnowFor knowFor;
  final Job? job;
  final String name;
  final String? picture;
  final String? character;

  const MovieCastModel({
    required this.id,
    required this.knowFor,
    required this.name,
    this.picture,
    this.character,
    this.job,
  });

  static Job _getJob(String department) {
    return switch (department) {
      'Director' => Job.director,
      _ => Job.notMapped,
    };
  }

  static KnowFor _getKnowFor(String department) {
    return switch (department) {
      'Acting' => KnowFor.acting,
      _ => KnowFor.notMapped,
    };
  }

  factory MovieCastModel.fromMap(Map<String, dynamic> json) {
    return MovieCastModel(
      id: json['id'],
      knowFor: _getKnowFor(json['known_for_department']),
      job: json.containsKey('job') ? _getJob(json['job']) : null,
      name: json['name'],
      picture: json['profile_path'] != null ? 'https://image.tmdb.org/t/p/original/${json['profile_path']}' : null,
      character: json.containsKey('character') ? json['character'] : null,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MovieCastModel && other.hashCode == hashCode;
  }

  @override
  int get hashCode => Object.hash(id, name, picture, job, knowFor);
}
