import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../common/common.dart';
import '../common/constants/dynamic_link_constant.dart';
import '../features/details/details_page.dart';

class LinkService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static LinkService ins = LinkService();
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  Future<void> initDynamicLinks() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      final queryParamsInit = deepLink.queryParameters;
      if (queryParamsInit.isNotEmpty) {
        final idPostInit = queryParamsInit['id'];
        await FirebaseFirestore.instance
            .collection('News')
            .doc(idPostInit)
            .get()
            .then((value) async {
          if (value.exists) {
            final dataInit = value.data();

            final titleNewsInit = dataInit!['titleNews'];
            final descriptionInit = dataInit['description'];
            final publishedDateInit = DateTime.fromMillisecondsSinceEpoch(
              dataInit['publishedDate'].millisecondsSinceEpoch,
            );
            final dateOnlyInit =
                DateFormat('dd/MM/yyyy').format(publishedDateInit);
            await Navigator.push(
              navigatorKey.currentContext!,
              MaterialPageRoute(
                builder: (_) => DetailsPage(
                  title: titleNewsInit,
                  puslishedDate: dateOnlyInit,
                  description: descriptionInit,
                  idPost: idPostInit!,
                ),
              ),
            );
          }
        });
      } else {
        _snackBar('Không tìm thấy bài viết!!!');
      }
    }
    dynamicLinks.onLink.listen((dynamicLinkData) async {
      final uri = dynamicLinkData.link;
      final queryParams = uri.queryParameters;
      if (queryParams.isNotEmpty) {
        final idPost = queryParams['id'];
        await FirebaseFirestore.instance
            .collection('News')
            .doc(idPost)
            .get()
            .then((value) async {
          if (value.exists) {
            final data = value.data();

            final titleNews = data!['titleNews'];
            final description = data['description'];
            final publishedDate = DateTime.fromMillisecondsSinceEpoch(
              data['publishedDate'].millisecondsSinceEpoch,
            );
            final dateOnly = DateFormat('dd/MM/yyyy').format(publishedDate);
            await Navigator.push(
              navigatorKey.currentContext!,
              MaterialPageRoute(
                builder: (_) => DetailsPage(
                  title: titleNews,
                  puslishedDate: dateOnly,
                  description: description,
                  idPost: idPost!,
                ),
              ),
            );
          }
        });
      } else {
        _snackBar('Không tìm thấy bài viết!!!');
      }
    }).onError((error) {
      _snackBar(error.message);
    });
  }

  Future<String> createDynamicLink({
    required String parameters,
    String? socialTitle,
    bool shortLink = true,
  }) async {
    final param = DynamicLinkParameters(
      uriPrefix: DynamicLinkConstant.kUriPrefix,
      link: Uri.parse('${DynamicLinkConstant.kUriPrefix}/$parameters'),
      androidParameters: const AndroidParameters(
        packageName: DynamicLinkConstant.androidPackageName,
      ),
      iosParameters: const IOSParameters(
        bundleId: DynamicLinkConstant.iOSBundleId,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: socialTitle,
      ),
    );

    late Uri url;
    if (shortLink) {
      final shortLink = await dynamicLinks.buildShortLink(param);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(param);
    }
    return url.toString();
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _snackBar(
    String title,
  ) {
    return ScaffoldMessenger.of(
      navigatorKey.currentContext!,
    ).showSnackBar(
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
