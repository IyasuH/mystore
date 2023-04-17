// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:mystore/screens/homeScreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  void setState() {}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'myStore',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        // Material 3 makes to look so much great but
        // a lot of overrflows happend
        useMaterial3: true,
        // one thing for sure is that I have to readjust the color for light theme also
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: Icons.shopify_rounded,
        // ignore: prefer_const_constructors
        nextScreen: HomeScreen(),
        duration: 2700,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        // pageTransitionType: PageTransitionType.scale,
        backgroundColor: const Color.fromARGB(96, 24, 24, 24),
      ),
      // home: HomeScreen(),
    );
  }
}
