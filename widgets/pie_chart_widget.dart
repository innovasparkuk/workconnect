import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PieChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryGreen.withOpacity(0.1), AppColors.primaryBlue.withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Simplified pie chart representation
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    colors: [
                      AppColors.primaryGreen,
                      AppColors.primaryBlue,
                      AppColors.success,
                      AppColors.warning,
                      AppColors.error,
                    ],
                    stops: [0.0, 0.3, 0.6, 0.8, 1.0],
                  ),
                ),
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.cardWhite,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              _buildChartLegend(AppColors.primaryGreen, "Completed (45%)"),
              _buildChartLegend(AppColors.primaryBlue, "Active (25%)"),
              _buildChartLegend(AppColors.success, "Pending (15%)"),
              _buildChartLegend(AppColors.warning, "Review (10%)"),
              _buildChartLegend(AppColors.error, "Rejected (5%)"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartLegend(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: AppColors.textGrey,
          ),
        ),
      ],
    );
  }
}