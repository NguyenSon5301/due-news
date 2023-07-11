import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

import '../../../common/common.dart';
import '../../../common/constants/constant.dart';
import '../../../models/extracurricular.dart';
import '../../../models/subject.dart';
import '../../../services/database_service.dart';
import '../../utils/utils.dart';

class AddSubjectScorePage extends StatefulWidget {
  const AddSubjectScorePage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddSubjectScorePage> createState() => _AddSubjectScorePageState();
}

class _AddSubjectScorePageState extends State<AddSubjectScorePage>
    with AutomaticKeepAliveClientMixin<AddSubjectScorePage> {
  int currentPage = 0;
  DatabaseService db = DatabaseService();
  List<DropdownMenuItem> listSemester = [];
  List<DropdownMenuItem> listNameSubject = [];
  List<Subject> listCreditScore = [];

  final TextEditingController _score1Field = TextEditingController();
  final TextEditingController _score2Field = TextEditingController();
  final TextEditingController _score3Field = TextEditingController();
  final TextEditingController _noteField = TextEditingController();

  final TextEditingController _idStudentField = TextEditingController();

  String selectedSemester = StringManager.selectSemester;
  String selectedSubject = StringManager.selectNameSubject;
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _loadInitSemester();
    _loadInitActivity();
  }

  List<String> items = [StringManager.selectSemester];
  String kCities = StringManager.selectSemester;

  void _loadInitSemester() {
    db.getSemesterList().then(
          (value) => {
            setState(() {
              value
                  .map(
                    (e) => listSemester.add(
                      DropdownMenuItem(
                        value: e.nameSemester,
                        child: Text(
                          e.nameSemester,
                        ),
                      ),
                    ),
                  )
                  .toList();
            })
          },
        );
  }

  void _loadInitActivity() {
    db.getSubjectList().then(
          (value) => {
            setState(() {
              value.map((e) {
                listNameSubject.add(
                  DropdownMenuItem(
                    value: e.nameSubject,
                    child: Text(
                      e.nameSubject,
                    ),
                  ),
                );
                listCreditScore.add(e);
              }).toList();
            })
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Background(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _sizedBox(50),
                    _header(),
                    _sizedBox(20),
                    _idStudent(),
                    _sizedBox(20),
                    _semesterRow(),
                    _sizedBox(20),
                    _nameSubjectRow(),
                    _sizedBox(20),
                    _score1Row(),
                    _sizedBox(20),
                    _score2Row(),
                    _sizedBox(20),
                    _score3Row(),
                    _sizedBox(20),
                    _noteRow(),
                    _sizedBox(30),
                    _buttonSave(),
                    _sizedBox(50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sizedBox(double height) => SizedBox(
        height: height,
      );

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          StringManager.addSubjectScoreTitle,
          textAlign: TextAlign.center,
          style: SafeGoogleFont(
            StringManager.mulish,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            height: 1.2,
            color: AppColors.redColor,
          ),
        ),
      ],
    );
  }

  Widget _semesterRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 120,
          child: Text(StringManager.semesterAdmin),
        ),
        SizedBox(
          width: 300,
          child: SearchChoices.single(
            items: listSemester,
            value: selectedSemester,
            hint: StringManager.selectSemester,
            searchHint: StringManager.selectSemester,
            onChanged: (value) {
              setState(() {
                selectedSemester = value;
              });
            },
            isExpanded: true,
          ),
        )
      ],
    );
  }

  Widget _nameSubjectRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 120,
          child: Text('${StringManager.subject}:'),
        ),
        SizedBox(
          width: 300,
          child: SearchChoices.single(
            items: listNameSubject,
            value: selectedSubject,
            hint: StringManager.selectNameSubject,
            searchHint: StringManager.selectNameSubject,
            onChanged: (value) {
              setState(() {
                selectedSubject = value;
              });
            },
            isExpanded: true,
          ),
        )
      ],
    );
  }

  Widget _score1Row() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 120,
          child: Text('${StringManager.typeScoreAdmin} 1:'),
        ),
        SizedBox(
          width: 300,
          child: TextFormField(
            controller: _score1Field,
            decoration: const InputDecoration(
              labelText: StringManager.typeScoreAdmin,
              border: OutlineInputBorder(),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 5),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _score2Row() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 120,
          child: Text('${StringManager.typeScoreAdmin} 2:'),
        ),
        SizedBox(
          width: 300,
          child: TextFormField(
            controller: _score2Field,
            decoration: const InputDecoration(
              labelText: StringManager.typeScoreAdmin,
              border: OutlineInputBorder(),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 5),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _score3Row() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 120,
          child: Text('${StringManager.typeScoreAdmin} 3:'),
        ),
        SizedBox(
          width: 300,
          child: TextFormField(
            controller: _score3Field,
            decoration: const InputDecoration(
              labelText: StringManager.typeScoreAdmin,
              border: OutlineInputBorder(),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 5),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _noteRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 120,
          child: Text('${StringManager.note}:'),
        ),
        SizedBox(
          width: 300,
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            controller: _noteField,
            decoration: const InputDecoration(
              labelText: StringManager.note,
              border: OutlineInputBorder(),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 5),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _idStudent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 120,
          child: Text(StringManager.idStudentAdmin),
        ),
        SizedBox(
          width: 300,
          child: TextFormField(
            controller: _idStudentField,
            decoration: const InputDecoration(
              labelText: StringManager.typeIDStudent,
              border: OutlineInputBorder(),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 5),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buttonSave() {
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton.icon(
        onPressed: _saveData,
        icon: const Icon(Icons.save),
        label: const Text('Lưu điểm học phần'),
      ),
    );
  }

  Future<void> _saveData() async {
    if (_idStudentField.text.isEmpty) {
      _snackBar(StringManager.typeIDStudentPls);
      return;
    }
    if (!isNumeric(_idStudentField.text)) {
      _snackBar(StringManager.typeIDStudnetPls);
      return;
    }
    if (selectedSemester.contains(StringManager.selectSemester)) {
      _snackBar(StringManager.selectSemesterPls);
      return;
    }
    if (selectedSubject.contains(StringManager.selectNameSubject)) {
      _snackBar(StringManager.selectSubjectPls);
      return;
    }
    if (_score1Field.text.isEmpty) {
      _snackBar(StringManager.typeScorePls);
      return;
    }

    if (!isNumeric(_score1Field.text)) {
      _snackBar(StringManager.typeScoreNumberPls);
      return;
    }
    if (int.parse(_score1Field.text) < 0 && int.parse(_score1Field.text) > 10) {
      _snackBar(StringManager.typeScoreRightPls);
      return;
    }
    if (_score2Field.text.isEmpty) {
      _snackBar(StringManager.typeScorePls);
      return;
    }
    if (!isNumeric(_score2Field.text)) {
      _snackBar(StringManager.typeScoreNumberPls);
      return;
    }
    if (int.parse(_score2Field.text) < 0 && int.parse(_score2Field.text) > 10) {
      _snackBar(StringManager.typeScoreRightPls);
      return;
    }
    if (_score3Field.text.isEmpty) {
      _snackBar(StringManager.typeScorePls);
      return;
    }
    if (!isNumeric(_score3Field.text)) {
      _snackBar(StringManager.typeScoreNumberPls);
      return;
    }
    if (int.parse(_score3Field.text) < 0 && int.parse(_score3Field.text) > 10) {
      _snackBar(StringManager.typeScoreRightPls);
      return;
    }

    await db.getUserList(_idStudentField.text).then((value) async {
      if (value.isEmpty) {
        _snackBar(StringManager.idStudentNotFound);
        return;
      }
      var index = -1;
      for (var i = 0; i < listNameSubject.length; i++) {
        if (selectedSubject == listNameSubject[i].value) {
          index = i;
        }
      }
      if (index == -1) {
        _snackBar(StringManager.subjectNotFound);
        return;
      }
      final documentReference = FirebaseFirestore.instance
          .collection('User')
          .doc(_idStudentField.text)
          .collection('Subjects')
          .doc(listCreditScore[index].idSubject);
      final add = <String, dynamic>{
        'credit': listCreditScore[index].credit,
        'iDSubject': listCreditScore[index].idSubject,
        'nameSubject': selectedSubject,
        'note': _noteField.text,
        'score1': int.parse(_score1Field.text),
        'score2': int.parse(_score2Field.text),
        'score3': int.parse(_score3Field.text),
        'semester': selectedSemester,
      };
      await documentReference.set(add).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(StringManager.addSubjectSuccessfully),
          ),
        );
        setState(() {
          _idStudentField.text = '';
          _score1Field.text = '';
          _score2Field.text = '';
          _score3Field.text = '';
          _noteField.text = '';
          selectedSemester = StringManager.selectSemester;
          selectedSubject = StringManager.selectNameSubject;
        });
      });
    });
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _snackBar(
    String title,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(16),
          height: 50,
          decoration: const BoxDecoration(
            color: AppColors.red,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  bool isNumeric(String str) {
    final numeric = RegExp(r'^-?[0-9]+$');
    return numeric.hasMatch(str);
  }
}
