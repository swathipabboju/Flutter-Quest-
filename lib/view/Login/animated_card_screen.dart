import 'dart:math' as math;

import 'package:flutter/material.dart';

class CardFlipAnimation extends StatefulWidget {
  const CardFlipAnimation({super.key});

  @override
  createState() => _CardFlipAnimationState();
}

class _CardFlipAnimationState extends State<CardFlipAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;
  final String _gfgLogo =
      "https://media.geeksforgeeks.org/wp-content/uploads/20221210020032/gfglogo2-200.png";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_controller.status != AnimationStatus.forward) {
      if (_isFront) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      _isFront = !_isFront;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "GFG Flip Card Animation",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.language, color: Colors.white)),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              if (!_isFront) {
                _controller.reverse();
                _isFront = !_isFront;
              }
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: _flipCard,
        child: Center(
          child: SizedBox(
            width: 180,
            height: 180,
            child: Transform(
              transform: Matrix4.rotationY(_animation.value * math.pi),
              alignment: Alignment.center,
              child: _isFront ? _buildFront() : _buildBack(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFront() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        _gfgLogo,
        height: 180.0,
        width: 180.0,
      ),
    );
  }

  Widget _buildBack() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(3.14),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[700],
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            'GeeksforGeeks',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
