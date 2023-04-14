class Extracurricular {
  String nameActivity;
  int score;
  int categoryScore;
  String semester;
  Extracurricular({
    required this.nameActivity,
    required this.categoryScore,
    this.score = 0,
    this.semester = '',
  });
  factory Extracurricular.fromJson(Map<String, dynamic> json) {
    return Extracurricular(
      nameActivity: json['nameActivity'],
      score: json['score'] ?? 0,
      categoryScore: int.parse(json['categoryScore'].toString()),
      semester: json['semester'] ?? '',
    );
  }
}
