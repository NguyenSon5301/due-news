// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../common/colors/app_color.dart';
import '../../../common/constants/constant.dart';
import '../../../common/singleton/category_news_singleton.dart';
import '../../utils/utils.dart';

class HorizontalCategoryList extends StatefulWidget {
  final List<String> items;

  const HorizontalCategoryList({required this.items, Key? key})
      : super(key: key);
  @override
  State<HorizontalCategoryList> createState() => _HorizontalCategoryListState();
}

class _HorizontalCategoryListState extends State<HorizontalCategoryList> {
  int currentItems = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (widget.items[index].contains('Tất cả')) {
                CategoryNews.ins.category$?.add(null);
                setState(() {
                  currentItems = index;
                });
                return;
              }
              CategoryNews.ins.category$?.add(widget.items[index]);
              setState(() {
                currentItems = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                right: 8,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: currentItems == index
                      ? AppColors.blue
                      : AppColors.transparent,
                  border: Border.all(color: const Color(0xfff1f1f1)),
                  borderRadius: BorderRadius.circular(72),
                ),
                child: Center(
                  child: Text(
                    widget.items[index],
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont(
                      StringManager.mulish,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                      color: currentItems == index
                          ? AppColors.white
                          : AppColors.black,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
