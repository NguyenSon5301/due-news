import 'package:flutter/material.dart';

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
                'Mulish',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.4,
                color: Color(0xff94a5aa),
              ),
            ),
            Text(
              'DUE News',
              textAlign: TextAlign.center,
              style: SafeGoogleFont(
                'Mulish',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 1.3,
                color: Color(0xff1a434e),
              ),
            )
          ],
        ),
        const ClockWidget(),
      ],
    );
  }
}
