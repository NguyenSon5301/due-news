import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common/common.dart';
import '../../../common/constants/constant.dart';
import '../../../common/gen/assets.gen.dart';
import '../../../models/firebaseuser.dart';
import '../../../services/database_service.dart';
import '../../../services/link_services.dart';
import '../../home/widgets/round_icon_button_widget.dart';
import '../../utils/utils.dart';
import '../../widgets/spacer/spacer_custom.dart';

class DetailsHeaderWidget extends StatefulWidget {
  const DetailsHeaderWidget({
    required this.title,
    required this.time,
    required this.idPost,
    this.checkShare = false,
    super.key,
  });
  final String title;
  final String time;
  final String idPost;
  final bool checkShare;
  @override
  State<DetailsHeaderWidget> createState() => _DetailsHeaderWidgetState();
}

class _DetailsHeaderWidgetState extends State<DetailsHeaderWidget> {
  DatabaseService db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xffbdbdbd),
        image: DecorationImage(
          opacity: 0.5,
          fit: BoxFit.cover,
          image: AssetImage('assets/images/rectangle-6537-bg.png'),
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 45, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundIconButtonWidget(
                  iconName: Assets.icons.icBack.path,
                  iconColor: AppColors.backGroundColor,
                  iconWidth: 20,
                  iconHeight: 20,
                  borderColor: AppColors.borderColor,
                  onTap: () {
                    Navigator.pop<bool>(context, false);
                    if (widget.checkShare) {
                      Navigator.pop<bool>(context, false);
                    }
                  },
                ),
                RoundIconButtonWidget(
                  iconName: Assets.icons.icSelectedSearchNormal.path,
                  iconColor: AppColors.backGroundColor,
                  iconWidth: 20,
                  iconHeight: 20,
                  borderColor: AppColors.borderColor,
                  onTap: () async {
                    await LinkService.ins
                        .createDynamicLink(
                          parameters:
                              '${DynamicLinkConstant.shareNews}?id=${widget.idPost}',
                          socialTitle: widget.title,
                        )
                        .then(Share.share);
                  },
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: SafeGoogleFont(
                            StringManager.mulish,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          widget.time,
                          style: SafeGoogleFont(
                            StringManager.mulish,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                            color: AppColors.lightGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (user != null)
                    StreamBuilder<DocumentSnapshot>(
                        stream: db.getInformation(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            final DocData = snapshot.data;
                            final documentReference = FirebaseFirestore.instance
                                .collection('User')
                                .doc(
                                  FirebaseAuth.instance.currentUser!.email
                                      .toString(),
                                );

                            final newsList = <String>[
                              ...DocData['newsCollection']
                            ];
                            var index = -1;
                            final news = widget.idPost;
                            for (var i = 0; i < newsList.length; i++) {
                              if (newsList[i] == news) {
                                index = i;
                              }
                            }
                            return RoundIconButtonWidget(
                              iconName: index == -1
                                  ? Assets.icons.icArchiveAdd.path
                                  : Assets.icons.icSelectedArchive.path,
                              iconColor: AppColors.backGroundColor,
                              iconWidth: 20,
                              iconHeight: 20,
                              borderColor: AppColors.borderColor,
                              onTap: () async {
                                if (index > -1) {
                                  newsList.removeAt(index);
                                } else {
                                  newsList.add(news);
                                }
                                final add = <String, dynamic>{
                                  'newsCollection': newsList,
                                };
                                await documentReference
                                    .update(add)
                                    .then((value) {
                                  if (index > -1) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text(StringManager.removeSaveNews),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(StringManager.saveNews),
                                      ),
                                    );
                                  }
                                });
                              },
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
