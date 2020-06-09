class PostModel {
  final int id;
  final String title;
  final String body;
  final String posterUrl;

  PostModel({
    this.id,
    this.title,
    this.body,
    this.posterUrl,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final String _posterBodyUrl = 'https://image.tmdb.org/t/p/w500';
    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['overview'],
      posterUrl: _posterBodyUrl + json['poster_path'],
    );
  }
  static Map<String, dynamic> toMap(PostModel post) {
    return {
      'id': post.id,
      'title': post.title,
      'body': post.body,
      'posterUrl': post.posterUrl,
    };
  }

  static PostModel fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      posterUrl: map['posterUrl'],
    );
  }
}