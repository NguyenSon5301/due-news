class UserInfomation {
  String idStudent;
  String name;
  DateTime? birthDate;
  String classRoom;
  String level;
  String field;
  String major;
  String email;
  UserInfomation({
    required this.idStudent,
    required this.name,
    required this.birthDate,
    required this.classRoom,
    required this.level,
    required this.field,
    required this.major,
    required this.email,
  });
  factory UserInfomation.fromJson(Map<String, dynamic> json) {
    return UserInfomation(
      idStudent: json['idStudent'] ?? '',
      name: json['iDSubject'] ?? '',
      birthDate: json['birthDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              json['birthDate'].millisecondsSinceEpoch,
            )
          : null,
      classRoom: json['classRoom'] ?? '',
      level: json['level'] ?? '',
      field: json['field'] ?? '',
      major: json['major'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
