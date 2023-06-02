class Subject {
  String idSubject;
  String nameSubject;
  String note;
  int credit;
  double score1;
  double score2;
  double score3;
  String semester;
  Subject({
    required this.idSubject,
    required this.nameSubject,
    required this.note,
    required this.credit,
    required this.score1,
    required this.score2,
    required this.score3,
    required this.semester,
  });
  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      idSubject: json['iDSubject'] ?? '',
      nameSubject: json['nameSubject'] ?? '', 
      note: json['note'] ?? '',
      credit: json['credit'] != null ? int.parse(json['credit'].toString()) : 0,
      score1:
          json['score1'] != null ? double.parse(json['score1'].toString()) : 0,
      score2:
          json['score2'] != null ? double.parse(json['score2'].toString()) : 0,
      score3:
          json['score3'] != null ? double.parse(json['score3'].toString()) : 0,
      semester: json['semester'] ?? '',
    );
  }
}
