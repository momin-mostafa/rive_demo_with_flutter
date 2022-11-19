import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class StateMachineDemoNumber extends StatefulWidget {
  const StateMachineDemoNumber({super.key});

  @override
  State<StateMachineDemoNumber> createState() => _StateMachineDemoNumberState();
}

class _StateMachineDemoNumberState extends State<StateMachineDemoNumber> {
  bool get isPlaying => _controller?.isActive ?? false;

  String riveFileName = 'asset/skill_slider.riv';

  Artboard? _riveArtBoard;
  StateMachineController? _controller;
  SMIInput<double>? input;

  @override
  void initState() {
    super.initState();
    rootBundle.load(riveFileName).then((value) {
      final file = RiveFile.import(value);
      final artboard = file.mainArtboard;
      var controller =
          StateMachineController.fromArtboard(artboard, "State Machine 1");
      if (controller != null) {
        artboard.addController(controller);
        input = controller.findInput('state');
      }

      setState(() => _riveArtBoard = artboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rive State Machine Demo'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 350,
              width: 350,
              color: Colors.red,
              child: animation(),
            ),
            const Text(
                "Tap to fill the container. Once filled. long press to reset"),
          ],
        ),
      ),
    );
  }

  animation() {
    return GestureDetector(
      onTap: () {
        if (input != null) {
          input!.value++;
        }
      },
      onLongPress: () {
        if (input != null) {
          input!.value = 0;
        }
      },
      child: Container(
        color: Colors.white,

        child: _riveArtBoard == null
            ? Container()
            : Rive(
                fit: BoxFit.fill,
                artboard: _riveArtBoard!,
              ),
        // child: Rive(artboard: artboard),
      ),
    );
  }
}
