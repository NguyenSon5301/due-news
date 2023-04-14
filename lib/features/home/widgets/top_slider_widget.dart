import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TopSliderWidget extends StatelessWidget {
  const TopSliderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: CarouselSlider(
        items: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  'https://res.cloudinary.com/dbprtaixx/image/upload/v1678874285/tuyensinhquocte2023_eljtfv.jpg',
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  'https://res.cloudinary.com/dbprtaixx/image/upload/v1678874284/TS_2023_v3_n87z3y.png',
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  'https://res.cloudinary.com/dbprtaixx/image/upload/v1678874284/tuyensinhVLVH_kkxh8x.jpg',
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  'https://res.cloudinary.com/dbprtaixx/image/upload/v1678874284/thacsi_ylera9.jpg',
                ),
              ),
            ),
          ),
        ],
        options: CarouselOptions(
          height: 180,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 1,
        ),
      ),
    );
  }
}
