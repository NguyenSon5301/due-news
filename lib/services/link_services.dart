import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import '../common/constants/dynamic_link_constant.dart';

class LinkService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static LinkService ins = LinkService();
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) async {
      final uri = dynamicLinkData.link;
      final queryParams = uri.queryParameters;
      if (queryParams.isNotEmpty) {
        final idPost = queryParams['id'];
        await FirebaseFirestore.instance
            .collection('users')
            .doc()
            .get()
            .then((value) async {
          if (value.exists) {
            final data = value.data();

            final titleNews = data!['titleNews'];
            final description = data['description'];
            final publishedDate = data['publishedDate'];
            await Navigator.pushNamed(
              navigatorKey.currentContext!,
              dynamicLinkData.link.path,
              arguments: {
                'idPost': idPost,
                'titleNews': titleNews,
                'description': description,
                'publishedDate': publishedDate
              },
            );
          }
        });
      } else {
        await Navigator.pushNamed(
          navigatorKey.currentContext!,
          dynamicLinkData.link.path,
        );
      }
    }).onError((error) {
      print('onLink error');
      print(error.message);
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
}
