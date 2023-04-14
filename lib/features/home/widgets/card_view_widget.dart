import 'package:flutter/material.dart';

import '../../../common/colors/app_color.dart';
import '../../utils/utils.dart';
import '../../widgets/spacer/spacer_custom.dart';

class CardViewWidget extends StatelessWidget {
  const CardViewWidget({
    required this.titleNews,
    required this.publishedDate,
    super.key,
    this.onTap,
  });

  final String titleNews;
  final String publishedDate;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xffbdbdbd),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      constraints: const BoxConstraints.expand(height: 35),
                      // margin: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        publishedDate.substring(
                          0,
                          5,
                        ),
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints.expand(height: 35),
                      alignment: Alignment.center,
                      color: AppColors.white,
                      child: Text(
                        publishedDate.substring(
                          6,
                          publishedDate.length,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const CustomWidthSpacer(
                size: 0.03,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      titleNews,
                      style: SafeGoogleFont(
                        'Mulish',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                        color: const Color(0xff1a434e),
                      ),
                    ),
                    const CustomHeightSpacer(
                      size: 0.005,
                    ),
                    RichText(
                      text: TextSpan(
                        style: SafeGoogleFont(
                          'Mulish',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                          color: const Color(0xff95a6aa),
                        ),
                        children: [
                          TextSpan(
                            text: publishedDate,
                            style: SafeGoogleFont(
                              'Mulish',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                              color: const Color(0xff1a434e),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
