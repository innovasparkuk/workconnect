import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PerformanceChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.lightGreen.withOpacity(0.1), AppColors.accentBlue.withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Simplified chart representation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildChartBar(80, AppColors.primaryGreen, "Jan"),
              _buildChartBar(60, AppColors.primaryGreen, "Feb"),
              _buildChartBar(90, AppColors.primaryGreen, "Mar"),
              _buildChartBar(75, AppColors.primaryGreen, "Apr"),
              _buildChartBar(95, AppColors.primaryGreen, "May"),
              _buildChartBar(85, AppColors.primaryGreen, "Jun"),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegend(AppColors.primaryGreen, "Revenue"),
              _buildLegend(AppColors.primaryBlue, "Jobs"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartBar(double height, Color color, String label) {
    return Column(
      children: [
        Container(
          width: 20,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withOpacity(0.7)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: AppColors.textGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildLegend(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textGrey,
          ),
        ),
      ],
    );
  }
}