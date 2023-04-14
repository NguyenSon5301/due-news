import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../common/common.dart';
import '../features/main_tab_bar/main_tab_bar.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    super.initState();
    _changePage();
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
