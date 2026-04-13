import 'package:flutter/material.dart';

class ReplayScreen extends StatelessWidget {
  const ReplayScreen({super.key});

  static const routeName = '/replay';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Replay')),
      body: const Center(
        child: Text('ReplayScreen scaffold'),
      ),
    );
  }
}
