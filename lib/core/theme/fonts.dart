import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme fonts(BuildContext context) {
  return GoogleFonts.mPlusRounded1cTextTheme(
    Theme
        .of(context)
        .textTheme,
  );
}