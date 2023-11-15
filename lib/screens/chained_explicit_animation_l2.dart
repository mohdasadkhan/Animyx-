import 'package:flutter/material.dart';
import 'dart:math' show pi;

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

class ChainedExplicitAnimation extends StatefulWidget {
  const ChainedExplicitAnimation({super.key});

  @override
  State<ChainedExplicitAnimation> createState() =>
      _ChainedExplicitAnimationState();
}

class _ChainedExplicitAnimationState extends State<ChainedExplicitAnimation>
    with TickerProviderStateMixin {
  late AnimationController counterClockwiseAnimationController;
  late Animation<double> counterClockwiseAnimation;

  late AnimationController flipController;
  late Animation<double> flipAnimation;

  @override
  void initState() {
    super.initState();
    counterClockwiseAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    counterClockwiseAnimation = Tween<double>(begin: 0, end: -(pi / 2)).animate(
      CurvedAnimation(
          parent: counterClockwiseAnimationController, curve: Curves.bounceOut),
    );

    //flip Animation
    flipController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    flipAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: flipController, curve: Curves.bounceOut),
    );

    // counterClockwiseAnimationController.repeat();
    // flipController.repeat();
    counterClockwiseAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // flipController.forward();
        flipAnimation = Tween<double>(
                begin: flipAnimation.value, end: flipAnimation.value + pi)
            .animate(
          CurvedAnimation(
            parent: flipController,
            curve: Curves.bounceOut,
          ),
        );
        flipController
          ..reset()
          ..forward();
      }
    });

    flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        counterClockwiseAnimation = Tween<double>(
                begin: counterClockwiseAnimationController.value,
                end: counterClockwiseAnimationController.value + -(pi / 2))
            .animate(
          CurvedAnimation(
            parent: counterClockwiseAnimationController,
            curve: Curves.bounceOut,
          ),
        );
        counterClockwiseAnimationController
          ..reset()
          ..forward();
      }
    });
  }

  @override
  void dispose() {
    counterClockwiseAnimationController.dispose();
    flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    counterClockwiseAnimationController
      ..reset()
      ..forward.delayed(
        const Duration(seconds: 1),
      );
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: counterClockwiseAnimationController,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(counterClockwiseAnimation.value),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                        animation: flipController,
                        builder: (context, child) {
                          return Transform(
                            alignment: Alignment.centerRight,
                            transform: Matrix4.identity()
                              ..rotateY(flipAnimation.value),
                            child: ClipPath(
                              clipper: HalfCircleClipper(
                                  circleSide: CircleSide.left),
                              child: Container(
                                color: const Color(
                                  0xff0057b7,
                                ),
                                width: 200,
                                height: 200,
                              ),
                            ),
                          );
                        }),
                    AnimatedBuilder(
                        animation: flipController,
                        builder: (context, child) {
                          return Transform(
                            alignment: Alignment.centerLeft,
                            transform: Matrix4.identity()
                              ..rotateY(flipAnimation.value),
                            child: ClipPath(
                              clipper: HalfCircleClipper(
                                  circleSide: CircleSide.right),
                              child: Container(
                                color: const Color(
                                  0xffffd700,
                                ),
                                width: 200,
                                height: 200,
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide circleSide;
  HalfCircleClipper({
    required this.circleSide,
  });

  @override
  Path getClip(Size size) => circleSide.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final Path path = Path();
    late Offset offset;
    late bool clockwise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;

      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }
    path.arcToPoint(
      offset,
      radius: Radius.elliptical(
        size.width / 2,
        size.height / 2,
      ),
      clockwise: clockwise,
    );
    path.close();
    return path;
  }
}
