// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../common/colors/app_color.dart';

class RoundIconButtonWidget extends StatelessWidget {
  const RoundIconButtonWidget({
    required this.borderColor,
    required this.iconName,
    required this.iconColor,
    required this.iconWidth,
    required this.iconHeight,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final Color borderColor;
  final String iconName;

  final Color iconColor;
  final double iconWidth;
  final double iconHeight;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            iconName,
            width: iconWidth,
            height: iconHeight,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
