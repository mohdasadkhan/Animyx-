import 'package:animyx/screens/screens.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Animated Builder'),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AnimatedBuilderL1())),
            ),
            ElevatedButton(
              child: const Text('Chained Explicit Animation'),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const ChainedExplicitAnimation())),
            ),
          ],
        ),
      ),
    );
  }
}
