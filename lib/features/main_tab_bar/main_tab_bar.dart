import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/gen/assets.gen.dart';
import '../../common/colors/app_color.dart';
import '../../common/constants/constant.dart';
import '../../models/firebaseuser.dart';
import '../../services/database_service.dart';
import '../admin/add_extracurricular/add_extracurricular_page.dart';
import '../home/home_page.dart';
import '../news_collection/news_collection_page.dart';
import '../page/page.dart';
import '../score/score_page.dart';
import 'widgets/bottom_icon_widget.dart';

class MainTabBar extends StatefulWidget {
  const MainTabBar({Key? key}) : super(key: key);

  @override
  State<MainTabBar> createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> {
  int pageIndex = 0;
  DatabaseService db = DatabaseService();

  final pages = [
    const HomePage(),
    const ScorePage(),
    const NewsCollectionPage(),
    const AddExtracurricularPage(),
    SamplePage(
      title: StringManager.titleInformationPage,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);

    return Scaffold(
      body: Center(
        child: pages[pageIndex],
      ),
      bottomNavigationBar: Material(
        color: AppColors.transparent,
        elevation: 10,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomIconWidget(
                isSelect: pageIndex == 0,
                title: StringManager.titleNewsPage,
                iconName: pageIndex == 0
                    ? Assets.icons.icSelectedHome.path
                    : Assets.icons.icUnselectedHome.path,
                iconColor: pageIndex == 0
                    ? Theme.of(context).primaryColor
                    : AppColors.gray,
                tap: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
              ),
              if (user != null) ...[
                StreamBuilder<DocumentSnapshot>(
                  stream: db.getInformation(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      var DocData = snapshot.data;

                      return Row(
                        children: [
                          if (DocData['role'].contains('user')) ...[
                            BottomIconWidget(
                              isSelect: pageIndex == 1,
                              title: StringManager.titleScorePage,
                              iconName: pageIndex == 1
                                  ? Assets.icons.icSelectedSearchNormal.path
                                  : Assets.icons.icUnselectedSearchNormal.path,
                              iconColor: pageIndex == 1
                                  ? Theme.of(context).primaryColor
                                  : AppColors.gray,
                              tap: () {
                                setState(() {
                                  pageIndex = 1;
                                });
                              },
                            ),
                            BottomIconWidget(
                              isSelect: pageIndex == 2,
                              title: StringManager.titleSaveButton,
                              iconName: pageIndex == 2
                                  ? Assets.icons.icSelectedArchive.path
                                  : Assets.icons.icUnselectedArchive.path,
                              iconColor: pageIndex == 2
                                  ? Theme.of(context).primaryColor
                                  : AppColors.gray,
                              tap: () {
                                setState(() {
                                  pageIndex = 2;
                                });
                              },
                            ),
                          ],
                          if (DocData['role'].contains('admin')) ...[
                            BottomIconWidget(
                              isSelect: pageIndex == 3,
                              title: StringManager.titleSavePage,
                              iconName: pageIndex == 3
                                  ? Assets.icons.icSelectedArchive.path
                                  : Assets.icons.icUnselectedArchive.path,
                              iconColor: pageIndex == 3
                                  ? Theme.of(context).primaryColor
                                  : AppColors.gray,
                              tap: () {
                                setState(() {
                                  pageIndex = 3;
                                });
                              },
                            ),
                          ]
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )
              ],
              BottomIconWidget(
                isSelect: pageIndex == 4,
                title:
                    user != null ? StringManager.logout : StringManager.login,
                iconName: pageIndex == 4
                    ? Assets.icons.icSelectedUser.path
                    : Assets.icons.icUnselectedUser.path,
                iconColor: pageIndex == 4
                    ? Theme.of(context).primaryColor
                    : AppColors.gray,
                tap: () {
                  setState(() {
                    pageIndex = 4;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
