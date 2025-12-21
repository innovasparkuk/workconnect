import 'package:flutter/material.dart';
import '../utils/constants.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;
  final double progress;

  const StatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75, // Width aur kam kiya
      height: 80, // Height aur kam kiya
      padding: EdgeInsets.all(5), // Padding aur kam kiya
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Icon(icon, color: color, size: 12), // Icon size aur chota
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 11, // Font size aur chota
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 8, // Font size aur chota
              color: AppColors.textGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            borderRadius: BorderRadius.circular(1),
            minHeight: 1, // Height aur chota
          ),
        ],
      ),
    );
  }
}