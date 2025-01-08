import 'package:flutter/material.dart';
import 'package:scratcher/widgets.dart';

class ScratchCardScreen extends StatefulWidget {
  const ScratchCardScreen({super.key});

  @override
  State<ScratchCardScreen> createState() => _ScratchCardScreenState();
}

class _ScratchCardScreenState extends State<ScratchCardScreen>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? controller;
  final GlobalKey<ScratcherState> scratcherKey = GlobalKey<ScratcherState>();
  bool _isScratched = false;
  @override
  void initState() {
    super.initState();
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller!,
      curve: Curves.easeIn,
    );
    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isScratched) {
        scratcherKey.currentState?.reveal();
      }
    });
    return Scaffold(
        appBar: AppBar(title: Text("Scratch Card Demo")),
        body: Center(
          child: ScaleTransition(
            alignment: Alignment.center,
            scale: animation!,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Scratcher(
                  key: scratcherKey,
                  brushSize: 50,
                  threshold: 50,
                  color: Colors.blue,
                  onChange: (value) {
                    if (!_isScratched && value > 50) {
                      setState(() {
                        _isScratched = true;
                      });
                    }
                  },
                  onThreshold: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/myntra_scratch.png",
                          fit: BoxFit.cover,
                        ),
                        Column(
                          children: [
                            Text(
                              'Congratulations! \u{1F389}',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
