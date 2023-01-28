import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  final Widget screen;
  const SplashScreen({Key? key, required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/weather.json'),
      nextScreen: screen,
      duration: 2000,
      animationDuration: const Duration(seconds: 1),
      backgroundColor: Colors.grey,

    );
  }
}