import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;
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
  // var response = http.Client().get(
  //   Uri.parse(
  //     'http://due.udn.vn/vi-vn/thongbao/thongbaochitiet/id/16934/bid/456',
  //   ),
  // );

  String htmlData = '';
  String filteredHtmlCode = '';
  List<String> dataBody = [];
  List<String> dataTitle = [];
  List<String> time = [];

  @override
  void initState() {
    super.initState();
    // _filterTitleHtmlData();
    // _filterTimeHtmlData();
    _filterBodyHtmlData();
  }

  Future<void> _filterBodyHtmlData() async {
    final response = await http.get(Uri.parse(widget.description));
    var document = html_parser.parse(response.body);
    setState(() {
      dataBody = document
          .getElementsByClassName('wd-content-detail')
          .map((e) => e.innerHtml)
          .toList();
    });
  }

  Future<void> _filterTimeHtmlData() async {
    final response = await http.get(Uri.parse(
        'http://due.udn.vn/vi-vn/thongbao/thongbaochitiet/id/16933/bid/456'));
    var document = html_parser.parse(response.body);
    setState(() {
      time = document
          .getElementsByClassName('wd-date')
          .map((e) => e.innerHtml)
          .toList();
    });
  }

  Future<void> _filterTitleHtmlData() async {
    final response = await http.get(Uri.parse(
        'http://due.udn.vn/vi-vn/thongbao/thongbaochitiet/id/16933/bid/456'));
    var document = html_parser.parse(response.body);
    setState(() {
      dataTitle =
          document.getElementsByTagName('h2').map((e) => e.innerHtml).toList();
    });
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
              height: 500,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return HtmlWidget(
                    onLoadingBuilder: (context, element, loadingProgress) =>
                        const CircularProgressIndicator(),
                    customWidgetBuilder: (element) {
                      if (element.localName == 'h2') {
                        return const SizedBox.shrink();
                      }
                      if (element.localName == 'div' &&
                          element.classes.contains('wd-date')) {
                        return const SizedBox();
                      }
                      return null;
                    },
                    dataBody[index],
                    onTapUrl: (p0) async {
                      if (await canLaunchUrl(Uri.parse(p0))) {
                        return launchUrl(
                          Uri.parse(p0),
                        );
                      } else {
                        throw 'Link cannot be handled';
                      }
                    },
                  );
                },
                itemCount: dataBody.length,
              ),
            ),

            // HtmlWidget(
            //   htmlData,
            //   onTapUrl: (p0) async {
            //     if (await canLaunchUrl(Uri.parse(p0))) {
            //       return launchUrl(
            //         Uri.parse(p0),
            //       );
            //     } else {
            //       throw 'Link cannot be handled';
            //     }
            //   },
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
            //   child: Text(
            //     'An exhibition exploring 350 years of relations between the Japanese and British royal families has opened at the Queen’s Gallery near Buckingham Palace, the London home of the British monarchy.',
            //     style: SafeGoogleFont(
            //      StringManager.mulish,
            //       fontSize: 14,
            //       fontWeight: FontWeight.w400,
            //       height: 1.8,
            //       color: Color(0xff95a6aa),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 24.0),
            //   child: Text(
            //     'UK-Japan royal relationship',
            //     style: SafeGoogleFont(
            //      StringManager.mulish,
            //       fontSize: 16,
            //       fontWeight: FontWeight.w700,
            //       height: 1.3,
            //       color: Color(0xff1a434e),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
            //   child: Text(
            //     'The exhibition features some 150 items from the royal family’s permanent collection, many of which were gifted to British royals by Japanese emperors and shoguns and are on public display for the first time.\n\nCurator Rachel Peat said the “stunning” works have “profoundly shaped British taste and helped forge a lasting relationship between the two nations.”',
            //     style: SafeGoogleFont(
            //      StringManager.mulish,
            //       fontSize: 14,
            //       fontWeight: FontWeight.w400,
            //       height: 1.8,
            //       color: Color(0xff95a6aa),
            //     ),
            //   ),
            // ),
            // // Center(
            // //   child: WebView(
            // //     initialUrl: 'https://www.tutorialkart.com/',
            // //     javascriptMode: JavascriptMode.unrestricted,
            // //     onWebViewCreated: (WebViewController webViewController) {
            // //       _controller = webViewController;
            // //     },
            // //   ),
            // // ),
          ],
        ),
      ),
    );
  }
}
