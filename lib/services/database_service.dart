import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/extracurricular.dart';
import '../models/news.dart';
import '../models/semester.dart';
import '../models/user_information.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  Stream<QuerySnapshot<Object?>> getNewsWithCategory(
    String? categoryStr,
  ) {
    return _db
        .collection('News')
        .where('category', isEqualTo: categoryStr)
        .orderBy('publishedDate', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>> getNewsCollection({
    required List<String> list,
  }) {
    return _db
        .collection('News')
        .where(FieldPath.documentId, whereIn: list.isNotEmpty ? list : ['1111'])
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>> getScoresWithSemester(
    String? semester,
  ) {
    return FirebaseFirestore.instance
        .collection('User')
        .doc(user!.email)
        .collection('Subjects')
        .where('semester', isEqualTo: semester)
        .orderBy(
          'nameSubject',
        )
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>> getExtracurriculars() {
    return FirebaseFirestore.instance
        .collection('User')
        .doc(user!.email)
        .collection('Extracurriculars')
        .orderBy(
          'categoryScore',
        )
        .snapshots();
  }

  Stream<DocumentSnapshot<Object?>> getInformation() {
    return FirebaseFirestore.instance
        .collection('User')
        .doc(user!.email)
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>> getAllScoresUser() {
    return FirebaseFirestore.instance
        .collection('User')
        .doc(user!.email)
        .collection('Subjects')
        .orderBy(
          'nameSubject',
        )
        .snapshots();
  }

  Future<List<Semester>> getSemesterList() async {
    return _db.collection('Semester').get().then(
          (value) => value.docs
              .map<Semester>((e) => Semester.fromJson(e.data()))
              .toList(),
        );
  }

  Future<List<Extracurricular>> getExtracurricularList() async {
    return _db.collection('Extracurriculars').get().then(
          (value) => value.docs
              .map<Extracurricular>((e) => Extracurricular.fromJson(e.data()))
              .toList(),
        );
  }

  Future<List<UserInfomation>> getUserList(String idStudent) async {
    return _db
        .collection('User')
        .where('idStudent', isEqualTo: idStudent)
        .get()
        .then(
          (value) => value.docs
              .map<UserInfomation>((e) => UserInfomation.fromJson(e.data()))
              .toList(),
        );
  }

  Future<List<String>> getListNewsCollection() async {
    return _db.collection('User').doc(user!.email).get().then(
          (value) => List.from(value.data()!['newsCollection']),
        );
  }

  Future<bool> updateInfo(String field, DateTime data) async {
    final documentReference = FirebaseFirestore.instance.collection('User').doc(
          FirebaseAuth.instance.currentUser!.email.toString(),
        );

    final add = <String, dynamic>{field: Timestamp.fromDate(data)};
    await documentReference.update(add).then((value) {
      return true;
    });
    return false;
  }
}
