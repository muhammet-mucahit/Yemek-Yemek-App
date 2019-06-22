import 'package:flutter/material.dart';

class Colors {
  const Colors();

  static const Color appColor = const Color(0xFF2196F3);

  static const Color appBarTitle = const Color(0xFFFFFFFF);
  static const Color appBarIconColor = const Color(0xFFFFFFFF);
  static const Color appBarDetailBackground = const Color(0x00FFFFFF);
  static const Color appBarGradientStart = const Color(0xFF3383FC);
  static const Color appBarGradientEnd = const Color(0xFF00C6FF);

  static const Color foodCard = const Color(0xFF263238);
  static const Color foodPageBackground = const Color(0xFF546E7A);
  static const Color foodTitle = const Color(0xFFFFFFFF);
  static const Color foodLocation = const Color(0x66FFFFFF);
  static const Color foodDistance = const Color(0x66FFFFFF);

  static const Color loginGradientStart = const Color(0xFF607D8B);
  static const Color loginGradientEnd = const Color(0xFF263238);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class Dimens {
  const Dimens();

  static const foodWidth = 85.0;
  static const foodHeight = 85.0;

  static const foodWidthDetail = 130.0;
  static const foodHeightDetail = 130.0;
}

class TextStyles {
  const TextStyles();

  static const TextStyle appBarTitle = const TextStyle(
      color: Colors.appBarTitle,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 24.0);

  static const TextStyle foodTitle = const TextStyle(
      color: Colors.foodTitle,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 24.0);

  static const TextStyle foodLocation = const TextStyle(
      color: Colors.foodLocation,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 14.0);

  static const TextStyle foodDistance = const TextStyle(
      color: Colors.foodDistance,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      fontSize: 12.0);

  static const TextStyle foodTitleDetail = const TextStyle(
      color: Colors.foodTitle,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 36.0);

  static const TextStyle foodLocationDetail = const TextStyle(
      color: Colors.foodLocation,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 24.0);

  static const TextStyle foodDistanceDetail = const TextStyle(
      color: Colors.foodDistance,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      fontSize: 18.0);

  static const TextStyle snackBar = const TextStyle(
      color: Colors.foodTitle,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      fontSize: 22.0);
}
