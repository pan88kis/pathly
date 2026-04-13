import 'package:flutter/material.dart';
import '../models/trace_model.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  static const routeName = '/record';

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  late List<TracePoint> _points;
  bool _isRecording = false;
  bool _isCountingDown = false;
  int _countdown = 3;
  String _traceName = '';

  @override
  void initState() {
    super.initState();
    _points = [];
  }

  /// Start 3-second countdown
  void _startCountdown() {
    setState(() {
      _isCountingDown = true;
      _countdown = 3;
    });

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      setState(() => _countdown--);
      return _countdown > 0;
    }).then((_) {
      if (mounted) {
        setState(() {
          _isCountingDown = false;
          _isRecording = true;
          _points.clear();
        });
      }
    });
  }

  /// Handle touch movement
  void _onPointerMove(PointerMoveEvent event) {
    if (!_isRecording) return;

    setState(() {
      final renderBox = context.findRenderObject() as RenderBox;
      final position = renderBox.globalToLocal(event.position);
      _points.add(TracePoint(
        x: position.dx,
        y: position.dy,
        timestamp: DateTime.now(),
      ));
    });
  }

  /// Handle touch up (end of stroke or pause)
  void _onPointerUp(PointerUpEvent event) {
    // Optional: Could add stroke separation here if needed
  }

  /// Stop and save the trace
  void _stopAndSave() {
    if (_points.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No trace to save!')),
      );
      return;
    }

    final traceName = _traceName.isEmpty
        ? 'Trace ${DateTime.now().toIso8601String()}'
        : _traceName;

    final trace = TraceModel(
      name: traceName,
      createdAt: DateTime.now(),
      points: _points,
    );

    // TODO: Save to Hive/database
    final json = trace.toJson();
    print('Saved trace: $json');

    setState(() {
      _isRecording = false;
      _points.clear();
      _traceName = '';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Trace saved: $traceName (${_points.length} points)'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record')),
      body: Column(
        children: [
          // Trace name input
          if (!_isRecording && !_isCountingDown)
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                onChanged: (value) => _traceName = value,
                decoration: InputDecoration(
                  hintText: 'Trace name (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

          // Countdown display
          if (_isCountingDown)
            Expanded(
              child: Center(
                child: Text(
                  _countdown.toString(),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),

          // Drawing canvas
          if (_isRecording)
            Expanded(
              child: Listener(
                onPointerMove: _onPointerMove,
                onPointerUp: _onPointerUp,
                child: CustomPaint(
                  painter: TracePainter(_points),
                  child: Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey, width: 2),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

          // Points counter
          if (_isRecording)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Points: ${_points.length}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (!_isRecording && !_isCountingDown)
                  ElevatedButton.icon(
                    onPressed: _startCountdown,
                    icon: const Icon(Icons.circle),
                    label: const Text('Start Recording'),
                  ),
                if (_isRecording)
                  ElevatedButton.icon(
                    onPressed: _stopAndSave,
                    icon: const Icon(Icons.save),
                    label: const Text('Stop & Save'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for drawing the trace
class TracePainter extends CustomPainter {
  final List<TracePoint> points;

  TracePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    if (points.isEmpty) return;

    // Draw lines between consecutive points
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(
        Offset(points[i].x, points[i].y),
        Offset(points[i + 1].x, points[i + 1].y),
        paint,
      );
    }

    // Draw points as small circles
    final pointPaint = Paint()
      ..color = Colors.teal.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    for (final point in points) {
      canvas.drawCircle(
        Offset(point.x, point.y),
        2,
        pointPaint,
      );
    }
  }

  @override
  bool shouldRepaint(TracePainter oldDelegate) =>
      oldDelegate.points.length != points.length;
}
