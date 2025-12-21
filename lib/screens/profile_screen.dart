import 'package:flutter/material.dart';
import '../utils/constants.dart';

// Temporary User class yahi define karo
class User {
  final String name;
  final String role;
  final String profileImage;
  final double rating;
  final int completedJobs;
  final List<String> skills;
  final String bio;
  final String location;
  final String memberSince;

  User({
    required this.name,
    required this.role,
    required this.profileImage,
    required this.rating,
    required this.completedJobs,
    required this.skills,
    required this.bio,
    required this.location,
    required this.memberSince,
  });
}

class ProfileScreen extends StatelessWidget {
  // Temporary function yahi define karo
  User getCurrentUser() {
    return User(
      name: "John Doe",
      role: "Senior Flutter Developer",
      profileImage: "JD",
      rating: 4.8,
      completedJobs: 42,
      skills: [
        "Flutter",
        "Dart",
        "Firebase",
        "REST API",
        "UI/UX Design",
        "State Management",
        "Git",
        "Agile Methodology"
      ],
      bio: "Experienced Flutter developer with 5+ years of experience in building cross-platform mobile applications. Passionate about creating beautiful and performant apps with clean code architecture.",
      location: "New York, USA",
      memberSince: "2022",
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = getCurrentUser();

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        title: Text("My Profile"),
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () => _editProfile(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(user),
            SizedBox(height: 24),

            // Stats Overview
            _buildStatsOverview(user),
            SizedBox(height: 24),

            // Skills Section
            _buildSkillsSection(user),
            SizedBox(height: 24),

            // About Section
            _buildAboutSection(user),
            SizedBox(height: 24),

            // Settings Section
            _buildSettingsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(User user) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryBlue, AppColors.primaryGreen],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      user.profileImage,
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              user.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 4),
            Text(
              user.role,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: AppColors.warning, size: 20),
                SizedBox(width: 4),
                Text(
                  user.rating.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(width: 16),
                Icon(Icons.work, color: AppColors.textGrey, size: 20),
                SizedBox(width: 4),
                Text(
                  "${user.completedJobs} jobs",
                  style: TextStyle(
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsOverview(User user) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildProfileStat("Response Rate", "98%", Icons.flash_on),
            _buildProfileStat("On Time", "95%", Icons.timer),
            _buildProfileStat("Repeat Clients", "65%", Icons.group),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryGreen.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primaryGreen, size: 20),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryGreen,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection(User user) {
    return Card(
      elevation: 4,
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
            Text(
              "Skills & Expertise",
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
              children: user.skills.map((skill) => Chip(
                label: Text(
                  skill,
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 12,
                  ),
                ),
                backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
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

  Widget _buildAboutSection(User user) {
    return Card(
      elevation: 4,
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
            Text(
              "About Me",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 12),
            Text(
              user.bio,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textGrey,
                //lineHeight: 1.6,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.location_on, color: AppColors.textGrey, size: 16),
                SizedBox(width: 8),
                Text(
                  user.location,
                  style: TextStyle(
                    color: AppColors.textGrey,
                  ),
                ),
                SizedBox(width: 24),
                Icon(Icons.calendar_today, color: AppColors.textGrey, size: 16),
                SizedBox(width: 8),
                Text(
                  "Member since ${user.memberSince}",
                  style: TextStyle(
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Card(
      elevation: 4,
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
            Text(
              "Settings",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 12),
            _buildSettingsItem("Account Settings", Icons.person_outline),
            _buildSettingsItem("Notification Settings", Icons.notifications_outlined),
            _buildSettingsItem("Privacy & Security", Icons.lock_outline),
            _buildSettingsItem("Payment Methods", Icons.payment_outlined),
            _buildSettingsItem("Help & Support", Icons.help_outline),
            _buildSettingsItem("About App", Icons.info_outline),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryGreen),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.textDark,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textLight),
      onTap: () => _handleSettingsTap(title),
    );
  }

  void _editProfile(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit profile feature coming soon!'),
        backgroundColor: AppColors.primaryGreen,
      ),
    );
  }

  void _handleSettingsTap(String title) {
    print('Tapped: $title');
  }
}