import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../features/home/screens/main_screen.dart';

class SetRiseApp extends StatelessWidget {
  const SetRiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
        fontFamily: 'Inter',
      ),
      home: const MainScreen(),
    );
  }
}
