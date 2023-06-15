import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/common.dart';
import 'models/firebaseuser.dart';
import 'services/auth_services.dart';
import 'services/link_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: kIsWeb ? null : 'due-news',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCkUoLoTJLKBATOri-o20FH0dUgZXZ_Z9k',
      authDomain: 'due-news.firebaseapp.com',
      databaseURL: 'https://due-news-default-rtdb.firebaseio.com',
      projectId: 'due-news',
      storageBucket: 'due-news.appspot.com',
      messagingSenderId: '592498965538',
      appId: '1:592498965538:web:63b153b73167c5d1b95e7b',
      measurementId: 'G-V9R6FL3702',
    ),
  );
  await FirebaseMessaging.instance.getInitialMessage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DUE News',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashWidget(),
        navigatorKey: LinkService.navigatorKey,
      ),
    );
  }
}
