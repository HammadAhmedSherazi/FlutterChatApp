import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
   AnimationController? animationController;

   @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animationController?.forward();
    Timer(const Duration(seconds: 3), () {
      // Navigate to the next screen after the animation completes
      Navigator.of(context).pushNamedAndRemoveUntil('/LoginScreen', (route) => false);
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)
      ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            AnimatedBuilder(animation: animationController!, builder: (context, child) => Transform.scale(
              scale: animationController!.value,
              child: Image.asset('assets/appIcon.png', width: 180, height: 180,),
            ),)

        ],
      ));
  }
}