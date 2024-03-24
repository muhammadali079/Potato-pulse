import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:disease/custom_widgets/custom_splash.dart';
import 'package:disease/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash:const CustomSplash() , nextScreen: const MyHomePage(), splashIconSize: 500,duration: 1000,);
  }
}