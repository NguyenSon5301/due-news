class Semester {
  String idSemester;
  String nameSemester;
  DateTime startDate;
  DateTime endDate;

  Semester({
    required this.idSemester,
    required this.nameSemester,
    required this.startDate,
    required this.endDate,
  });
  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      idSemester: json['iDSemester'],
      nameSemester: json['nameSemester'],
      startDate: DateTime.fromMillisecondsSinceEpoch(
        json['startDate'].millisecondsSinceEpoch,
      ),
      endDate: DateTime.fromMillisecondsSinceEpoch(
        json['endDate'].millisecondsSinceEpoch,
      ),
    );
  }
}
