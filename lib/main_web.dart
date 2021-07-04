import 'package:dart_mongo_lite/dart_mongo_lite.dart';
import 'package:flutter/material.dart';
import 'package:game_on/src/utils/globals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import './src/pages/cachier_page.dart';
import './src/pages/login_page.dart';
import './src/utils/colors.dart';

void main() {
  runApp(GameOnApp());
}

class GameOnApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GameOn',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: mainColor,
        primaryColorDark: lightColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: mainColor,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
          errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
          disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
          focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
          hintStyle: GoogleFonts.cairo(color: lightColor),
          labelStyle: GoogleFonts.cairo(color: lightColor),
          counterStyle: GoogleFonts.cairo(color: lightColor),
          errorStyle: GoogleFonts.cairo(color: lightColor),
          helperStyle: GoogleFonts.cairo(color: lightColor),
          prefixStyle: GoogleFonts.cairo(color: lightColor),
          suffixStyle: GoogleFonts.cairo(color: lightColor),
          isDense: false,
        ),
        textTheme: GoogleFonts.cairoTextTheme(TextTheme().apply(displayColor: lightColor, bodyColor: lightColor)),
        primaryTextTheme: GoogleFonts.cairoTextTheme(TextTheme().apply(displayColor: lightColor, bodyColor: lightColor)),
        accentTextTheme: GoogleFonts.cairoTextTheme(TextTheme().apply(displayColor: lightColor, bodyColor: lightColor)),
      ),
      themeMode: ThemeMode.dark,
      onInit: () async {
        database = Database('resources/db');
      },
      initialRoute: '/login',
      routes: {
        '/': (context) => CachierPage(),
        '/login': (context) => LoginPage(), 
      },
    );
  }
}