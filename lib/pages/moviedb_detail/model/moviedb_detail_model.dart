class DetailPostModel {
  final int id;
  final String title;
  final String posterUrl;
  final String body;
  final DateTime releaseDate;
  final double rating;

  DetailPostModel({
    this.id,
    this.title,
    this.posterUrl,
    this.body,
    this.releaseDate,
    this.rating
  });

  factory DetailPostModel.fromJson(Map<String, dynamic> json) {
    final String _posterBodyUrl = 'https://image.tmdb.org/t/p/w500';
    return DetailPostModel(
        id: json['id'],
        title: json['title'],
        posterUrl: _posterBodyUrl+ json['poster_path'],
        body: json['overview'],
        releaseDate: DateTime.parse(json['release_date']),
        rating: json['vote_average']
    );
  }
}