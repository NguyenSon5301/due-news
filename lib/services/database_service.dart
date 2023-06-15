import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../common/common.dart';
import '../models/category_news.dart';
import '../models/extracurricular.dart';
import '../models/semester.dart';
import '../models/token_user.dart';
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
        .doc(UserInfoManager.ins.idStudent)
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
        .doc(UserInfoManager.ins.idStudent)
        .collection('Extracurriculars')
        .orderBy(
          'categoryScore',
        )
        .snapshots();
  }

  Stream<DocumentSnapshot<Object?>> getInformation() {
    return FirebaseFirestore.instance
        .collection('User')
        .doc(UserInfoManager.ins.idStudent)
        .snapshots();
  }

  Future<List<UserInfomation>> getIdStudent() async {
    return _db
        .collection('User')
        .where('email', isEqualTo: user!.email)
        .get()
        .then(
          (value) => value.docs
              .map<UserInfomation>((e) => UserInfomation.fromJson(e.data()))
              .toList(),
        );
  }

  Stream<QuerySnapshot<Object?>> getAllScoresUser() {
    return FirebaseFirestore.instance
        .collection('User')
        .doc(UserInfoManager.ins.idStudent)
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

  Future<List<CategoryNews>> getCategoryNewsList() async {
    return _db.collection('Categories').get().then(
          (value) => value.docs
              .map<CategoryNews>((e) => CategoryNews.fromJson(e.data()))
              .toList(),
        );
  }

  Future<List<TokenUser>> getTokenUser() async {
    return _db.collection('UserTokens').get().then(
          (value) => value.docs
              .map<TokenUser>((e) => TokenUser.fromJson(e.data()))
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
    return _db.collection('User').doc(UserInfoManager.ins.idStudent).get().then(
          (value) => List.from(value.data()!['newsCollection']),
        );
  }

  Future<bool> updateInfo(String field, DateTime data) async {
    final documentReference = FirebaseFirestore.instance
        .collection('User')
        .doc(UserInfoManager.ins.idStudent);

    final add = <String, dynamic>{field: Timestamp.fromDate(data)};
    await documentReference.update(add).then((value) {
      return true;
    });
    return false;
  }

  Future<void> saveToken(String token) async {
    await FirebaseFirestore.instance
        .collection("UserTokens")
        .doc(token)
        .set({'token': token});
  }
}
