import 'package:flutter/material.dart';

class Job {
  final String id;
  final String title;
  final String clientName;
  final double budget;
  final String status;
  final String description;
  final String category;
  final DateTime postedDate;
  final DateTime deadline;
  final String location;
  final List<String> requiredSkills;
  final String type;
  final String clientImage;
  final String clientRating;
  final int duration;

  Job({
    required this.id,
    required this.title,
    required this.clientName,
    required this.budget,
    required this.status,
    required this.description,
    required this.category,
    required this.postedDate,
    required this.deadline,
    required this.location,
    required this.requiredSkills,
    required this.type,
    required this.clientImage,
    required this.clientRating,
    required this.duration,
  });

  // Status color getter
  Color get statusColor {
    switch (status.toLowerCase()) {
      case "in progress":
        return const Color(0xFFFFA000); // Amber
      case "pending":
        return const Color(0xFF2196F3); // Blue
      case "completed":
        return const Color(0xFF4CAF50); // Green
      case "rejected":
        return const Color(0xFFF44336); // Red
      case "pending review":
        return const Color(0xFF9C27B0); // Purple
      default:
        return const Color(0xFF757575); // Grey
    }
  }

  // Format budget as string
  String get formattedBudget => "\$$budget";

  // Format deadline as string
  String get formattedDeadline {
    final now = DateTime.now();
    final difference = deadline.difference(now);

    if (difference.inDays > 0) {
      return '${difference.inDays} days';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours';
    } else {
      return 'Due soon';
    }
  }

  // Format duration as string
  String get formattedDuration => '$duration days';
}