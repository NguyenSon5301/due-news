class CategoryNews {
  String nameCategory;
  CategoryNews({
    required this.nameCategory,
  });
  factory CategoryNews.fromJson(Map<String, dynamic> json) {
    return CategoryNews(
      nameCategory: json['nameCategory'],
    );
  }
}
