import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/gradient_app_bar.dart';
import '../widgets/performance_chart.dart';
import '../widgets/pie_chart_widget.dart';

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final isTablet = screenWidth >= 600;
            final isDesktop = screenWidth >= 1024;
            final isSmallScreen = screenWidth < 400;

            return SingleChildScrollView(
              padding: EdgeInsets.all(
                isDesktop ? 24 : isTablet ? 20 : isSmallScreen ? 12 : 16,
              ),
              child: Column(
                children: [
                  // Performance Analytics Section
                  _buildPerformanceAnalytics(context),
                  SizedBox(height: isDesktop ? 24 : isTablet ? 20 : 16),

                  // Stats Overview
                  _buildStatsOverview(context),
                  SizedBox(height: isDesktop ? 24 : isTablet ? 20 : 16),

                  // Charts Section
                  _buildChartsSection(context),
                  SizedBox(height: isDesktop ? 24 : isTablet ? 20 : 16),

                  // Detailed Metrics
                  _buildDetailedMetrics(context),

                  // Extra bottom padding for better scrolling
                  SizedBox(height: isDesktop ? 24 : isTablet ? 20 : 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPerformanceAnalytics(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    final isDesktop = screenWidth >= 1024;
    final isSmallScreen = screenWidth < 400;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isDesktop ? 20 : isSmallScreen ? 12 : 16),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isDesktop ? 24 : isTablet ? 20 : isSmallScreen ? 16 : 20),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(isDesktop ? 20 : isSmallScreen ? 12 : 16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.analytics,
                    color: AppColors.primaryGreen,
                    size: isSmallScreen ? 18 : (isTablet ? 22 : 24),
                  ),
                ),
                SizedBox(width: isSmallScreen ? 8 : 12),
                Expanded(
                  child: Text(
                    "Performance Analytics",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : (isTablet ? 20 : 22),
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: isDesktop ? 20 : isTablet ? 18 : isSmallScreen ? 12 : 16),
            _buildAnalyticsGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    if (screenWidth < 500) {
      // Stack vertically on small screens
      return Column(
        children: [
          _buildAnalyticsItem("Overall Rating", "4.8/5", Icons.star, AppColors.warning, context),
          SizedBox(height: isSmallScreen ? 8 : 12),
          _buildAnalyticsItem("Jobs Completed", "89", Icons.check_circle, AppColors.success, context),
          SizedBox(height: isSmallScreen ? 8 : 12),
          _buildAnalyticsItem("Earnings", "\$24,580", Icons.attach_money, AppColors.primaryGreen, context),
        ],
      );
    } else {
      // Horizontal layout on larger screens
      return Row(
        children: [
          Expanded(
            child: _buildAnalyticsItem("Overall Rating", "4.8/5", Icons.star, AppColors.warning, context),
          ),
          SizedBox(width: isSmallScreen ? 8 : 12),
          Expanded(
            child: _buildAnalyticsItem("Jobs Completed", "89", Icons.check_circle, AppColors.success, context),
          ),
          SizedBox(width: isSmallScreen ? 8 : 12),
          Expanded(
            child: _buildAnalyticsItem("Earnings", "\$24,580", Icons.attach_money, AppColors.primaryGreen, context),
          ),
        ],
      );
    }
  }

  Widget _buildAnalyticsItem(String title, String value, IconData icon, Color color, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 10 : 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(isSmallScreen ? 8 : 12),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: isSmallScreen ? 16 : (screenWidth >= 600 ? 20 : 18),
          ),
          SizedBox(height: isSmallScreen ? 4 : 8),
          Text(
            value,
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : (screenWidth >= 600 ? 16 : 15),
              fontWeight: FontWeight.w700,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isSmallScreen ? 2 : 4),
          Text(
            title,
            style: TextStyle(
              fontSize: isSmallScreen ? 10 : (screenWidth >= 600 ? 12 : 11),
              color: AppColors.textGrey,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsOverview(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 500) {
      // Vertical layout for small screens
      return Column(
        children: [
          _buildStatCard("Active Jobs", "12", Icons.work, AppColors.primaryBlue, context),
          SizedBox(height: 12),
          _buildStatCard("Pending Jobs", "8", Icons.pending_actions, AppColors.warning, context),
          SizedBox(height: 12),
          _buildStatCard("New Requests", "5", Icons.notifications_active, AppColors.primaryGreen, context),
        ],
      );
    } else {
      // Horizontal layout for larger screens
      return Row(
        children: [
          Expanded(
            child: _buildStatCard("Active Jobs", "12", Icons.work, AppColors.primaryBlue, context),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _buildStatCard("Pending Jobs", "8", Icons.pending_actions, AppColors.warning, context),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _buildStatCard("New Requests", "5", Icons.notifications_active, AppColors.primaryGreen, context),
          ),
        ],
      );
    }
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
      ),
      child: Container(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: isSmallScreen ? 16 : (screenWidth >= 600 ? 20 : 18),
              ),
            ),
            SizedBox(height: isSmallScreen ? 6 : 8),
            Text(
              value,
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : (screenWidth >= 600 ? 18 : 17),
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            SizedBox(height: isSmallScreen ? 4 : 6),
            Text(
              title,
              style: TextStyle(
                fontSize: isSmallScreen ? 10 : (screenWidth >= 600 ? 12 : 11),
                color: AppColors.textGrey,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartsSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

    if (screenWidth < 800) {
      // Stack charts vertically on smaller screens
      return Column(
        children: [
          _buildPerformanceChartCard(context),
          SizedBox(height: isTablet ? 20 : 16),
          _buildPieChartCard(context),
        ],
      );
    } else {
      // Side by side on larger screens
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: _buildPerformanceChartCard(context),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: _buildPieChartCard(context),
          ),
        ],
      );
    }
  }

  Widget _buildPerformanceChartCard(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    final isDesktop = screenWidth >= 1024;
    final isSmallScreen = screenWidth < 400;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isDesktop ? 20 : isSmallScreen ? 12 : 16),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isDesktop ? 24 : isTablet ? 20 : isSmallScreen ? 16 : 20),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(isDesktop ? 20 : isSmallScreen ? 12 : 16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: AppColors.primaryGreen,
                  size: isSmallScreen ? 16 : (isTablet ? 20 : 18),
                ),
                SizedBox(width: isSmallScreen ? 6 : 8),
                Expanded(
                  child: Text(
                    "Revenue Trend",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : (isTablet ? 16 : 15),
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ],
            ),
            if (!isSmallScreen) SizedBox(height: 4),
            if (!isSmallScreen) Text(
              "Last 6 Months",
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textGrey,
              ),
            ),
            SizedBox(height: isDesktop ? 20 : isTablet ? 18 : isSmallScreen ? 12 : 16),
            Container(
              height: isSmallScreen ? 140 : (isTablet ? 200 : 180),
              child: PerformanceChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChartCard(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    final isDesktop = screenWidth >= 1024;
    final isSmallScreen = screenWidth < 400;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isDesktop ? 20 : isSmallScreen ? 12 : 16),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isDesktop ? 24 : isTablet ? 20 : isSmallScreen ? 16 : 20),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(isDesktop ? 20 : isSmallScreen ? 12 : 16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.pie_chart,
                  color: AppColors.primaryBlue,
                  size: isSmallScreen ? 16 : (isTablet ? 20 : 18),
                ),
                SizedBox(width: isSmallScreen ? 6 : 8),
                Expanded(
                  child: Text(
                    "Job Distribution",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : (isTablet ? 16 : 15),
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: isDesktop ? 20 : isTablet ? 18 : isSmallScreen ? 12 : 16),
            Container(
              height: isSmallScreen ? 140 : (isTablet ? 200 : 180),
              child: PieChartWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedMetrics(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    final isDesktop = screenWidth >= 1024;
    final isSmallScreen = screenWidth < 400;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isDesktop ? 20 : isSmallScreen ? 12 : 16),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isDesktop ? 24 : isTablet ? 20 : isSmallScreen ? 16 : 20),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(isDesktop ? 20 : isSmallScreen ? 12 : 16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.assessment,
                  color: AppColors.primaryGreen,
                  size: isSmallScreen ? 16 : (isTablet ? 20 : 18),
                ),
                SizedBox(width: isSmallScreen ? 8 : 12),
                Text(
                  "Performance Metrics",
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : (isTablet ? 18 : 17),
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
            SizedBox(height: isDesktop ? 20 : isTablet ? 18 : isSmallScreen ? 12 : 16),
            _buildMetricsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsList(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Column(
      children: [
        _buildMetricRow("Client Satisfaction", "4.8/5", 96, AppColors.success, context),
        SizedBox(height: isSmallScreen ? 12 : 16),
        _buildMetricRow("On-Time Delivery", "92%", 92, AppColors.primaryGreen, context),
        SizedBox(height: isSmallScreen ? 12 : 16),
        _buildMetricRow("Response Time", "2.4h", 88, AppColors.primaryBlue, context),
        SizedBox(height: isSmallScreen ? 12 : 16),
        _buildMetricRow("Job Completion", "89%", 89, AppColors.success, context),
        SizedBox(height: isSmallScreen ? 12 : 16),
        _buildMetricRow("Repeat Clients", "45%", 45, AppColors.warning, context),
      ],
    );
  }

  Widget _buildMetricRow(String label, String value, int percentage, Color color, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: isSmallScreen ? 12 : 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: isSmallScreen ? 6 : 8),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: color.withOpacity(0.2),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          borderRadius: BorderRadius.circular(4),
          minHeight: isSmallScreen ? 4 : 6,
        ),
      ],
    );
  }
}