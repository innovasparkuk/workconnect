import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/custom_bottom_nav.dart';
import 'overview_screen.dart';
import 'jobs_screen.dart';
import 'analytics_screen.dart';
import 'messages_screen.dart';
import 'profile_screen.dart';
import 'create_job_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    OverviewScreen(),
    JobsScreen(),
    AnalyticsScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];
  final List<String> _appBarTitles = [
    "Dashboard Overview",
    "Jobs Management",
    "Performance Analytics",
    //"Flagged Content",
    "My Profile"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        title: Text(
          _appBarTitles[_currentIndex],
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        backgroundColor: AppColors.cardWhite, // White background
        elevation: 2, // Light shadow
        foregroundColor: AppColors.textDark, // Back button color
        actions: _buildAppBarActions(),
      ),
      body: _screens[_currentIndex],
      floatingActionButton: _currentIndex == 1 ? _buildFloatingActionButton() : null,
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      IconButton(
        icon: Stack(
          children: [
            Icon(Icons.notifications_outlined, color: AppColors.textDark),
            Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(minWidth: 14, minHeight: 14),
                child: Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        onPressed: () => _showNotifications(),
      ),
      IconButton(
        icon: Icon(Icons.search, color: AppColors.textDark),
        onPressed: () => _showSearch(),
      ),
      PopupMenuButton<String>(
        icon: Icon(Icons.more_vert, color: AppColors.textDark),
        onSelected: (value) => _handleMenuSelection(value),
        itemBuilder: (BuildContext context) {
          return {
            'Create New Job',
            'Settings',
            'Help & Support',
            'Logout'
          }.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      ),
    ];
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => _createNewJob(),
      backgroundColor: AppColors.primaryGreen,
      child: Icon(Icons.add, color: Colors.white, size: 28),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  void _showNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notifications feature coming soon!'),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  void _showSearch() {
    showSearch(
      context: context,
      delegate: JobSearchDelegate(),
    );
  }

  void _handleMenuSelection(String value) {
    switch (value) {
      case 'Create New Job':
        _createNewJob();
        break;
      case 'Settings':
        _showSettings();
        break;
      case 'Help & Support':
        _showHelp();
        break;
      case 'Logout':
        _logout();
        break;
    }
  }

  void _createNewJob() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateJobScreen()),
    );
  }

  void _showSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Settings feature coming soon!'),
        backgroundColor: AppColors.primaryGreen,
      ),
    );
  }

  void _showHelp() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Help & Support feature coming soon!'),
        backgroundColor: AppColors.warning,
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
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
                  content: Text('Logged out successfully!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}

class JobSearchDelegate extends SearchDelegate<String> {
  final List<String> _searchHistory = [
    'Flutter Developer',
    'UI/UX Designer',
    'Project Manager',
    'React Native'
  ];

  final List<Map<String, String>> _allJobs = [
    {
      'title': 'Senior Flutter Developer',
      'company': 'Tech Solutions Inc.',
      'salary': '\$5,000',
      'type': 'Full-time',
      'location': 'Remote',
      'posted': '2 days ago',
      'logo': 'TS'
    },
    {
      'title': 'UI/UX Designer',
      'company': 'Creative Studio',
      'salary': '\$3,500',
      'type': 'Contract',
      'location': 'New York',
      'posted': '1 day ago',
      'logo': 'CS'
    },
    {
      'title': 'Project Manager',
      'company': 'Business Solutions',
      'salary': '\$6,000',
      'type': 'Full-time',
      'location': 'San Francisco',
      'posted': '3 days ago',
      'logo': 'BS'
    },
    {
      'title': 'React Native Developer',
      'company': 'Mobile First Ltd.',
      'salary': '\$4,500',
      'type': 'Remote',
      'location': 'Remote',
      'posted': '5 hours ago',
      'logo': 'MF'
    },
    {
      'title': 'Backend Developer',
      'company': 'Data Systems Corp',
      'salary': '\$5,500',
      'type': 'Full-time',
      'location': 'Austin',
      'posted': '1 week ago',
      'logo': 'DS'
    },
    {
      'title': 'Junior Flutter Developer',
      'company': 'Startup Ventures',
      'salary': '\$3,000',
      'type': 'Internship',
      'location': 'Remote',
      'posted': 'Just now',
      'logo': 'SV'
    },
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Map<String, String>> results = _allJobs.where((job) =>
        job['title']!.toLowerCase().contains(query.toLowerCase())).toList();

    return results.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: AppColors.textGrey),
          SizedBox(height: 16),
          Text(
            'No results found for "$query"',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    )
        : ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: results.length,
      itemBuilder: (context, index) => _buildJobCard(results[index], context),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Map<String, String>> suggestionList = query.isEmpty
        ? []
        : _allJobs.where((job) =>
        job['title']!.toLowerCase().contains(query.toLowerCase())).toList();

    return query.isEmpty
        ? ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _searchHistory.length,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.history, color: AppColors.primaryBlue),
        title: Text(_searchHistory[index]),
        onTap: () {
          query = _searchHistory[index];
          showResults(context);
        },
      ),
    )
        : ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => _buildJobCard(suggestionList[index], context),
    );
  }

  Widget _buildJobCard(Map<String, String> job, BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
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
                    job['title']!,
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
                    color: AppColors.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    job['type']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                  radius: 16,
                  child: Text(
                    job['logo']!,
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.primaryBlue,
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
                        job['company']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        job['location']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.attach_money, size: 16, color: AppColors.primaryGreen),
                    SizedBox(width: 4),
                    Text(
                      job['salary']!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 14, color: AppColors.textGrey),
                    SizedBox(width: 4),
                    Text(
                      job['posted']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  close(context, job['title']!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'View Details',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}