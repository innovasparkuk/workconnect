import 'package:flutter/material.dart';
import '../utils/constants.dart';

class OverviewScreen extends StatefulWidget {
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          _buildWelcomeSection(),
          SizedBox(height: 24),

          // Stats Grid
          _buildStatsGrid(),
          SizedBox(height: 15),

          // Analytics Section
          _buildAnalyticsSection(),
          SizedBox(height: 24),

          // Recent Activity
          _buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryBlue.withOpacity(0.8),
            AppColors.primaryGreen.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Good Morning, John!",
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, 24, 20, 18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Here's what's happening with your jobs today",
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, 16, 14, 12),
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    int crossAxisCount;
    if (isDesktop) {
      crossAxisCount = 4;
    } else if (isTablet) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 2;
    }

    double childAspectRatio;
    if (isDesktop) {
      childAspectRatio = 1.3;
    } else if (isTablet) {
      childAspectRatio = 1.4;
    } else {
      childAspectRatio = 1.2;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Overview",
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 20, 18, 16),
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 5),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: childAspectRatio,
          children: [
            _buildStatCard("Active Jobs", "12", Icons.work_outline, AppColors.primaryBlue),
            _buildStatCard("Completed", "28", Icons.check_circle_outline, AppColors.primaryGreen),
            _buildStatCard("Pending", "5", Icons.pending_actions, AppColors.warning),
            _buildStatCard("Earnings", "\$2,840", Icons.attach_money, AppColors.success),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    final isSmallScreen = MediaQuery.of(context).size.width < 350;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade100,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon at top center
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: isSmallScreen ? 20 : 24,
                color: color,
              ),
            ),

            SizedBox(height: isSmallScreen ? 8 : 12),

            // Value in center
            Text(
              value,
              style: TextStyle(
                fontSize: isSmallScreen ? 18 : 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: isSmallScreen ? 4 : 6),

            // Title at bottom center
            Text(
              title,
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
                color: AppColors.textGrey,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: isSmallScreen ? 4 : 6),

            // Progress indicator at bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.trending_up,
                  size: isSmallScreen ? 12 : 14,
                  color: AppColors.primaryGreen,
                ),
                SizedBox(width: 4),
                Text(
                  "+12%",
                  style: TextStyle(
                    fontSize: isSmallScreen ? 10 : 12,
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsSection() {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    final isSmallScreen = MediaQuery.of(context).size.width < 400;

    return Column(
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
                size: isSmallScreen ? 18 : (isTablet ? 22 : 20),
              ),
            ),
            SizedBox(width: isSmallScreen ? 8 : 12),
            Text(
              "Performance Analytics",
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : (isTablet ? 20 : 18),
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
        SizedBox(height: isDesktop ? 20 : isTablet ? 16 : isSmallScreen ? 12 : 16),
        _buildAnalyticsGrid(context),
      ],
    );
  }

  Widget _buildAnalyticsGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    final isDesktop = screenWidth >= 1024;
    final isSmallScreen = screenWidth < 400;
    final isVerySmallScreen = screenWidth < 350;

    if (screenWidth < 500) {
      // Stack vertically on small screens
      return Column(
        children: [
          _buildAnalyticsItem("Overall Rating", "4.8/5", Icons.star, AppColors.warning, context),
          SizedBox(height: isVerySmallScreen ? 8 : (isSmallScreen ? 10 : 12)),
          _buildAnalyticsItem("Jobs Completed", "89", Icons.check_circle, AppColors.success, context),
          SizedBox(height: isVerySmallScreen ? 8 : (isSmallScreen ? 10 : 12)),
          _buildAnalyticsItem("Total Earnings", "\$24,580", Icons.attach_money, AppColors.primaryGreen, context),
        ],
      );
    } else {
      // Horizontal layout for larger screens
      return Row(
        children: [
          Expanded(
            child: _buildAnalyticsItem("Overall Rating", "4.8/5", Icons.star, AppColors.warning, context),
          ),
          SizedBox(width: isVerySmallScreen ? 6 : (isSmallScreen ? 8 : (isTablet ? 12 : 10))),
          Expanded(
            child: _buildAnalyticsItem("Jobs Completed", "89", Icons.check_circle, AppColors.success, context),
          ),
          SizedBox(width: isVerySmallScreen ? 6 : (isSmallScreen ? 8 : (isTablet ? 12 : 10))),
          Expanded(
            child: _buildAnalyticsItem("Total Earnings", "\$24,580", Icons.attach_money, AppColors.primaryGreen, context),
          ),
        ],
      );
    }
  }

  Widget _buildAnalyticsItem(String title, String value, IconData icon, Color color, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    final isDesktop = screenWidth >= 1024;
    final isSmallScreen = screenWidth < 400;
    final isVerySmallScreen = screenWidth < 350;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isDesktop ? 12 : (isSmallScreen ? 8 : 10)),
      ),
      child: Container(
        padding: EdgeInsets.all(isVerySmallScreen ? 10 : (isSmallScreen ? 12 : (isTablet ? 16 : 14))),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isDesktop ? 12 : (isSmallScreen ? 8 : 10)),
          border: Border.all(
            color: Colors.grey.shade100,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(isVerySmallScreen ? 6 : (isSmallScreen ? 7 : (isTablet ? 10 : 8))),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(isDesktop ? 10 : (isSmallScreen ? 6 : 8)),
              ),
              child: Icon(
                  icon,
                  size: isVerySmallScreen ? 16 : (isSmallScreen ? 18 : (isTablet ? 22 : 20)),
                  color: color
              ),
            ),
            SizedBox(width: isVerySmallScreen ? 8 : (isSmallScreen ? 10 : (isTablet ? 14 : 12))),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isVerySmallScreen ? 11 : (isSmallScreen ? 12 : (isTablet ? 15 : 13)),
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: isVerySmallScreen ? 2 : (isSmallScreen ? 3 : 4)),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: isVerySmallScreen ? 14 : (isSmallScreen ? 16 : (isTablet ? 20 : 18)),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: isVerySmallScreen ? 16 : (isSmallScreen ? 18 : (isTablet ? 22 : 20)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, 20, 18, 16),
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: _getResponsiveFontSize(context, 14, 13, 12),
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _buildActivityItem("New job assigned", "Mobile App Development", "2 hours ago"),
                Divider(height: 20),
                _buildActivityItem("Payment received", "\$500 from Client A", "5 hours ago"),
                Divider(height: 20),
                _buildActivityItem("Job completed", "Website Redesign", "Yesterday"),
                Divider(height: 20),
                _buildActivityItem("New message", "From Project Manager", "2 days ago"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(String title, String subtitle, String time) {
    final isSmallScreen = MediaQuery.of(context).size.width < 350;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 300) {
          // Compact layout for very small screens
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                        Icons.notifications_none,
                        size: 18,
                        color: AppColors.primaryBlue
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  time,
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textGrey,
                  ),
                ),
              ),
            ],
          );
        } else {
          // Standard layout
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: isSmallScreen ? 36 : 40,
              height: isSmallScreen ? 36 : 40,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                  Icons.notifications_none,
                  size: isSmallScreen ? 18 : 20,
                  color: AppColors.primaryBlue
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
                fontSize: _getResponsiveFontSize(context, 16, 14, 13),
              ),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, 14, 13, 12),
              ),
            ),
            trailing: Text(
              time,
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, 12, 11, 10),
                color: AppColors.textGrey,
              ),
            ),
          );
        }
      },
    );
  }

  // Helper methods for responsive sizing
  double _getResponsiveFontSize(BuildContext context, double desktop, double tablet, double mobile) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1024) {
      return desktop;
    } else if (width >= 600) {
      return tablet;
    } else {
      return mobile;
    }
  }

  double _getResponsiveIconSize(BuildContext context, double desktop, double tablet, double mobile) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1024) {
      return desktop;
    } else if (width >= 600) {
      return tablet;
    } else {
      return mobile;
    }
  }
}