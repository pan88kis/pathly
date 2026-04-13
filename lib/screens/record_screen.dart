import 'package:flutter/material.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  static const routeName = '/record';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record')),
      body: const Center(
        child: Text('RecordScreen scaffold'),
      ),
    );
  }
}
