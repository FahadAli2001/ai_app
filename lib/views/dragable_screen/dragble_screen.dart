import 'dart:math';

import 'package:flutter/material.dart';

class DragableScreen extends StatefulWidget {
  const DragableScreen({super.key});

  @override
  State<DragableScreen> createState() => _DragableScreenState();
}

class _DragableScreenState extends State<DragableScreen> {

  double top =0.0,left=0.0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(children: [
        Positioned(
          top: top,
          left: left,
          child: GestureDetector(
            onPanUpdate: (details) {
              left = max(0, left+details.delta.dx);
              top = max(0, top+details.delta.dy);
              setState(() {
                
              });
            },
            child: Container(
              width: 100,
              height: 100,
              decoration:const BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle
              ),
            ),
          ),
        )
      ],),
    );
  }
}