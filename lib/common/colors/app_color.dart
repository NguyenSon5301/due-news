import 'package:flutter/material.dart';

class AppColors {
  static const white = Color(0xffffffff);
  static const whiteLight = Color(0xFFFAFAFA);

  static const blueLight = Color(0xff4EA0F6);
  static const blueLight_2 = Color(0xFFE3F2FD);

  static const blue = Color(0xff407ACE);
  static const black = Color(0xff242424);
  static const gray = Color(0xff828282);
  static const lightGray = Color(0xffBCBCBC);
  static const green = Color(0xff91BA3E);
  static const red = Color(0xffCD2027);
  static const lightPurple = Color(0xFFF1E6FF);
  static const purple = Color(0xFF6F35A5);
  static const darkPurple = Color(0xFF572DFF);
  static Color backGroundColor = const Color(0xffffffff);

  static Color primaryColor = const Color(0xff1a434e);
  static Color redColor = const Color(0xfffc1111);
  static Color activeGray = const Color(0xff77838F);
  static Color lightBack = const Color(0xfff8f7f8);

  static Color borderColor = const Color(0xffF1F1F1);

  static const warning = Color(0xffed6c02);
  static const info = Color(0xff0288d1);
  static const neutral = Color(0xff232735);
  static const transparent = Color(0x00000000);

  static const hintTextField = Color(0xffBCBCBC);

  static const grey = _CustomSwatch(0xff333333, {
    85: Color(0xff4F4F4F),
    70: Color(0xff828282),
    55: Color(0xffBDBDBD),
    40: Color(0xffE0E0E0),
    25: Color(0xffECEDEE),
    10: Color(0xffF2F2F2),
  });

  static const blueGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.blueLight,
      AppColors.blue,
    ],
    stops: [.2396, 1],
  );

  static const purpleGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xff721c80), Color(0xff551560)],
    stops: [.2396, 1],
  );

  static const MaterialColor blueMaterialColor = MaterialColor(
    0xff407ACE,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: blue,
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );
}

class _CustomSwatch extends ColorSwatch<int> {
  const _CustomSwatch(int primary, Map<int, Color> sw) : super(primary, sw);

  Color get scale2 => this[85]!;
  Color get scale3 => this[70]!;
  Color get scale4 => this[55]!;
  Color get scale5 => this[40]!;
  Color get scale6 => this[25]!;
  Color get scale7 => this[10]!;
}
