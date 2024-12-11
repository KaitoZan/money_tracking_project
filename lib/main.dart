
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_tracking_project/views/splash_screen_ui.dart';

void main() {
  runApp(const flutterChartGraphMap());
}

class flutterChartGraphMap extends StatefulWidget {
  const flutterChartGraphMap({super.key});

  @override
  State<flutterChartGraphMap> createState() => _flutterChartGraphMapState();
}

class _flutterChartGraphMapState extends State<flutterChartGraphMap> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUI(),
      theme: ThemeData(
        textTheme: GoogleFonts.kanitTextTheme(
          Theme.of(context).textTheme
        )
      ),
    );
  }
}