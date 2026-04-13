import 'package:flutter/material.dart';

import 'models/trace_model.dart';
import 'screens/record_screen.dart';
import 'screens/replay_screen.dart';
import 'widgets/drawing_canvas.dart';

import 'package:permission_handler/permission_handler.dart';

Future<void> requestAllPermissions() async {
  await [
    Permission.storage,
    Permission.camera,
    Permission.manageExternalStorage,
  ].request();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestAllPermissions();
  runApp(const PathlyApp());
}

class PathlyApp extends StatelessWidget {
  const PathlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pathly',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      routes: {
        RecordScreen.routeName: (context) => const RecordScreen(),
        ReplayScreen.routeName: (context) => const ReplayScreen(),
      },
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pathly')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RecordScreen.routeName);
              },
              child: const Text('Record'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ReplayScreen.routeName);
              },
              child: const Text('Replay'),
            ),
            const SizedBox(height: 24),
            const _ScaffoldPreview(),
          ],
        ),
      ),
    );
  }
}

class _ScaffoldPreview extends StatelessWidget {
  const _ScaffoldPreview();

  @override
  Widget build(BuildContext context) {
    final trace = TraceModel.empty();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Generated scaffolds ready',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text('Trace points: ${trace.points.length}'),
        const SizedBox(height: 12),
        const SizedBox(
          height: 120,
          child: DrawingCanvas(),
        ),
      ],
    );
  }
}
