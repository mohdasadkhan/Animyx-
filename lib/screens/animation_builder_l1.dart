import 'package:flutter/material.dart';
import 'dart:math' show pi;

class AnimatedBuilderL1 extends StatefulWidget {
  const AnimatedBuilderL1({super.key});

  @override
  State<AnimatedBuilderL1> createState() => _AnimatedBuilderL1State();
}

class _AnimatedBuilderL1State extends State<AnimatedBuilderL1>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    animation =
        Tween<double>(begin: 0.0, end: 2 * pi).animate(animationController);
    //Tween >> BEtween
    //Tween is not an animation, An animation is an object that is linked
    //to an animation controller
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => Transform(
            // origin: const Offset(50, 50),
            alignment: Alignment.center,
            transform: Matrix4.identity()..rotateY(animation.value),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/*

AnimationController >> An object that allows you to control the changes 
to a double values which is usually between 0 and 1 with a given pace
and that pace is specified using a duration.
Let's say you have a value between 0 and 1 
start this animation and go from 0 to 1 at the pace of 3 seconds, when 3 seconds
is finished your value is 1, that's all animation controller does

0.0 * 360 = 0 degrees
0.5 * 360 = 180 degree
1.0 * 360 = 360 degree

Refresh Rate: It's usually called a vertical sync because screens usually 

Everything co-ordinate starts from top-left

*/
