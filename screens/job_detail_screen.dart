import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../utils/constants.dart';

class JobDetailScreen extends StatelessWidget {
  final Job job;

  const JobDetailScreen({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Job Details",
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: IconThemeData(
          color: AppColors.textDark,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: AppColors.textDark),
            onPressed: () => _shareJob(context),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: AppColors.textDark),
            onSelected: (value) => _handleMenuSelection(value, context),
            itemBuilder: (BuildContext context) {
              return {
                'Save Job',
                'Report Job',
                'Contact Support'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: false, // Important: prevents bottom overflow
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 20, // Extra bottom padding
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Job Header
                      _buildJobHeader(context),
                      SizedBox(height: 20),

                      // Job Details
                      Expanded(
                        child: _buildJobDetails(context),
                      ),
                      SizedBox(height: 20),

                      // Skills Required
                      _buildSkillsSection(context),
                      SizedBox(height: 20),

                      // Action Buttons - Always at bottom
                      _buildActionButtons(context),

                      // Extra bottom space for safe area
                      SizedBox(height: MediaQuery.of(context).padding.bottom),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildJobHeader(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    job.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: job.statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    job.status,
                    style: TextStyle(
                      fontSize: 12,
                      color: job.statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Client Info
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryGreen.withOpacity(0.1),
                  child: Text(
                    job.clientImage,
                    style: TextStyle(
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.clientName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: AppColors.warning, size: 16),
                          SizedBox(width: 4),
                          Text(
                            job.clientRating,
                            style: TextStyle(
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Job Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDetailItem(Icons.attach_money, job.formattedBudget, "Budget"),
                _buildDetailItem(Icons.schedule, job.formattedDuration, "Duration"),
                _buildDetailItem(Icons.calendar_today, job.formattedDeadline, "Deadline"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primaryGreen, size: 24),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildJobDetails(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Job Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 12),
            Flexible(
              child: Text(
                job.description,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textGrey,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.location_on, color: AppColors.textGrey, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    job.location,
                    style: TextStyle(
                      color: AppColors.textGrey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 24),
                Icon(Icons.work_outline, color: AppColors.textGrey, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    job.type,
                    style: TextStyle(
                      color: AppColors.textGrey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Skills Required",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: job.requiredSkills.map((skill) => Chip(
                label: Text(
                  skill,
                  style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 12,
                  ),
                ),
                backgroundColor: AppColors.primaryGreen.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => _rejectJob(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: BorderSide(color: AppColors.error),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text('Reject Job'),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _acceptJob(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(_getActionButtonText()),
            ),
          ),
        ],
      ),
    );
  }

  String _getActionButtonText() {
    switch (job.status) {
      case "Pending":
        return "Accept Job";
      case "In Progress":
        return "Update Progress";
      case "Completed":
        return "View Completion";
      default:
        return "Take Action";
    }
  }

  void _acceptJob(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Accept Job"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Are you sure you want to accept this job?"),
            SizedBox(height: 8),
            Text(
              job.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryGreen,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Job accepted successfully!"),
                  backgroundColor: AppColors.success,
                ),
              );
              Navigator.pop(context); // Go back to jobs list
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
            ),
            child: Text("Accept Job"),
          ),
        ],
      ),
    );
  }

  void _rejectJob(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reject Job"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Are you sure you want to reject this job?"),
            SizedBox(height: 8),
            Text(
              job.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.error,
              ),
            ),
            SizedBox(height: 16),
            Text("Reason for rejection (optional):"),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter reason...",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Job rejected successfully!"),
                  backgroundColor: AppColors.error,
                ),
              );
              Navigator.pop(context); // Go back to jobs list
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: Text("Reject Job"),
          ),
        ],
      ),
    );
  }

  void _shareJob(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Share feature coming soon!'),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  void _handleMenuSelection(String value, BuildContext context) {
    switch (value) {
      case 'Save Job':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Job saved to favorites!'),
            backgroundColor: AppColors.success,
          ),
        );
        break;
      case 'Report Job':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Report feature coming soon!'),
            backgroundColor: AppColors.warning,
          ),
        );
        break;
      case 'Contact Support':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Support feature coming soon!'),
            backgroundColor: AppColors.primaryBlue,
          ),
        );
        break;
    }
  }
}