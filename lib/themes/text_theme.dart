import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle titleTextTheme = TextStyle(
  fontFamily: GoogleFonts.firaCode().fontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 18,
  letterSpacing: 2,
);

TextStyle bodyTextTheme = TextStyle(
  fontFamily: GoogleFonts.firaCode().fontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 16,
  letterSpacing: 2,
);

TextStyle drawerTextTheme = TextStyle(
  fontFamily: GoogleFonts.firaCode().fontFamily,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontSize: 16,
);

TextStyle loginTextTheme(BuildContext context) => TextStyle(
      fontFamily: GoogleFonts.firaCode().fontFamily,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
      fontSize: 24,
      color: Theme.of(context).colorScheme.primary,
    );

TextStyle textFieldTheme(context) => TextStyle(
      fontFamily: GoogleFonts.firaCode().fontFamily,
      fontWeight: FontWeight.normal,
      fontSize: 15,
      letterSpacing: 2,
      color: Theme.of(context).colorScheme.inversePrimary,
    );
