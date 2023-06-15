import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../common/common.dart';
import '../features/details/details_page.dart';
import '../features/main_tab_bar/main_tab_bar.dart';
import '../services/database_service.dart';
import '../services/link_services.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  DatabaseService db = DatabaseService();
  late final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      requestPermission();
      getToken();
      initInfo();
    }
    getIdStudent();
    _changePage();
  }

  Future<void> requestPermission() async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('da accept');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('da chap nhan tam thoi');
    } else {
      print('da bo qua');
    }
  }

  Future<void> getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      UserInfoManager.ins.tokenDevice = token ?? '';
      DatabaseService().saveToken(token!);
    });
  }

  Future<void> getIdStudent() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await db.getIdStudent().then((value) async {
        UserInfoManager.ins.idStudent = value[0].idStudent;
      });
    }
  }

  Future<void> initInfo() async {
    final androidInitialize =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    final initializationSettings =
        InitializationSettings(android: androidInitialize);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        try {
          if (notificationResponse.payload != null &&
              notificationResponse.payload!.isNotEmpty) {
            await FirebaseFirestore.instance
                .collection('News')
                .doc(notificationResponse.payload)
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
                  LinkService.navigatorKey.currentContext!,
                  MaterialPageRoute(
                    builder: (_) => DetailsPage(
                      title: titleNews,
                      puslishedDate: dateOnly,
                      description: description,
                      idPost: notificationResponse.payload!,
                    ),
                  ),
                );
              }
            });
          } else {}
        } catch (e) {
          if (kDebugMode) {
            print('in ra loi o day $e');
          }
        }
        return;
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
      final bigTextStyleInformation = BigTextStyleInformation(
        remoteMessage.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: remoteMessage.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      final androidNotificationDetails = AndroidNotificationDetails(
        'due-news',
        'due-news',
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
      );
      final platformChannelSpecifics =
          NotificationDetails(android: androidNotificationDetails);
      await flutterLocalNotificationsPlugin.show(
        0,
        remoteMessage.notification?.title,
        remoteMessage.notification?.body,
        platformChannelSpecifics,
        payload: remoteMessage.data['idPost'],
      );
    });
  }

  void _changePage() {
    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainTabBar()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          child: SizedBox(
            width: width,
            height: height,
            child: Scaffold(
              backgroundColor: AppColors.transparent,
              body: Background(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: LottieBuilder.asset(
                            'assets/lottie/welcome_news.json',
                            width: 400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
