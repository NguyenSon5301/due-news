import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

import '../../../common/common.dart';
import '../../../common/constants/constant.dart';
import '../../../models/extracurricular.dart';
import '../../../services/database_service.dart';
import '../../utils/utils.dart';

class AddNewsPage extends StatefulWidget {
  const AddNewsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewsPage> createState() => _AddNewsPageState();
}

class _AddNewsPageState extends State<AddNewsPage>
    with AutomaticKeepAliveClientMixin<AddNewsPage> {
  int currentPage = 0;
  DatabaseService db = DatabaseService();
  List<DropdownMenuItem> listSemester = [];
  List<DropdownMenuItem> listNameActivity = [];
  List<Extracurricular> listCategoryScore = [];

  final TextEditingController _scoreField = TextEditingController();
  final TextEditingController _idStudentField = TextEditingController();

  String selectedSemester = StringManager.selectSemester;
  String selectedActivity = StringManager.selectNameActivity;
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
    db.getExtracurricularList().then(
          (value) => {
            setState(() {
              value.map((e) {
                listNameActivity.add(
                  DropdownMenuItem(
                    value: e.nameActivity,
                    child: Text(
                      e.nameActivity,
                    ),
                  ),
                );
                listCategoryScore.add(e);
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
                    _semesterRow(),
                    _sizedBox(20),
                    _nameActivityRow(),
                    _sizedBox(20),
                    _scoreRow(),
                    _sizedBox(20),
                    _idStudent(),
                    _sizedBox(30),
                    _buttonSave(),
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
          StringManager.captionAdmin,
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
          width: 200,
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

  Widget _nameActivityRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 120,
          child: Text(StringManager.nameActivityAdmin),
        ),
        SizedBox(
          width: 200,
          child: SearchChoices.single(
            items: listNameActivity,
            value: selectedActivity,
            hint: StringManager.selectNameActivity,
            searchHint: StringManager.selectNameActivity,
            onChanged: (value) {
              setState(() {
                selectedActivity = value;
              });
            },
            isExpanded: true,
          ),
        )
      ],
    );
  }

  Widget _scoreRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 120,
          child: Text(StringManager.scoreAdmin),
        ),
        SizedBox(
          width: 200,
          child: TextFormField(
            controller: _scoreField,
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
          width: 200,
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
        width: 200,
        child: ElevatedButton.icon(
          onPressed: _saveData,
          icon: const Icon(Icons.save),
          label: const Text('Save'),
        ));
  }

  Future<void> _saveData() async {
    if (selectedSemester.contains(StringManager.selectSemester)) {
      _snackBar(StringManager.reportAdmin1);
      return;
    }
    if (selectedActivity.contains(StringManager.selectNameActivity)) {
      _snackBar(StringManager.reportAdmin2);
      return;
    }
    if (_scoreField.text.isEmpty) {
      _snackBar(StringManager.reportAdmin3);
      return;
    }
    // final check = isNumeric(_scoreField.text);
    if (!isNumeric(_scoreField.text)) {
      _snackBar(StringManager.reportAdmin4);
      return;
    }
    if (_idStudentField.text.isEmpty) {
      _snackBar(StringManager.reportAdmin5);
      return;
    }
    await db.getUserList(_idStudentField.text).then((value) async {
      if (value.isEmpty) {
        _snackBar(StringManager.reportAdmin6);
        return;
      }
      var index = -1;
      for (var i = 0; i < listNameActivity.length; i++) {
        if (selectedActivity == listNameActivity[i].value) {
          index = i;
        }
      }
      if (index == -1) {
        _snackBar(StringManager.reportAdmin7);
        return;
      }
      var documentReference = FirebaseFirestore.instance
          .collection('User')
          .doc(value[0].email)
          .collection('Extracurriculars');
      final add = <String, dynamic>{
        'categoryScore': listCategoryScore[index].categoryScore,
        'nameActivity': selectedActivity,
        'score': int.parse(_scoreField.text),
        'semester': selectedSemester,
      };
      await documentReference.add(add).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(StringManager.reportAdmin8),
          ),
        );
        setState(() {
          _idStudentField.text = '';
          _scoreField.text = '';
          selectedSemester = StringManager.selectSemester;
          selectedActivity = StringManager.selectNameActivity;
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
