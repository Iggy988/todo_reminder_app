// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color blueClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xffffff4667);
const Color darkGreyClr = Color(0xFF121212);
const Color white = Colors.white;
Color darkHeaderClr = Colors.grey.shade800;

const primaryClr = blueClr;

class Themes {
  static final light = ThemeData(
    backgroundColor: Colors.white,
    //useMaterial3: true,
    primaryColor: blueClr,

    // primarySwatch: MaterialColor(0xFF4e5ae8, <int, Color>{
    //   50: Color.fromARGB(255, 127, 135, 218),
    //   100: Color.fromARGB(255, 101, 110, 214),
    //   200:Color.fromARGB(255, 104, 114, 223),
    //   300:Color.fromARGB(255, 103, 114, 233),
    //   400:Color.fromARGB(255, 87, 98, 226),
    //   500:Color.fromARGB(255, 67, 81, 228),
    //   600:Color.fromARGB(255, 61, 74, 226),
    //   800:Color.fromARGB(255, 46, 62, 228),
    //   900:Color.fromARGB(255, 30, 46, 230),
    // }),
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    backgroundColor: Colors.black54,
    //useMaterial3: true,
    primaryColor: darkHeaderClr,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.grey[400] : Colors.grey),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white : Colors.black),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.white : Colors.black),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600]),
  );
}
