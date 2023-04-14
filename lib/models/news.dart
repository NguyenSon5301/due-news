class News {
  String idPost;
  DateTime? publishedDate;
  String titleNews;
  String description;
  String category;
  News({
    required this.idPost,
    required this.publishedDate,
    required this.titleNews,
    required this.description,
    required this.category,
  });
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      idPost: json['idPost'] ?? '',
      publishedDate: json['publishedDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              json['publishedDate'].millisecondsSinceEpoch,
            )
          : null,
      titleNews: json['titleNews'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
    );
  }
}
