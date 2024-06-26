import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internship_fair/constants/constants.dart';
import 'package:internship_fair/view/job_profile.dart';
import 'package:internship_fair/view/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget getInitialRoute() {
    if (GetStorage().read('token') == null) {
      return const LoginScreen();
    }
    return const JobProfile();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/images/acm_logo.png',
      splashIconSize: 500,
      backgroundColor: whiteColor,
      nextScreen: getInitialRoute(),
      duration: 2000,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
