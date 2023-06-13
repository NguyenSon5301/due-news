import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/common.dart';
import 'widgets/details_header_widget.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    required this.title,
    required this.puslishedDate,
    required this.description,
    required this.idPost,
    this.checkShare = false,
    Key? key,
  }) : super(key: key);
  final String title;
  final String puslishedDate;
  final String description;
  final String idPost;
  final bool checkShare;
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailsHeaderWidget(
              title: widget.title,
              time: widget.puslishedDate,
              idPost: widget.idPost,
              checkShare: widget.checkShare,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: HtmlWidget(
                onLoadingBuilder: (context, element, loadingProgress) =>
                    const CircularProgressIndicator(),
                widget.description,
                onTapUrl: (p0) async {
                  if (await canLaunchUrl(Uri.parse(p0))) {
                    return launchUrl(
                      Uri.parse(p0),
                    );
                  } else {
                    throw 'Không tải được bài báo!!!';
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


  // Future<void> _filterBodyHtmlData() async {
  //   final response = await http.get(Uri.parse(widget.description));
  //   final document = html_parser.parse(response.body);
  //   setState(() {
  //     dataBody = document
  //         .getElementsByClassName('wd-content-detail')
  //         .map((e) => e.innerHtml)
  //         .toList();
  //   });
  // }

  // Future<void> _filterTimeHtmlData() async {
  //   final response = await http.get(Uri.parse(
  //       'http://due.udn.vn/vi-vn/thongbao/thongbaochitiet/id/16933/bid/456',),);
  //   final document = html_parser.parse(response.body);
  //   setState(() {
  //     time = document
  //         .getElementsByClassName('wd-date')
  //         .map((e) => e.innerHtml)
  //         .toList();
  //   });
  // }

  // Future<void> _filterTitleHtmlData() async {
  //   final response = await http.get(Uri.parse(
  //       'http://due.udn.vn/vi-vn/thongbao/thongbaochitiet/id/16933/bid/456',),);
  //   final document = html_parser.parse(response.body);
  //   setState(() {
  //     dataTitle =
  //         document.getElementsByTagName('h2').map((e) => e.innerHtml).toList();
  //   });
  // }
