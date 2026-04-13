import 'package:flutter/material.dart';

class TracePoint {
  TracePoint({
    required this.x,
    required this.y,
    required this.timestamp,
  });

  final double x;
  final double y;
  final DateTime timestamp;

  /// Convert TracePoint to JSON
  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  /// Create TracePoint from JSON
  factory TracePoint.fromJson(Map<String, dynamic> json) {
    return TracePoint(
      x: json['x'] as double,
      y: json['y'] as double,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}

class TraceModel {
  TraceModel({
    required this.points,
    required this.name,
    required this.createdAt,
  });

  final List<TracePoint> points;
  final String name;
  final DateTime createdAt;

  /// Convert TraceModel to JSON for Hive storage
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'points': points.map((p) => p.toJson()).toList(),
    };
  }

  /// Create TraceModel from JSON
  factory TraceModel.fromJson(Map<String, dynamic> json) {
    return TraceModel(
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      points: (json['points'] as List<dynamic>)
          .map((p) => TracePoint.fromJson(p as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Create an empty trace
  factory TraceModel.empty() {
    return TraceModel(
      name: '',
      points: [],
      createdAt: DateTime.now(),
    );
  }

  /// Add a point to the trace
  void addPoint(double x, double y) {
    points.add(TracePoint(
      x: x,
      y: y,
      timestamp: DateTime.now(),
    ));
  }

  /// Get points as Offset list for drawing
  List<Offset> getOffsets() {
    return points.map((p) => Offset(p.x, p.y)).toList();
  }
}
