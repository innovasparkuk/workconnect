import 'package:flutter/material.dart';
import '../utils/constants.dart';

class Activity {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color color;

  Activity({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.color,
  });
}