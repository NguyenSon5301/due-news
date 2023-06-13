import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:search_choices/search_choices.dart';

import '../../../common/common.dart';
import '../../../common/constants/constant.dart';
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
  final TextEditingController _titleField = TextEditingController();
  DateTime currentPickedDate = DateTime.now();
  int max = 0;
  List<DropdownMenuItem> listCategoryNews = [];
  String selectedCategoryNews = StringManager.typeCategoryNews;

  late QuillEditorController descriptionController;

  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.clean,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
  ];

  final _toolbarColor = Colors.grey.shade200;
  final _backgroundColor = Colors.white70;
  final _toolbarIconColor = Colors.black87;
  final _editorTextStyle = const TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );
  final _hintTextStyle = const TextStyle(
    fontSize: 18,
    color: Colors.black12,
    fontWeight: FontWeight.normal,
  );

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    descriptionController = QuillEditorController();

    _loadInitCategoryNews();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void _loadInitCategoryNews() {
    db.getCategoryNewsList().then(
          (value) => {
            setState(() {
              value
                  .map(
                    (e) => listCategoryNews.add(
                      DropdownMenuItem(
                        value: e.nameCategory,
                        child: Text(
                          e.nameCategory,
                        ),
                      ),
                    ),
                  )
                  .toList();
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
                    _sizedBox(50),
                    _idNews(),
                    _sizedBox(20),
                    _titleNewsRow(),
                    _sizedBox(20),
                    _publishedDateRow(),
                    _sizedBox(20),
                    _categoryNewsRow(),
                    _sizedBox(20),
                    _descriptionNewsRow(),
                    _sizedBox(30),
                    _buttonSave(),
                    _sizedBox(30),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          StringManager.captionAdminNews,
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

  Widget _idNews() {
    return StreamBuilder<QuerySnapshot>(
      stream: db.getNewsWithCategory(null),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          for (var i = 0; i < snapshot.data.docs.length; i++) {
            if (int.parse(snapshot.data.docs[i].reference.id) > max) {
              max = int.parse(snapshot.data.docs[i].reference.id);
            }
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Table(
                  columnWidths: const {
                    0: FixedColumnWidth(200),
                    1: FixedColumnWidth(500),
                  },
                  children: [
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 18,
                          ),
                          child: Text(
                            '${StringManager.idNews}:',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 18,
                          ),
                          child: Text(
                            (max + 1).toString(),
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                      ],
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
    );
  }

  Widget _titleNewsRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(200),
              1: FixedColumnWidth(500),
            },
            children: [
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                    child: Text(
                      '${StringManager.titleNews}:',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    controller: _titleField,
                    decoration: const InputDecoration(
                      labelText: StringManager.typeTitleNews,
                      border: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 5),
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

  Widget _publishedDateRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(200),
              1: FixedColumnWidth(500),
            },
            children: [
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                    child: Text(
                      '${StringManager.pubLishedDate}:',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _pickDate();
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 180,
                          child: Text(
                            DateFormat('dd/MM/yyyy').format(currentPickedDate),
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await _pickDate();
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
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: currentPickedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        currentPickedDate = pickedDate;
      });
    }
  }

  Widget _categoryNewsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(200),
              1: FixedColumnWidth(500),
            },
            children: [
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                    child: Text(
                      '${StringManager.categoryNews}:',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: SearchChoices.single(
                      items: listCategoryNews,
                      value: selectedCategoryNews,
                      hint: StringManager.typeCategoryNews,
                      searchHint: StringManager.typeCategoryNews,
                      onChanged: (value) {
                        setState(() {
                          selectedCategoryNews = value;
                        });
                      },
                      isExpanded: true,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _descriptionNewsRow() {
    return Column(
      children: [
        const Text(
          StringManager.descriptionNews,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 100,
            vertical: 20,
          ),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 10,
                    color: AppColors.white,
                    child: SizedBox(
                      width: 1250,
                      child: ToolBar.scroll(
                        toolBarColor: _toolbarColor,
                        padding: const EdgeInsets.all(8),
                        iconSize: 25,
                        iconColor: _toolbarIconColor,
                        activeIconColor: Colors.greenAccent.shade400,
                        controller: descriptionController,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        customButtons: [
                          InkWell(
                            onTap: unFocusEditor,
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.black,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              final selectedText =
                                  await descriptionController.getSelectedText();
                              debugPrint(
                                'selectedText $selectedText',
                              );
                              final selectedHtmlText =
                                  await descriptionController
                                      .getSelectedHtmlText();
                              debugPrint(
                                'selectedHtmlText $selectedHtmlText',
                              );
                            },
                            child: const Icon(
                              Icons.add_circle,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 20,
                    ),
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: QuillHtmlEditor(
                          hintText: 'Viết nội dung báo cáo',
                          controller: descriptionController,
                          isEnabled: true,
                          minHeight: 500,
                          textStyle: _editorTextStyle,
                          hintTextStyle: _hintTextStyle,
                          hintTextAlign: TextAlign.start,
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 10,
                          ),
                          hintTextPadding: const EdgeInsets.only(
                            left: 20,
                          ),
                          backgroundColor: _backgroundColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void unFocusEditor() => descriptionController.unFocus();
  Future<void> setHtmlText(String text) async {
    await descriptionController.setText(text);
  }

  Widget _buttonSave() {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton.icon(
        onPressed: _saveData,
        icon: const Icon(Icons.save),
        label: const Text('Lưu bài báo'),
      ),
    );
  }

  Future<void> _saveData() async {
    if (_titleField.text.isEmpty) {
      _snackBar(StringManager.requestTypeTitleNews);
    } else if (selectedCategoryNews.contains(StringManager.typeCategoryNews)) {
      _snackBar(StringManager.requestSelectCategory);
    } else if (descriptionController.getText() ==
        StringManager.typeDescriptionNews) {
      _snackBar(StringManager.requestTypeDescription);
    } else {
      final getHtmlText = await descriptionController.getText();
      final documentReference = FirebaseFirestore.instance
          .collection('News')
          .doc((max + 1).toString());
      final add = <String, dynamic>{
        'category': selectedCategoryNews,
        'description': getHtmlText,
        'publishedDate': Timestamp.fromDate(currentPickedDate),
        'titleNews': _titleField.text,
      };
      await documentReference.set(add).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(StringManager.addNewsSuccess),
          ),
        );
        setState(() {
          _titleField.text = '';
          currentPickedDate = DateTime.now();
          selectedCategoryNews = StringManager.typeCategoryNews;
          descriptionController.setText(StringManager.typeDescriptionNews);
        });
      });
    }
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
}
