import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../features/details/details_page.dart';
import '../features/home/home_page.dart';
import '../features/main_tab_bar/main_tab_bar.dart';

class RouteServices {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/tabbar':
        return CupertinoPageRoute(
          builder: (_) {
            return const MainTabBar();
          },
        );
      case '/homepage':
        return CupertinoPageRoute(
          builder: (_) {
            return const HomePage();
          },
        );
      case '/news':
        if (args is Map) {
          Timestamp t = args['publishedDate'] ?? Timestamp.now();
          final d = t.toDate();
          final dateOnly = DateFormat('dd/MM/yyyy').format(d);
          return CupertinoPageRoute(
            builder: (_) {
              return DetailsPage(
                title: args['titleNews'] ?? '',
                puslishedDate: dateOnly,
                description: args['description'],
                idPost: args['idPost'] ?? '',
                checkShare: true,
              );
            },
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Không tìm thấy bài báo!!!'),
          ),
        );
      },
    );
  }
}
