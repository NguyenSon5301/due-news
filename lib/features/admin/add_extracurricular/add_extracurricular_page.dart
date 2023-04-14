import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

import '../../../common/common.dart';
import '../../../models/extracurricular.dart';
import '../../../services/database_service.dart';
import '../../utils/utils.dart';

class AddExtracurricularPage extends StatefulWidget {
  const AddExtracurricularPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddExtracurricularPage> createState() => _AddExtracurricularPageState();
}

class _AddExtracurricularPageState extends State<AddExtracurricularPage>
    with AutomaticKeepAliveClientMixin<AddExtracurricularPage> {
  int currentPage = 0;
  DatabaseService db = DatabaseService();
  List<DropdownMenuItem> listSemester = [];
  List<DropdownMenuItem> listNameActivity = [];
  List<Extracurricular> listCategoryScore = [];

  final TextEditingController _scoreField = TextEditingController();
  final TextEditingController _idStudentField = TextEditingController();

  String selectedSemester = 'Chọn học kỳ';
  String selectedActivity = 'Chọn tên hoạt động';
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _loadInitSemester();
    _loadInitActivity();
  }

  List<String> items = ['Chọn học kỳ'];
  String kCities = 'Chọn học kỳ';

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
          'NHẬP THÔNG TIN ĐIỂM HOẠT ĐỘNG NGOẠI KHÓA',
          textAlign: TextAlign.center,
          style: SafeGoogleFont(
            'Mulish',
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
      children: [
        const SizedBox(
          width: 120,
          child: Text('Học kỳ:'),
        ),
        SizedBox(
          width: 200,
          child: SearchChoices.single(
            items: listSemester,
            value: selectedSemester,
            hint: "Chọn học kỳ",
            searchHint: "Chọn học kỳ",
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
      children: [
        const Text('Tên hoạt động:'),
        SizedBox(
          width: 200,
          child: SearchChoices.single(
            items: listNameActivity,
            value: selectedActivity,
            hint: "Chọn tên hoạt động",
            searchHint: "Chọn tên hoạt động",
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
      children: [
        const SizedBox(
          width: 120,
          child: Text('Điểm:'),
        ),
        SizedBox(
          width: 200,
          child: TextFormField(
            controller: _scoreField,
            decoration: const InputDecoration(
              labelText: 'Nhập điểm',
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
      children: [
        const SizedBox(
          width: 120,
          child: Text('ID sinh viên:'),
        ),
        SizedBox(
          width: 200,
          child: TextFormField(
            controller: _idStudentField,
            decoration: const InputDecoration(
              labelText: 'Nhập ID',
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
    return ElevatedButton.icon(
      onPressed: _saveData,
      icon: const Icon(Icons.save),
      label: const Text('Save'),
    );
  }

  Future<void> _saveData() async {
    if (selectedSemester.contains('Chọn học kỳ')) {
      _snackBar('Vui lòng chọn học kỳ !!!');
      return;
    }
    if (selectedActivity.contains('Chọn tên hoạt động')) {
      _snackBar('Vui lòng chọn tên hoạt động !!!');
      return;
    }
    if (_scoreField.text.isEmpty) {
      _snackBar('Vui lòng điền điểm !!!');
      return;
    }
    final check = isNumeric(_scoreField.text);
    if (!isNumeric(_scoreField.text)) {
      _snackBar('Vui lòng điền điểm dạng số !!!');
      return;
    }
    if (_idStudentField.text.isEmpty) {
      _snackBar('Vui lòng điền ID học viên !!!');
      return;
    }
    await db.getUserList(_idStudentField.text).then((value) async {
      if (value.isEmpty) {
        _snackBar('Không tìm thấy học viên !!!');
        return;
      }
      var index = -1;
      for (var i = 0; i < listCategoryScore.length; i++) {
        if (selectedActivity == listCategoryScore[i].nameActivity) {
          index = i;
        }
      }
      if (index == -1) {
        _snackBar('Không tìm thấy tên hoạt động !!!');
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
            content: Text('Điểm ngoại khóa đã được thêm'),
          ),
        );
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
