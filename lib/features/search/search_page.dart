import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../../models/data.dart';
import '../details/details_page.dart';
import '../home/widgets/card_view_widget.dart';
import '../utils/utils.dart';
import '../widgets/spacer/spacer_custom.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/search_header_widget.dart';
import 'widgets/trending_topic_widget.dart';

class SearchPage extends StatefulWidget {
  SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 45, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchHeaderWidget(),
                const CustomHeightSpacer(
                  size: 0.04,
                ),
                const SearchBarWidget(),
                const CustomHeightSpacer(
                  size: 0.04,
                ),
                Text(
                  'Trending topic today',
                  style: SafeGoogleFont(
                    'Mulish',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    color: const Color(0xff1a434e),
                  ),
                ),
                const CustomHeightSpacer(
                  size: 0.03,
                ),
                const TrendingTopicWidget(
                  name: 'Politics',
                ),
                const CustomHeightSpacer(
                  size: 0.02,
                ),
                const TrendingTopicWidget(
                  name: 'Politics',
                ),
                const CustomHeightSpacer(
                  size: 0.02,
                ),
                const TrendingTopicWidget(
                  name: 'Investment',
                ),
                const CustomHeightSpacer(
                  size: 0.02,
                ),
                const TrendingTopicWidget(
                  name: 'Business',
                ),
                const CustomHeightSpacer(
                  size: 0.04,
                ),
                Text(
                  'Trending topic today',
                  style: SafeGoogleFont(
                    'Mulish',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    color: const Color(0xff1a434e),
                  ),
                ),
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemCount: myDataList.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     return CardViewWidget(
                //       image: myDataList[index].image,
                //       name: myDataList[index].name,
                //       author: myDataList[index].author,
                //       onTap: () {
                //         // Get.to(DetailsPage());
                //       },
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
