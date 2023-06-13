import 'package:flutter/material.dart';

import '../../../common/constants/constant.dart';
import '../../utils/utils.dart';
import 'clock_widget.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning',
              style: SafeGoogleFont(
                StringManager.mulish,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.4,
                color: const Color(0xff94a5aa),
              ),
            ),
            Text(
              StringManager.appName,
              textAlign: TextAlign.center,
              style: SafeGoogleFont(
                StringManager.mulish,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 1.3,
                color: const Color(0xff1a434e),
              ),
            )
          ],
        ),
        const ClockWidget(),
      ],
    );
  }
}
