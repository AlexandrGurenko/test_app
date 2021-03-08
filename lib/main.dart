import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/constants/palette.dart';
import 'package:test_app/pages/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: primaryColor));

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
        fontFamily: GoogleFonts.montserrat().fontFamily,
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        accentColor: accentColor,
      ),
      home: Home(),
    );
  }
}
