import 'package:animyx/screens/animation_builder_l1.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Animated Builder'),
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AnimatedBuilderL1())),
        ),
      ),
    );
  }
}
