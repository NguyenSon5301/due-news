import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/common.dart';
import '../../common/constants/constant.dart';
import '../../models/extracurricular.dart';
import '../../models/subject.dart';
import '../../models/user_information.dart';
import '../../services/database_service.dart';
import '../utils/utils.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage>
    with AutomaticKeepAliveClientMixin<ScorePage> {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _loadInitSemester();
  }

  DatabaseService db = DatabaseService();
  List<String> items = [StringManager.selectSemester];

  void _loadInitSemester() {
    db.getSemesterList().then(
          (value) => {
            setState(() {
              value.map((e) => items.add(e.nameSemester)).toList();
            })
          },
        );
  }

  String semester = StringManager.selectSemester;
  bool? value;
  String? selectedValue;

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    final _menuItems = <DropdownMenuItem<String>>[];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  color: AppColors.blueLight,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<double> _getCustomItemsHeights() {
    final _itemsHeights = <double>[];
    for (var i = 0; i < (items.length * 2) - 1; i++) {
      if (i.isEven) {
        _itemsHeights.add(40);
      }
      if (i.isOdd) {
        _itemsHeights.add(4);
      }
    }
    return _itemsHeights;
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
                    _sizedBox(30),
                    _information(),
                    _sizedBox(10),
                    _typeView(),
                  ],
                ),
              ),
              if (value != null) ...[
                if (value!) ...[
                  _sizedBox(10),
                  _selectSemester(),
                  _sizedBox(20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _tableScore(semester),
                  )
                ] else ...[
                  _sizedBox(20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _tableExtracurricular(),
                  ),
                ]
              ]
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
      children: [
        Text(
          'KẾT QUẢ HỌC TẬP TOÀN KHÓA',
          textAlign: TextAlign.center,
          style: SafeGoogleFont(
            StringManager.mulish,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            height: 1.2,
            color: AppColors.redColor,
          ),
        ),
        Text(
          '(Ngành đào tạo chương trình chính - Chỉ mang tính tham khảo)',
          style: SafeGoogleFont(
            StringManager.mulish,
            fontSize: 8,
            fontWeight: FontWeight.w400,
            height: 1.4,
            color: const Color(0xff94a5aa),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _information() {
    return StreamBuilder<DocumentSnapshot>(
      stream: db.getInformation(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var DocData = snapshot.data;
          Timestamp t = DocData['birthDate'];
          final d = t.toDate();
          final data = UserInfomation(
            birthDate: d,
            name: DocData['name'],
            classRoom: DocData['class'],
            level: DocData['level'],
            field: DocData['field'],
            major: DocData['major'],
            email: DocData['email'],
          );
          final dateOnly = DateFormat('dd/MM/yyyy').format(data.birthDate!);
          return Column(
            children: [
              _detailInfor(StringManager.nameStudent, data.name, 'name', data),
              _sizedBox(10),
              _detailInfor(
                StringManager.birthDateStudent,
                dateOnly,
                'birthDate',
                data,
              ),
              _sizedBox(10),
              _detailInfor(
                StringManager.classStudent,
                data.classRoom,
                'class',
                data,
              ),
              _sizedBox(10),
              _detailInfor(
                StringManager.levelStudent,
                data.level,
                'level',
                data,
              ),
              _sizedBox(10),
              _detailInfor(
                StringManager.fieldStudent,
                data.field,
                'field',
                data,
              ),
              _sizedBox(10),
              _detailInfor(
                StringManager.majorStudent,
                data.major,
                'major',
                data,
              )
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _detailInfor(
    String title,
    String data,
    String field,
    UserInfomation userInfo,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: SafeGoogleFont(
                StringManager.mulish,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.4,
                color: AppColors.blue,
              ),
            ),
          ),
          GestureDetector(
            onTap: field == 'birthDate'
                ? () async {
                    await _pickDate(title, field, userInfo);
                  }
                : null,
            child: Row(
              children: [
                SizedBox(
                  width: field == 'birthDate' ? 100 : 180,
                  child: Text(
                    ':  $data',
                    style: SafeGoogleFont(
                      StringManager.mulish,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      color: AppColors.blue,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (field == 'birthDate')
                  IconButton(
                    onPressed: () async {
                      await _pickDate(title, field, userInfo);
                    },
                    icon: const Icon(
                      Icons.date_range_outlined,
                      size: 20,
                      color: AppColors.green,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _typeView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: DropdownButtonFormField(
        onChanged: (newValue) {
          setState(() {
            value = newValue;
          });
        },
        value: value,
        items: [
          DropdownMenuItem(
            value: null,
            child: Text(
              StringManager.selectSearchType,
              style: TextStyle(color: AppColors.redColor),
            ),
          ),
          const DropdownMenuItem(
            value: true,
            child: Text(
              StringManager.scoreSuject,
              style: TextStyle(color: AppColors.blueLight),
            ),
          ),
          const DropdownMenuItem(
            value: false,
            child: Text(
              StringManager.scoreExtracuricularActivity,
              style: TextStyle(color: AppColors.blueLight),
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectSemester() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 63, left: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringManager.selectSemester,
                    style: SafeGoogleFont(
                      StringManager.mulish,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      color: AppColors.redColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  _sizedBox(15),
                  Text(
                    ':',
                    style: SafeGoogleFont(
                      StringManager.mulish,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      color: AppColors.blueLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      items: _addDividersAfterItems(items),
                      value: semester,
                      onChanged: (value) {
                        setState(() {
                          semester = value as String;
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        height: 40,
                        width: 140,
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 200,
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        customHeights: _getCustomItemsHeights(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tableScore(String semester) {
    return SizedBox(
      width: 1000,
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Table(
              border: TableBorder.all(color: AppColors.blueLight),
              columnWidths: const {
                0: FixedColumnWidth(100),
                1: FixedColumnWidth(300),
                2: FixedColumnWidth(80),
                3: FixedColumnWidth(80),
                4: FixedColumnWidth(100),
                5: FixedColumnWidth(200)
              },
              children: [
                TableRow(
                  children: [
                    _titleTable('Mã học phần'),
                    _titleTable('Tên học phần'),
                    _titleTable('Số tín chỉ'),
                    _titleTable('Điểm'),
                    _titleTable('Thang Điểm 10'),
                    _titleTable('Ghi chú'),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: 860,
              height: 30,
              decoration: const BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(color: AppColors.blueLight),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                child: Text(
                  semester,
                  style: SafeGoogleFont(
                    StringManager.mulish,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    color: AppColors.blueLight,
                  ),
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: db.getScoresWithSemester(semester),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<Subject> data = snapshot.data.docs
                    .map<Subject>((doc) => Subject.fromJson(doc.data()))
                    .toList();
                return Column(
                  children: [
                    for (var i = 0; i < data.length; i++) ...[
                      Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Table(
                          border: const TableBorder(
                            left: BorderSide(color: AppColors.blueLight),
                            right: BorderSide(color: AppColors.blueLight),
                            top: BorderSide(color: AppColors.blueLight),
                            horizontalInside:
                                BorderSide(color: AppColors.blueLight),
                            verticalInside:
                                BorderSide(color: AppColors.blueLight),
                          ),
                          columnWidths: const {
                            0: FixedColumnWidth(100),
                            1: FixedColumnWidth(300),
                            2: FixedColumnWidth(80),
                            3: FixedColumnWidth(80),
                            4: FixedColumnWidth(100),
                            5: FixedColumnWidth(200)
                          },
                          children: [
                            TableRow(
                              children: [
                                _titleTable(
                                  data[i].idSubject,
                                ),
                                TextButton(
                                  child: Text(data[i].nameSubject),
                                  onPressed: () {
                                    _showDialog(context);
                                  },
                                ),
                                _titleTable(data[i].credit.toString()),
                                TextButton(
                                  onPressed: () => _showSpecificScoreSubject(
                                    data[i].nameSubject,
                                    data[i].semester,
                                    data[i].score1,
                                    data[i].score2,
                                    data[i].score3,
                                  ),
                                  child: Text(
                                    _calculatorScore(
                                      data[i].score1,
                                      data[i].score2,
                                      data[i].score3,
                                    ).toStringAsFixed(1),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => _showSpecificScoreSubject(
                                    data[i].nameSubject,
                                    data[i].semester,
                                    data[i].score1,
                                    data[i].score2,
                                    data[i].score3,
                                  ),
                                  child: Text(
                                    _checkScoreString(
                                      _calculatorScore(
                                        data[i].score1,
                                        data[i].score2,
                                        data[i].score3,
                                      ),
                                    ),
                                  ),
                                ),
                                _titleTable(data[i].note),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: 860,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.blueLight),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Text(
                                'Số tín chỉ tích lũy',
                                style: SafeGoogleFont(
                                  StringManager.mulish,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4,
                                  color: AppColors.blueLight,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Text(
                                _totalCredit(data).toString(),
                                style: SafeGoogleFont(
                                  StringManager.mulish,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4,
                                  color: AppColors.blueLight,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Text(
                                'Điểm TB Học kỳ',
                                style: SafeGoogleFont(
                                  StringManager.mulish,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4,
                                  color: AppColors.blueLight,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Text(
                                _averageSemesterScores(data).toString(),
                                style: SafeGoogleFont(
                                  StringManager.mulish,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4,
                                  color: AppColors.blueLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _tableExtracurricular() {
    return SizedBox(
      width: 1000,
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Table(
              border: const TableBorder(
                left: BorderSide(color: AppColors.blueLight),
                right: BorderSide(color: AppColors.blueLight),
                top: BorderSide(color: AppColors.blueLight),
                horizontalInside: BorderSide(color: AppColors.blueLight),
                verticalInside: BorderSide(color: AppColors.blueLight),
              ),
              columnWidths: const {
                0: FixedColumnWidth(50),
                1: FixedColumnWidth(200),
                2: FixedColumnWidth(350),
                3: FixedColumnWidth(80),
                4: FixedColumnWidth(80),
              },
              children: [
                TableRow(
                  children: [
                    _titleTable(StringManager.ordinalNumberTable),
                    _titleTable(StringManager.semesterTable),
                    _titleTable(StringManager.nameActivityTable),
                    _titleTable(StringManager.menuActivityTable),
                    _titleTable(StringManager.scoreActivityTable),
                  ],
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: db.getExtracurriculars(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<Extracurricular> data = snapshot.data.docs
                    .map<Extracurricular>(
                      (doc) => Extracurricular.fromJson(doc.data()),
                    )
                    .toList();
                return Column(
                  children: [
                    for (var i = 0; i < data.length; i++) ...[
                      Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Table(
                          border: const TableBorder(
                            left: BorderSide(color: AppColors.blueLight),
                            right: BorderSide(color: AppColors.blueLight),
                            top: BorderSide(color: AppColors.blueLight),
                            horizontalInside:
                                BorderSide(color: AppColors.blueLight),
                            verticalInside:
                                BorderSide(color: AppColors.blueLight),
                          ),
                          columnWidths: const {
                            0: FixedColumnWidth(50),
                            1: FixedColumnWidth(200),
                            2: FixedColumnWidth(350),
                            3: FixedColumnWidth(80),
                            4: FixedColumnWidth(80),
                          },
                          children: [
                            TableRow(
                              children: [
                                _titleTable(
                                  (i + 1).toString(),
                                ),
                                TextButton(
                                  child: Text(data[i].semester),
                                  onPressed: () {
                                    _showDialog(context);
                                  },
                                ),
                                _titleTable(data[i].nameActivity),
                                _titleTable(data[i].categoryScore.toString()),
                                _titleTable(data[i].score.toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Table(
                        border: TableBorder.all(color: AppColors.blueLight),
                        columnWidths: const {
                          0: FixedColumnWidth(50),
                          1: FixedColumnWidth(200),
                          2: FixedColumnWidth(350),
                          3: FixedColumnWidth(80),
                          4: FixedColumnWidth(80),
                        },
                        children: [
                          TableRow(
                            children: [
                              _titleTable(''),
                              TextButton(
                                child: const Text(''),
                                onPressed: () {
                                  _showDialog(context);
                                },
                              ),
                              _titleTable(StringManager.totalScore),
                              _titleTable(''),
                              _titleTable(
                                _totalExtracurricularScores(data).toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _sizedBox(30),
                    RichText(
                      text: TextSpan(
                        text: StringManager.classScoreExtracuricularActivity,
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontSize: 20,
                              color: AppColors.blueLight,
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: _classExtracurricularActivity(
                              _totalExtracurricularScores(data),
                            ),
                            style: TextStyle(
                              color: _totalExtracurricularScores(data) > 50
                                  ? AppColors.green
                                  : AppColors.redColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _titleTable(String title) {
    return TextButton(
      onPressed: null,
      child: Text(
        title,
        style: const TextStyle(color: AppColors.blue),
      ),
    );
  }

  double _calculatorScore(double score1, double score2, double score3) {
    final total = (score1 * 0.1) + (score2 * 0.2) + (score3 * 0.6);
    return total;
  }

  String _checkScoreString(double score) {
    if (8.5 <= score && score <= 10) {
      return 'A';
    } else if (7.0 <= score && score <= 8.4) {
      return 'B';
    } else if (5.5 <= score && score <= 6.9) {
      return 'C';
    } else if (4.0 <= score && score <= 5.4) {
      return 'D';
    } else {
      return 'F';
    }
  }

  int _totalCredit(List<Subject> credits) {
    var total = 0;
    for (var i = 0; i < credits.length; i++) {
      total += credits[i].credit;
    }
    return total;
  }

  int _totalExtracurricularScores(List<Extracurricular> scores) {
    var total = 0;
    var totalCategory1 = 0;
    var totalCategory2 = 0;
    var totalCategory3 = 0;

    for (var i = 0; i < scores.length; i++) {
      if (scores[i].categoryScore == 1) {
        totalCategory1 += scores[i].score;
      } else if (scores[i].categoryScore == 2) {
        totalCategory2 += scores[i].score;
      } else if (scores[i].categoryScore == 3) {
        totalCategory3 += scores[i].score;
      }
    }
    if (totalCategory1 > 25) {
      totalCategory1 = 25;
    }
    if (totalCategory2 > 40) {
      totalCategory2 = 40;
    }
    if (totalCategory3 > 40) {
      totalCategory3 = 25;
    }
    return totalCategory1 + totalCategory2 + totalCategory3;
  }

  String _classExtracurricularActivity(int score) {
    if (score >= 90) {
      return 'Xuất sắc';
    } else if (score >= 80) {
      return 'Tốt';
    } else if (score >= 65) {
      return 'Khá';
    } else if (score >= 50) {
      return 'Đạt';
    } else {
      return 'Chưa đạt';
    }
  }

  double _averageSemesterScores(List<Subject> scores) {
    var total = 0.0;
    for (var i = 0; i < scores.length; i++) {
      final scoreType = _checkScoreString(
        _calculatorScore(
          scores[i].score1,
          scores[i].score2,
          scores[i].score3,
        ),
      );
      if (scoreType == 'A') {
        total = total + (4 * scores[i].credit);
      } else if (scoreType == 'B') {
        total = total + (3 * scores[i].credit);
      } else if (scoreType == 'C') {
        total = total + (2 * scores[i].credit);
      } else if (scoreType == 'D') {
        total = total + (1 * scores[i].credit);
      } else if (scoreType == 'F') {
        total = total + (0 * scores[i].credit);
      }
    }
    return total / _totalCredit(scores);
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(vertical: 150, horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(StringManager.titleScorePage),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: db.getAllScoresUser(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List<Subject> data = snapshot.data.docs
                            .map<Subject>(
                              (doc) => Subject.fromJson(doc.data()),
                            )
                            .toList();
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.transparent,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Table(
                                border: TableBorder.all(
                                  color: AppColors.blueLight,
                                ),
                                columnWidths: const {
                                  0: FixedColumnWidth(50),
                                  1: FixedColumnWidth(200),
                                  2: FixedColumnWidth(300),
                                  3: FixedColumnWidth(80),
                                  4: FixedColumnWidth(80),
                                  5: FixedColumnWidth(80),
                                  6: FixedColumnWidth(80)
                                },
                                children: [
                                  TableRow(
                                    children: [
                                      _titleTable(
                                        StringManager.ordinalNumberTable,
                                      ),
                                      _titleTable(StringManager.semesterTable),
                                      _titleTable(StringManager.subject),
                                      _titleTable(StringManager.scorePart1),
                                      _titleTable(StringManager.scorePart2),
                                      _titleTable(StringManager.scorePart3),
                                      _titleTable(StringManager.averageScore),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            for (var i = 0; i < data.length; i++) ...[
                              Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Table(
                                  border: const TableBorder(
                                    left: BorderSide(
                                      color: AppColors.blueLight,
                                    ),
                                    right: BorderSide(
                                      color: AppColors.blueLight,
                                    ),
                                    bottom: BorderSide(
                                      color: AppColors.blueLight,
                                    ),
                                    horizontalInside: BorderSide(
                                      color: AppColors.blueLight,
                                    ),
                                    verticalInside: BorderSide(
                                      color: AppColors.blueLight,
                                    ),
                                  ),
                                  columnWidths: const {
                                    0: FixedColumnWidth(50),
                                    1: FixedColumnWidth(200),
                                    2: FixedColumnWidth(300),
                                    3: FixedColumnWidth(80),
                                    4: FixedColumnWidth(80),
                                    5: FixedColumnWidth(80),
                                    6: FixedColumnWidth(80)
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        _titleTable((i + 1).toString()),
                                        _titleTable(
                                          data[i].semester,
                                        ),
                                        _titleTable(data[i].nameSubject),
                                        _titleTable(
                                          data[i].score1.toString(),
                                        ),
                                        _titleTable(
                                          data[i].score2.toString(),
                                        ),
                                        _titleTable(
                                          data[i].score3.toString(),
                                        ),
                                        _titleTable(
                                          _calculatorScore(
                                            data[i].score1,
                                            data[i].score2,
                                            data[0].score3,
                                          ).toStringAsFixed(1),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showSpecificScoreSubject(
    String nameSubject,
    String semester,
    double score1,
    double score2,
    double score3,
  ) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(vertical: 250, horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Điểm số môn: $nameSubject'),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Table(
                          border: TableBorder.all(
                            color: AppColors.blueLight,
                          ),
                          columnWidths: const {
                            0: FixedColumnWidth(50),
                            1: FixedColumnWidth(300),
                            2: FixedColumnWidth(100),
                            3: FixedColumnWidth(100),
                            4: FixedColumnWidth(100),
                            5: FixedColumnWidth(100),
                          },
                          children: [
                            TableRow(
                              children: [
                                _titleTable(StringManager.ordinalNumberTable),
                                _titleTable(StringManager.semesterTable),
                                _titleTable(StringManager.scorePart1),
                                _titleTable(StringManager.scorePart2),
                                _titleTable(StringManager.scorePart3),
                                _titleTable(StringManager.averageScore),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Table(
                          border: TableBorder.all(
                            color: AppColors.blueLight,
                          ),
                          columnWidths: const {
                            0: FixedColumnWidth(50),
                            1: FixedColumnWidth(300),
                            2: FixedColumnWidth(100),
                            3: FixedColumnWidth(100),
                            4: FixedColumnWidth(100),
                            5: FixedColumnWidth(100),
                          },
                          children: [
                            TableRow(
                              children: [
                                _titleTable('1'),
                                _titleTable(semester),
                                _titleTable(score1.toString()),
                                _titleTable(score2.toString()),
                                _titleTable(score3.toString()),
                                _titleTable(
                                  _calculatorScore(score1, score2, score3)
                                      .toStringAsFixed(1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickDate(
    String title,
    String field,
    UserInfomation userInfo,
  ) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: userInfo.birthDate!,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      await db.updateInfo(field, pickedDate);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$title cập nhật thành công'),
        ),
      );
    } else {}
  }
}
