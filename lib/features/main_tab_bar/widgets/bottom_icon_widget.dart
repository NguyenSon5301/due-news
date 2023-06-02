import 'package:flutter/material.dart';

import '../../../common/colors/app_color.dart';

class BottomIconWidget extends StatelessWidget {
  const BottomIconWidget({
    required this.title,
    required this.iconName,
    required this.isSelect,
    this.iconColor,
    this.tap,
    Key? key,
  }) : super(key: key);
  final String title;
  final String iconName;
  final Color? iconColor;
  final bool isSelect;
  final Function()? tap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: tap,
        child: Container(
          padding: isSelect ? const EdgeInsets.symmetric(horizontal: 15) : null,
          decoration: isSelect
              ? const BoxDecoration(
                  color: AppColors.blueLight_2,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                )
              : null,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  iconName,
                  width: 24,
                  height: 24,
                  color: iconColor,
                ),
              ),
              if (isSelect) ...[
                Text(
                  title,
                  style: const TextStyle(color: AppColors.blueMaterialColor),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
