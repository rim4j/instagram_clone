import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final robotoBold = GoogleFonts.roboto(fontWeight: FontWeight.w700);
final robotoSemiBold = GoogleFonts.roboto(fontWeight: FontWeight.w600);

final robotoMedium = GoogleFonts.roboto(fontWeight: FontWeight.w500);

final robotoRegular = GoogleFonts.roboto(fontWeight: FontWeight.w400);

class AppFontSize {
  final Size size;

  AppFontSize({
    required this.size,
  });

  late final veryLargeFontSize = size.width / 100 * 4.5;
  late final largeFontSize = size.width / 100 * 4;
  late final mediumFontSize = size.width / 100 * 3.5;
  late final smallFontSize = size.width / 100 * 3;
  late final verySmallFontSize = size.width / 100 * 2.5;
}
