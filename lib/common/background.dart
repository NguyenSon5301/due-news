import 'package:flutter/material.dart';

import 'colors/app_color.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.backGroundColor,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/logo_due.jpg'),
                    fit: BoxFit.none,
                    scale: 1.2,
                    alignment: Alignment.center,
                    opacity: 0.1,
                  ),
                ),
                child: child,
              ),
            )
          ],
        ),
      ),
    );
  }
}
