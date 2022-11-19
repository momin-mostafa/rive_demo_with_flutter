import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_demo/state_machine_demo.dart';

class TapAnimationScreen extends StatefulWidget {
  const TapAnimationScreen({
    super.key,
  });

  @override
  State<TapAnimationScreen> createState() => _TapAnimationScreenState();
}

class _TapAnimationScreenState extends State<TapAnimationScreen> {
  String riveFilePath = 'asset/star_animation.riv';
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
    color = Colors.white;
    controller = OneShotAnimation(
      'Scale',
      autoplay: false,
    );
    // rootBundle.load(riveFilePath).then((data) {
    //   final file = RiveFile.import(data);
    //   final artboard = file.mainArtboard;
    //   final stateMachineController =
    //       StateMachineController.fromArtboard(artboard, 'StarAnimation');
    //   if (stateMachineController != null) {
    //     artboard.addController(stateMachineController);
    //     _buttonInput = stateMachineController.findInput('Switch');
    //     // _trigger = stateMachineController.findInput<bool>('Tap') as SMITrigger;
    //     setState(
    //       () => _artboard = artboard,
    //     );
    //   }
    // });
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
              riveFilePath,
              controllers: [controller],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StateMachineDemoNumber(),
          ),
        ),
      ),
    );
  }
}
