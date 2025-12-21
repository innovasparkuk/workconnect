import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../utils/constants.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback? onTap;
  final bool showActions;

  const JobCard({
    Key? key,
    required this.job,
    this.onTap,
    this.showActions = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      job.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
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
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.person_outline, size: 16, color: AppColors.textGrey),
                  SizedBox(width: 6),
                  Text(
                    job.clientName, // Changed from job.client to job.clientName
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.attach_money, size: 16, color: AppColors.primaryGreen),
                  SizedBox(width: 6),
                  Text(
                    job.formattedBudget, // Changed from job.budget to job.formattedBudget
                    style: TextStyle(
                      color: AppColors.primaryGreen,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.schedule, size: 16, color: AppColors.textGrey),
                  SizedBox(width: 6),
                  Text(
                    _formatPostedDate(job.postedDate), // Added method to format date
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.flag, size: 16, color: _getPriorityColor()),
                  SizedBox(width: 6),
                  Text(
                    _getPriorityText(), // Added method for priority text
                    style: TextStyle(
                      color: _getPriorityColor(),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              if (showActions) _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryBlue,
              side: BorderSide(color: AppColors.primaryBlue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text('View Details'),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () => _handleJobAction(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(_getActionText()),
          ),
        ),
      ],
    );
  }

  // Method to format posted date
  String _formatPostedDate(DateTime postedDate) {
    final now = DateTime.now();
    final difference = now.difference(postedDate);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    }
  }

  // Method to determine priority color based on deadline
  Color _getPriorityColor() {
    final now = DateTime.now();
    final difference = job.deadline.difference(now);

    if (difference.inDays <= 3) {
      return AppColors.error; // High priority - red
    } else if (difference.inDays <= 7) {
      return AppColors.warning; // Medium priority - orange
    } else {
      return AppColors.success; // Low priority - green
    }
  }

  // Method to get priority text based on deadline
  String _getPriorityText() {
    final now = DateTime.now();
    final difference = job.deadline.difference(now);

    if (difference.inDays <= 3) {
      return 'HIGH';
    } else if (difference.inDays <= 7) {
      return 'MEDIUM';
    } else {
      return 'LOW';
    }
  }

  String _getActionText() {
    switch (job.status) {
      case 'Pending':
        return 'Accept Job';
      case 'In Progress':
        return 'Update';
      case 'Completed':
        return 'Review';
      default:
        return 'Take Action';
    }
  }

  void _handleJobAction(BuildContext context) {
    if (job.status == 'Pending') {
      _showAcceptDialog(context);
    } else {
      onTap?.call();
    }
  }

  void _showAcceptDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Accept Job"),
        content: Text("Are you sure you want to accept this job: ${job.title}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle job acceptance
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Job accepted successfully!"),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
            ),
            child: Text("Accept"),
          ),
        ],
      ),
    );
  }
}