import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late RiveAnimationController controller;
  Color color = Colors.grey;

  void _changeAnimation(RiveAnimationController controller) {
    if (controller.isActive == false) {
      controller.isActive = true;
      Future.delayed(const Duration(seconds: 1)).then((value) {
        setState(() {
          color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0);
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller = OneShotAnimation(
      'Scale',
      autoplay: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => _changeAnimation(controller),
          child: Container(
            color: color,
            child: RiveAnimation.asset(
              'asset/star_animation.riv',
              controllers: [controller],
            ),
          ),
        ),
      ),
    );
  }
}
