import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:rxdart/subjects.dart';

import '../../common/common.dart';
import '../../common/constants/constant.dart';
import '../../common/singleton/category_news_singleton.dart';
import '../../models/news.dart';
import '../../services/database_service.dart';
import '../../services/link_services.dart';
import '../details/details_page.dart';
import '../utils/utils.dart';
import '../widgets/spacer/spacer_custom.dart';
import 'widgets/card_view_widget.dart';
import 'widgets/home_header_widget.dart';
import 'widgets/horizontal_category_list.dart';
import 'widgets/top_slider_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;
  String? categoryStr;
  DatabaseService db = DatabaseService();
  int currentPage = 0;
  List<String> listCategoryNews = [];

  @override
  void initState() {
    super.initState();
    _loadInitCategoryNews();
    CategoryNews.ins.category$ = BehaviorSubject<String?>.seeded(null)
      ..stream.listen((event) {
        setState(() {
          categoryStr = event;
          currentPage = 0;
        });
      });
    LinkService.ins.initDynamicLinks();
  }

  @override
  void dispose() {
    CategoryNews.ins.category$?.close();
    super.dispose();
  }

  void _loadInitCategoryNews() {
    db.getCategoryNewsList().then(
          (value) => {
            setState(() {
              value
                  .map(
                    (e) => listCategoryNews.add(e.nameCategory),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const HomeHeaderWidget(),
                const CustomHeightSpacer(
                  size: 0.04,
                ),
                const TopSliderWidget(),
                const CustomHeightSpacer(
                  size: 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringManager.homeCaption,
                      textAlign: TextAlign.start,
                      style: SafeGoogleFont(
                        StringManager.mulish,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                        color: const Color(0xff1a434e),
                      ),
                    ),
                    // RoundIconButtonWidget(
                    //   iconName: Assets.icons.icSetting5.path,
                    //   iconColor: AppColors.primaryColor,
                    //   iconWidth: 20,
                    //   iconHeight: 20,
                    //   borderColor: AppColors.borderColor,
                    //   onTap: () {},
                    // ),
                    LottieBuilder.asset(
                      'assets/lottie/2023_1.json',
                      width: 70,
                    ),
                  ],
                ),
                const CustomHeightSpacer(
                  size: 0.02,
                ),
                HorizontalCategoryList(
                  items: listCategoryNews,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: db.getNewsWithCategory(categoryStr),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<News> data = snapshot.data.docs
                          .map<News>((doc) => News.fromJson(doc.data()))
                          .toList();
                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.length > 5 ? 5 : data.length,
                            itemBuilder: (BuildContext context, int index) {
                              final currentIndex = (currentPage * 5) + index;
                              if (currentIndex + 1 > data.length) {
                                return const SizedBox();
                              }
                              final dateOnly = DateFormat('dd/MM/yyyy')
                                  .format(data[currentIndex].publishedDate!);
                              return CardViewWidget(
                                titleNews: data[currentIndex].titleNews,
                                publishedDate: dateOnly,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsPage(
                                        idPost: snapshot
                                            .data.docs[index].reference.id,
                                        title: data[currentIndex].titleNews,
                                        puslishedDate: dateOnly,
                                        description:
                                            data[currentIndex].description,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          if (currentPage == (data.length / 5.0).round()) ...[
                            const SizedBox(
                              height: 50,
                            )
                          ],
                          if (data.isNotEmpty)
                            NumberPaginator(
                              config: const NumberPaginatorUIConfig(
                                  mode: ContentDisplayMode.numbers, height: 40),
                              initialPage: currentPage,
                              numberPages: (data.length / 5.0) >
                                      (data.length / 5.0).round()
                                  ? (((data.length / 5.0) + 1.0).round())
                                  : (data.length / 5.0).round(),
                              onPageChange: (int index) {
                                setState(() {
                                  currentPage = index;
                                });
                              },
                            )
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
        ),
      ),
    );
  }
}
