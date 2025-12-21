import 'package:flutter/material.dart';
import '../utils/constants.dart';

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<FlaggedItem> _flaggedItems = [];
  List<FlaggedItem> _filteredItems = [];
  String _currentFilter = 'all';

  @override
  void initState() {
    super.initState();
    _loadFlaggedContent();
  }

  void _loadFlaggedContent() {
    setState(() {
      _flaggedItems = [
        FlaggedItem(
          id: '1',
          jobTitle: 'Website Development Project',
          flaggedBy: 'John Doe',
          reason: 'Inappropriate language in project description',
          content: 'This project requires immediate completion with aggressive deadlines...',
          severity: 'high',
          date: DateTime.now().subtract(Duration(hours: 2)),
          status: 'pending',
          jobId: 'JOB-001',
        ),
        FlaggedItem(
          id: '2',
          jobTitle: 'Mobile App Design',
          flaggedBy: 'Jane Smith',
          reason: 'Suspicious payment terms',
          content: 'Payment will be released only after 30 days of completion...',
          severity: 'medium',
          date: DateTime.now().subtract(Duration(days: 1)),
          status: 'resolved',
          jobId: 'JOB-002',
        ),
        FlaggedItem(
          id: '3',
          jobTitle: 'Content Writing - Blog Posts',
          flaggedBy: 'Mike Johnson',
          reason: 'Plagiarism detected',
          content: 'Sample content matches existing online articles...',
          severity: 'high',
          date: DateTime.now().subtract(Duration(days: 3)),
          status: 'pending',
          jobId: 'JOB-003',
        ),
        FlaggedItem(
          id: '4',
          jobTitle: 'SEO Optimization',
          flaggedBy: 'Sarah Wilson',
          reason: 'Misleading job requirements',
          content: 'Job post mentions remote work but requires office attendance...',
          severity: 'low',
          date: DateTime.now().subtract(Duration(days: 5)),
          status: 'reviewed',
          jobId: 'JOB-004',
        ),
      ];
      _filteredItems = _flaggedItems;
    });
  }

  void _filterItems(String filter) {
    setState(() {
      _currentFilter = filter;
      if (filter == 'all') {
        _filteredItems = _flaggedItems;
      } else {
        _filteredItems = _flaggedItems.where((item) => item.status == filter).toList();
      }
    });
  }

  void _updateItemStatus(String id, String newStatus) {
    setState(() {
      final index = _flaggedItems.indexWhere((item) => item.id == id);
      if (index != -1) {
        _flaggedItems[index] = _flaggedItems[index].copyWith(status: newStatus);
        _filterItems(_currentFilter);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Status updated to ${newStatus.replaceAll('_', ' ')}'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showFlagDetails(FlaggedItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FlagDetailsBottomSheet(item: item, onStatusUpdate: _updateItemStatus),
    );
  }

  void _deleteFlaggedItem(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text('Delete Flagged Content', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          content: Text('Are you sure you want to remove this flagged item?', style: TextStyle(fontSize: 12)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _flaggedItems.removeWhere((item) => item.id == id);
                  _filterItems(_currentFilter);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Flagged item deleted successfully'),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                );
              },
              child: Text('Delete', style: TextStyle(color: Colors.red, fontSize: 12)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Title Section with Blue-Green Gradient


            // Main Content
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 630,
                  ),
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      // Statistics Card
                      SliverToBoxAdapter(
                        child: _buildStatisticsCard(),
                      ),

                      // Filter Chips
                      SliverToBoxAdapter(
                        child: _buildFilterSection(),
                      ),

                      // Content List
                      _filteredItems.isEmpty
                          ? SliverFillRemaining(
                        child: _buildEmptyState(),
                      )
                          : SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final item = _filteredItems[index];
                            return _buildFlaggedItem(item, context);
                          },
                          childCount: _filteredItems.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCard() {
    final pending = _flaggedItems.where((item) => item.status == 'pending').length;
    final reviewed = _flaggedItems.where((item) => item.status == 'reviewed').length;
    final resolved = _flaggedItems.where((item) => item.status == 'resolved').length;
    final total = _flaggedItems.length;

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0FC1EF),
            Color(0xFF00C9A7),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ' Content Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Total: $total',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(pending, 'Pending', Colors.orange, Icons.pending_actions_rounded),
              _buildStatItem(reviewed, 'Reviewed', Colors.purple, Icons.visibility_rounded),
              _buildStatItem(resolved, 'Resolved', Colors.green, Icons.check_circle_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(int count, String label, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        SizedBox(height: 8),
        Text(
          count.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 120, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip('all', 'All'),
            SizedBox(width: 8),
            _buildFilterChip('pending', 'Pending'),
            SizedBox(width: 8),
            _buildFilterChip('reviewed', 'Reviewed'),
            SizedBox(width: 8),
            _buildFilterChip('resolved', 'Resolved'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final isSelected = _currentFilter == value;
    return GestureDetector(
      onTap: () => _filterItems(value),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF2196F3) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Color(0xFF2196F3) : Color(0xFFE5E7EB),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Color(0xFF374151),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Color(0xFF2196F3).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.flag_outlined,
              size: 40,
              color: Color(0xFF2196F3),
            ),
          ),
          SizedBox(height: 16),
          Text(
            "No Flagged Content",
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF374151),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Flagged items will appear here",
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlaggedItem(FlaggedItem item, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _showFlagDetails(item),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _getSeverityColor(item.severity).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _getSeverityIcon(item.severity),
                        color: _getSeverityColor(item.severity),
                        size: 22,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.jobTitle,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xFF374151),
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'ID: ${item.jobId}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildSeverityChip(item.severity),
                  ],
                ),
                SizedBox(height: 12),

                // Reason
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFFF3F4F6)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline_rounded, size: 16, color: Color(0xFF2196F3)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reason',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6B7280),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              item.reason,
                              style: TextStyle(
                                color: Color(0xFF374151),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),

                // Footer
                Row(
                  children: [
                    // Status and Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStatusChip(item.status),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.person_outline_rounded, size: 14, color: Color(0xFF6B7280)),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  item.flaggedBy,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6B7280),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 12),
                              Icon(Icons.access_time_rounded, size: 14, color: Color(0xFF6B7280)),
                              SizedBox(width: 6),
                              Text(
                                _formatDate(item.date),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Action Menu
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert_rounded, color: Color(0xFF6B7280), size: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        onSelected: (value) {
                          if (value == 'view') {
                            _showFlagDetails(item);
                          } else if (value == 'delete') {
                            _deleteFlaggedItem(item.id);
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            value: 'view',
                            child: Row(
                              children: [
                                Icon(Icons.visibility_outlined, size: 18, color: Color(0xFF2196F3)),
                                SizedBox(width: 8),
                                Text('View Details', style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete_outline_rounded, size: 18, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Delete', style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Color(0xFF6B7280);
    }
  }

  IconData _getSeverityIcon(String severity) {
    switch (severity) {
      case 'high':
        return Icons.warning_amber_rounded;
      case 'medium':
        return Icons.info_outline_rounded;
      case 'low':
        return Icons.check_circle_outline_rounded;
      default:
        return Icons.flag_outlined;
    }
  }

  Widget _buildSeverityChip(String severity) {
    Color color = _getSeverityColor(severity);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getSeverityIcon(severity), size: 14, color: color),
          SizedBox(width: 6),
          Text(
            severity.toUpperCase(),
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String label;

    switch (status) {
      case 'pending':
        color = Colors.orange;
        label = 'Pending Review';
        break;
      case 'reviewed':
        color = Colors.purple;
        label = 'Under Review';
        break;
      case 'resolved':
        color = Colors.green;
        label = 'Resolved';
        break;
      default:
        color = Color(0xFF6B7280);
        label = status;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

class FlagDetailsBottomSheet extends StatelessWidget {
  final FlaggedItem item;
  final Function(String, String) onStatusUpdate;

  const FlagDetailsBottomSheet({
    Key? key,
    required this.item,
    required this.onStatusUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Flag Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF374151),
                ),
              ),
              _buildSeverityChip(item.severity),
            ],
          ),
          SizedBox(height: 20),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Job Information
                  _buildDetailSection('Job Information', Icons.work_outline_rounded, [
                    _buildDetailRow('Job Title', item.jobTitle),
                    _buildDetailRow('Job ID', item.jobId),
                    _buildDetailRow('Flagged By', item.flaggedBy),
                    _buildDetailRow('Date', _formatDetailedDate(item.date)),
                  ]),
                  SizedBox(height: 20),

                  // Reason
                  _buildDetailSection('Reason for Flagging', Icons.flag_outlined, [
                    Text(
                      item.reason,
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 16,
                        height: 1.4,
                      ),
                    ),
                  ]),
                  SizedBox(height: 20),

                  // Content
                  _buildDetailSection('Flagged Content', Icons.content_copy_rounded, [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFFF3F4F6)),
                      ),
                      child: Text(
                        item.content,
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(height: 25),

                  // Actions
                  Text(
                    'Update Status',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatusButton(context, 'pending', 'Pending', Colors.orange, Icons.pending_actions_rounded),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildStatusButton(context, 'reviewed', 'Reviewed', Colors.purple, Icons.visibility_rounded),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildStatusButton(context, 'resolved', 'Resolved', Colors.green, Icons.check_circle_rounded),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Close Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2196F3),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Close',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, IconData icon, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Color(0xFF2196F3)),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
                fontSize: 18,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFF374151),
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeverityChip(String severity) {
    Color color;
    switch (severity) {
      case 'high':
        color = Colors.red;
        break;
      case 'medium':
        color = Colors.orange;
        break;
      case 'low':
        color = Colors.green;
        break;
      default:
        color = Color(0xFF6B7280);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 10, color: color),
          SizedBox(width: 8),
          Text(
            '${severity.toUpperCase()} SEVERITY',
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusButton(BuildContext context, String status, String label, Color color, IconData icon) {
    return Container(
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {
          onStatusUpdate(item.id, status);
          Navigator.of(context).pop();
        },
        icon: Icon(icon, size: 18),
        label: Text(
          label,
          style: TextStyle(fontSize: 14),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  String _formatDetailedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class FlaggedItem {
  final String id;
  final String jobTitle;
  final String flaggedBy;
  final String reason;
  final String content;
  final String severity;
  final DateTime date;
  final String status;
  final String jobId;

  FlaggedItem({
    required this.id,
    required this.jobTitle,
    required this.flaggedBy,
    required this.reason,
    required this.content,
    required this.severity,
    required this.date,
    required this.status,
    required this.jobId,
  });

  FlaggedItem copyWith({
    String? status,
  }) {
    return FlaggedItem(
      id: id,
      jobTitle: jobTitle,
      flaggedBy: flaggedBy,
      reason: reason,
      content: content,
      severity: severity,
      date: date,
      status: status ?? this.status,
      jobId: jobId,
    );
  }
}