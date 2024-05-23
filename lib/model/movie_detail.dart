
class MovieDetail {
  final String title;
  final String? posterPath;
  final DateTime releaseDate;
  final double voteAverage;
  final int voteCount;
  final String overview;

  MovieDetail({
    required this.title,
    this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.overview,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      title: json['title'],
      posterPath: json['poster_path'],
      releaseDate: DateTime.parse(json['release_date']),
      voteAverage: (json['vote_average'] as num).toDouble(), // Ensure voteAverage is double
      voteCount: (json['vote_count'] as num).toInt(), // Ensure voteCount is int
      overview: json['overview'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'poster_path': posterPath,
      'release_date': releaseDate.toIso8601String(),
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'overview': overview,
    };
  }
}
