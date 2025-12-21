import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../data/dummy_data.dart' as dummy;
import '../widgets/job_card.dart';
import 'job_detail_screen.dart';

class JobsScreen extends StatefulWidget {
  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    final isDesktop = screenWidth >= 1024;

    return Column(
      children: [
        // Tab Bar with responsive margins
        Card(
          margin: EdgeInsets.all(isDesktop ? 20 : isTablet ? 18 : 16),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isDesktop ? 20 : 16),
          ),
          child: Container(
            width: double.infinity,
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primaryGreen,
              labelColor: AppColors.primaryGreen,
              unselectedLabelColor: AppColors.textGrey,
              isScrollable: screenWidth < 700, // Scrollable for smaller screens
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: _getResponsiveFontSize(context, 14, 13, 12),
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: _getResponsiveFontSize(context, 14, 13, 12),
              ),
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.primaryGreen,
                    width: isDesktop ? 3 : 2,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 20 : isTablet ? 16 : 12,
                vertical: isDesktop ? 12 : isTablet ? 10 : 8,
              ),
              tabs: _buildTabs(screenWidth),
            ),
          ),
        ),

        SizedBox(height: isDesktop ? 20 : isTablet ? 16 : 12),

        // Tab Bar View
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              JobListScreen(status: "active"),
              JobListScreen(status: "pending"),
              JobListScreen(status: "completed"),
              JobListScreen(status: "rejected"),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildTabs(double screenWidth) {
    if (screenWidth < 350) {
      // Very small screens - minimal text
      return [
        Tab(text: "Active"),
        Tab(text: "Pending"),
        Tab(text: "Done"),
        Tab(text: "Rejected"),
      ];
    } else if (screenWidth < 450) {
      // Small screens - short text
      return [
        Tab(text: "Active"),
        Tab(text: "Pending"),
        Tab(text: "Complete"),
        Tab(text: "Rejected"),
      ];
    } else if (screenWidth < 600) {
      // Medium screens - full text without counts
      return [
        Tab(text: "Active"),
        Tab(text: "Pending"),
        Tab(text: "Completed"),
        Tab(text: "Rejected"),
      ];
    } else {
      // Large screens - full text with counts
      final jobCounts = _getJobCounts();
      return [
        Tab(text: "Active (${jobCounts['active']})"),
        Tab(text: "Pending (${jobCounts['pending']})"),
        Tab(text: "Completed (${jobCounts['completed']})"),
        Tab(text: "Rejected (${jobCounts['rejected']})"),
      ];
    }
  }

  Map<String, int> _getJobCounts() {
    final jobs = dummy.DummyData.getJobs();
    return {
      'active': jobs.where((job) => job.status == "In Progress").length,
      'pending': jobs.where((job) => job.status == "Pending" || job.status == "Pending Review").length,
      'completed': jobs.where((job) => job.status == "Completed").length,
      'rejected': jobs.where((job) => job.status == "Rejected").length,
    };
  }

  double _getResponsiveFontSize(BuildContext context, double normal, double tablet, double mobile) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1024) {
      return normal;
    } else if (width >= 600) {
      return tablet;
    } else {
      return mobile;
    }
  }
}

class JobListScreen extends StatelessWidget {
  final String status;

  const JobListScreen({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredJobs = _getFilteredJobs();
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    final isDesktop = screenWidth >= 1024;

    if (filteredJobs.isEmpty) {
      return _buildEmptyState();
    }

    // For desktop, use grid layout for better space utilization
    if (isDesktop) {
      return _buildDesktopGrid(filteredJobs);
    }

    // For tablet and mobile, use list view
    return _buildJobList(filteredJobs);
  }

  List<dynamic> _getFilteredJobs() {
    return dummy.DummyData.getJobs().where((job) {
      switch (status) {
        case "active":
          return job.status == "In Progress";
        case "pending":
          return job.status == "Pending" || job.status == "Pending Review";
        case "completed":
          return job.status == "Completed";
        case "rejected":
          return job.status == "Rejected";
        default:
          return true;
      }
    }).toList();
  }

  Widget _buildDesktopGrid(List<dynamic> filteredJobs) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth ~/ 400; // Adjust card width
        return GridView.builder(
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount.clamp(1, 3), // Min 1, max 3 columns
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.6, // Wider cards for desktop
          ),
          itemCount: filteredJobs.length,
          itemBuilder: (context, index) {
            final job = filteredJobs[index];
            return JobCard(
              job: job,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobDetailScreen(job: job),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildJobList(List<dynamic> filteredJobs) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isTablet = screenWidth >= 600;
        final isSmallScreen = screenWidth < 400;

        return ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 20 : isSmallScreen ? 12 : 16,
            vertical: isTablet ? 16 : isSmallScreen ? 8 : 12,
          ),
          itemCount: filteredJobs.length,
          itemBuilder: (context, index) {
            final job = filteredJobs[index];
            return Container(
              margin: EdgeInsets.only(
                bottom: isTablet ? 20 : isSmallScreen ? 12 : 16,
              ),
              child: JobCard(
                job: job,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JobDetailScreen(job: job),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isTablet = screenWidth >= 600;
        final isDesktop = screenWidth >= 1024;
        final isSmallScreen = screenWidth < 400;

        return Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isDesktop ? 40 : isTablet ? 32 : 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getEmptyIcon(),
                  size: isDesktop ? 96 : isTablet ? 80 : isSmallScreen ? 48 : 64,
                  color: AppColors.textLight.withOpacity(0.6),
                ),
                SizedBox(height: isDesktop ? 24 : isTablet ? 20 : 16),
                Text(
                  _getEmptyMessage(),
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 24, 20, 18),
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isDesktop ? 12 : isTablet ? 10 : 8),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 500 : isTablet ? 400 : 300,
                  ),
                  child: Text(
                    _getEmptySubtitle(),
                    style: TextStyle(
                      fontSize: _getResponsiveFontSize(context, 16, 14, 12),
                      color: AppColors.textLight,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (status == "active") _buildFindJobsButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFindJobsButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: ElevatedButton(
        onPressed: () {
          // Navigate to find jobs screen
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          "Find Jobs",
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 16, 14, 12),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  IconData _getEmptyIcon() {
    switch (status) {
      case "active":
        return Icons.work_outline;
      case "pending":
        return Icons.pending_actions;
      case "completed":
        return Icons.check_circle_outline;
      case "rejected":
        return Icons.cancel_outlined;
      default:
        return Icons.work_outline;
    }
  }

  String _getEmptyMessage() {
    switch (status) {
      case "active":
        return "No Active Jobs";
      case "pending":
        return "No Pending Jobs";
      case "completed":
        return "No Completed Jobs";
      case "rejected":
        return "No Rejected Jobs";
      default:
        return "No Jobs Found";
    }
  }

  String _getEmptySubtitle() {
    switch (status) {
      case "active":
        return "Start accepting new jobs to see them here. Browse available opportunities and apply for ones that match your skills.";
      case "pending":
        return "All your pending job requests and applications will appear here once you submit them.";
      case "completed":
        return "Your successfully completed jobs will be shown here along with client feedback and ratings.";
      case "rejected":
        return "Jobs you've declined or that didn't match your criteria will appear here for reference.";
      default:
        return "Check back later for new opportunities that match your profile and preferences.";
    }
  }

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
}