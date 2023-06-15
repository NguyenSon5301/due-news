import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../common/common.dart';
import '../../common/constants/constant.dart';
import '../../models/news.dart';
import '../../services/database_service.dart';
import '../details/details_page.dart';
import '../home/widgets/card_view_widget.dart';
import '../utils/utils.dart';

class NewsCollectionPage extends StatefulWidget {
  const NewsCollectionPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NewsCollectionPage> createState() => _NewsCollectionPageState();
}

class _NewsCollectionPageState extends State<NewsCollectionPage>
    with AutomaticKeepAliveClientMixin<NewsCollectionPage> {
  int currentPage = 0;
  DatabaseService db = DatabaseService();
  List<String> listNews = <String>[];
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _loadInitNews();
  }

  Future<void> _loadInitNews() async {
    await db.getListNewsCollection().then(
          (value) => {
            setState(() {
              value.map((e) => listNews.add(e)).toList();
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
                    StreamBuilder<QuerySnapshot>(
                      stream: db.getNewsCollection(list: listNews),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List<News> data = snapshot.data.docs
                              .map<News>((doc) => News.fromJson(doc.data()))
                              .toList();
                          return Column(
                            children: [
                              SizedBox(
                                height: 540,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: data.length > 5 ? 5 : data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final currentIndex =
                                        (currentPage * 5) + index;
                                    if (currentIndex + 1 > data.length) {
                                      return const SizedBox();
                                    }
                                    final dateOnly =
                                        DateFormat('dd/MM/yyyy').format(
                                      data[currentIndex].publishedDate!,
                                    );
                                    return CardViewWidget(
                                      // data[index].reference.id
                                      titleNews: data[currentIndex].titleNews,
                                      publishedDate: dateOnly,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                              idPost: snapshot.data.docs[index]
                                                  .reference.id,
                                              title:
                                                  data[currentIndex].titleNews,
                                              puslishedDate: dateOnly,
                                              description: data[currentIndex]
                                                  .description,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              if (data.isNotEmpty)
                                NumberPaginator(
                                  numberPages: (data.length / 5.0) >
                                          (data.length / 5.0).round()
                                      ? (((data.length / 5.0) + 1.0).round())
                                      : (data.length / 5.0).round(),
                                  onPageChange: (int index) {
                                    setState(() {
                                      currentPage = index;
                                    });
                                  },
                                ),
                            ],
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
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
          StringManager.titleSavePage,
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
}
