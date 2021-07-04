import 'package:dart_mongo_lite/dart_mongo_lite.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:game_on/src/pages/admin_page.dart';
import 'package:game_on/src/pages/stats_page.dart';
import 'package:game_on/src/utils/globals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import './src/pages/cachier_page.dart';
import './src/pages/login_page.dart';
import './src/utils/colors.dart';
import './src/widgets/custom_appbar.dart';

Future<void> main() async {
  runApp(GameOnApp());
  doWhenWindowReady(() {
    final initialSize = Size(1000, 750);
    appWindow.minSize = initialSize;
    appWindow.maxSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "GameOn";
    appWindow.show();
  });
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
      builder: (_, child) => WindowBorder(
        child: Scaffold(
          appBar: CustomAppBar(),
          body: child,
        ),
        color: mainColor,
      ),
      onInit: () async {
        database = Database('resources/db');
      },
      initialRoute: '/login',
      routes: {
        '/': (context) => CachierPage(),
        '/login': (context) => LoginPage(),
        '/stats': (context) => StatsPage (),
        '/admin': (context) => AdminPage(),
      },
    );
  }
}