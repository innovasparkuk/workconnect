import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
//import 'package:workroom/payment.dart';
//import 'package:workroom/profile_setup.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb
        ? FirebaseOptions(
      apiKey: "your-api-key",
      appId: "your-app-id",
      messagingSenderId: "your-messaging-sender-id",
      projectId: "your-project-id",
    )
        : null,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
      theme: ThemeData(
        primaryColor: Color(0xFF66B2FF),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFF66B2FF).withOpacity(0.8),
        ),
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF424242)),
          bodySmall: TextStyle(color: Color(0xFF616161)),
          titleMedium: TextStyle(color: Color(0xFF212121)),
        ),
        platform: TargetPlatform.iOS, // For cross-platform consistency
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 600;
        final bool isLargeScreen = constraints.maxWidth > 900;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: isSmallScreen
              ? AppBar(
            title: const Text("Freelancer Profile",
                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
          )
              : null,
          body: SingleChildScrollView(
            child: Padding(
              padding: isLargeScreen
                  ? EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1)
                  : EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isSmallScreen)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      color: Theme.of(context).primaryColor,
                      child: Text("Freelancer Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 24
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  // Profile Header with Photo and Name side by side
                  _buildCompactProfileHeader(context, isSmallScreen),

                  // Stats Section
                  _buildStatsSection(context, isSmallScreen),

                  // Skills Section
                  _buildSkillsSection(context),

                  // About Section
                  _buildAboutSection(),

                  // Experience Section
                  _buildExperienceSection(context),

                  // Milestones Section (New)
                  _buildMilestonesSection(context),

                  // Action Buttons
                  _buildActionButtons(context, isSmallScreen),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompactProfileHeader(BuildContext context, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 20 : 30),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Photo
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: isSmallScreen ? 40 : 60,
              backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80",
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Name and Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Prashant S.",
                      style: TextStyle(
                        fontSize: isSmallScreen ? 20 : 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Color(0xFF66B2FF).withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Boosted",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? 10 : 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  "Salesforce Architect | HubSpot Expert",
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    color: Color(0xFF424242),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    Icon(Icons.location_on, size: isSmallScreen ? 14 : 16, color: Color(0xFF616161)),
                    SizedBox(width: 4),
                    Text(
                      "Mumbai, India",
                      style: TextStyle(
                          fontSize: isSmallScreen ? 12 : 14,
                          color: Color(0xFF616161)
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Availability Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle, size: 6, color: Colors.green),
                      SizedBox(width: 4),
                      Text(
                        "Available now",
                        style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen ? 10 : 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
      child: Container(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(context, "\$17/hr", "Rate", isSmallScreen),
            _buildStatItem(context, "100%", "Job Success", isSmallScreen),
            _buildStatItem(context, "\$60K+", "Earned", isSmallScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label, bool isSmallScreen) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: isSmallScreen ? 16 : 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1976D2),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: isSmallScreen ? 11 : 13,
            color: Color(0xFF616161),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 600;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 16 : 24,
            vertical: isSmallScreen ? 0 : 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Skills & Expertise",
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1976D2),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _buildSkillChip(context, "API Integration", isSmallScreen),
                  _buildSkillChip(context, "Database Architecture", isSmallScreen),
                  _buildSkillChip(context, "DevOps", isSmallScreen),
                  _buildSkillChip(context, "Salesforce Service Cloud", isSmallScreen),
                  _buildSkillChip(context, "Salesforce CPQ", isSmallScreen),
                  _buildSkillChip(context, "HubSpot CRM", isSmallScreen),
                  _buildSkillChip(context, "Flutter Development", isSmallScreen),
                  _buildSkillChip(context, "+5 more", isSmallScreen),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSkillChip(BuildContext context, String text, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 10 : 12,
        vertical: isSmallScreen ? 6 : 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isSmallScreen ? 11 : 13,
          color: Color(0xFF1976D2),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 600;

        return Padding(
          padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About Me",
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1976D2),
                ),
              ),
              SizedBox(height: isSmallScreen ? 8 : 12),
              Text(
                "Certified Salesforce Developer, Consultant, and Business Analyst with over 10 years of experience in delivering robust CRM solutions. Specialized in Salesforce implementations, integrations, and custom development.",
                style: TextStyle(
                  fontSize: isSmallScreen ? 13 : 15,
                  color: Color(0xFF424242),
                  height: 1.4,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExperienceSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 600;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 16 : 24,
            vertical: isSmallScreen ? 0 : 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Experience",
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1976D2),
                ),
              ),
              SizedBox(height: isSmallScreen ? 10 : 12),
              Row(
                children: [
                  Container(
                    width: isSmallScreen ? 36 : 44,
                    height: isSmallScreen ? 36 : 44,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.business,
                      color: Color(0xFF1976D2),
                      size: isSmallScreen ? 18 : 22,
                    ),
                  ),
                  SizedBox(width: isSmallScreen ? 10 : 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Audentes Technologies",
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF212121),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Senior Salesforce Architect",
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12 : 14,
                            color: Color(0xFF424242),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "\$50K+ earned • 5+ years",
                          style: TextStyle(
                            fontSize: isSmallScreen ? 11 : 13,
                            color: Color(0xFF616161),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMilestonesSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 600;

        return Padding(
          padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Project Milestones",
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1976D2),
                ),
              ),
              SizedBox(height: isSmallScreen ? 12 : 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMilestoneItem(
                      context,
                      "Project Setup & Planning",
                      "\$150",
                      "Completed",
                      Icons.check_circle,
                      Colors.green[800]!,
                      isSmallScreen,
                    ),
                    _buildMilestoneItem(
                      context,
                      "UI/UX Design Implementation",
                      "\$250",
                      "In Progress",
                      Icons.autorenew,
                      Colors.orange[800]!,
                      isSmallScreen,
                    ),
                    _buildMilestoneItem(
                      context,
                      "Backend Development",
                      "\$350",
                      "Pending",
                      Icons.schedule,
                      Colors.grey[700]!,
                      isSmallScreen,
                    ),
                    _buildMilestoneItem(
                      context,
                      "Testing & Deployment",
                      "\$250",
                      "Pending",
                      Icons.schedule,
                      Colors.grey[700]!,
                      isSmallScreen,
                    ),
                  ],
                ),
              ),
              SizedBox(height: isSmallScreen ? 8 : 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Budget: \$1,000",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1976D2),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 12 : 16,
                      vertical: isSmallScreen ? 6 : 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      "40% Completed",
                      style: TextStyle(
                        fontSize: isSmallScreen ? 12 : 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMilestoneItem(
      BuildContext context,
      String title,
      String amount,
      String status,
      IconData icon,
      Color statusColor,
      bool isSmallScreen
      ) {
    return Padding(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      child: Row(
        children: [
          Container(
            width: isSmallScreen ? 40 : 48,
            height: isSmallScreen ? 40 : 48,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.flag,
              color: Color(0xFF1976D2),
              size: isSmallScreen ? 20 : 24,
            ),
          ),
          SizedBox(width: isSmallScreen ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF212121),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1976D2),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: isSmallScreen ? 16 : 18,
                    color: statusColor,
                  ),
                  SizedBox(width: 4),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w500,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              if (status == "In Progress")
                SizedBox(
                  width: isSmallScreen ? 80 : 100,
                  child: LinearProgressIndicator(
                    value: 0.7,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF1976D2),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

SizedBox(
    width: isSmallScreen ? 120 : 130, // button width
    height: 38,

            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkroomChatScreen(
                      roomId: "room1",
                      currentUser: "client_id",
                      otherUser: "freelancer_id",
                    ),
                  ),
                );
              },
              icon: Icon(Icons.message, size: isSmallScreen ? 14 : 16),
              label: Text(
                "Message",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 14 : 16
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1976D2),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 8 : 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
               // height fix
              ),
    ),
          ),
          SizedBox(width: isSmallScreen ? 12 : 16),
        SizedBox(
          width: isSmallScreen ? 120 : 130, // button width
          height: 38,

            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Invite sent successfully!")),
                );
              },
              icon: Icon(Icons.work, size: isSmallScreen ? 18 : 20),
              label: Text(
                "Hire Now",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 14 : 16
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Color(0xFF1976D2),
                side: BorderSide(color: Color(0xFF1976D2)),
                padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 14 : 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Chat Screen with responsive improvements
class WorkroomChatScreen extends StatefulWidget {
  final String roomId;
  final String currentUser;
  final String otherUser;

  const WorkroomChatScreen({
    required this.roomId,
    required this.currentUser,
    required this.otherUser,
    Key? key,
  }) : super(key: key);

  @override
  _WorkroomChatScreenState createState() => _WorkroomChatScreenState();
}

class _WorkroomChatScreenState extends State<WorkroomChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    await _firestore
        .collection("chats")
        .doc(widget.roomId)
        .collection("messages")
        .add({
      "sender_id": widget.currentUser,
      "receiver_id": widget.otherUser,
      "message": _controller.text.trim(),
      "timestamp": FieldValue.serverTimestamp(),
    });

    _controller.clear();
  }

  String _formatTime(Timestamp? timestamp) {
    if (timestamp == null) return "";
    DateTime date = timestamp.toDate();
    return DateFormat('hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 600;

        return Scaffold(
          appBar: AppBar(
            title: Text("Chat", style: TextStyle(color: Colors.white)),
            backgroundColor: Color(0xFF1976D2),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection("chats")
                      .doc(widget.roomId)
                      .collection("messages")
                      .orderBy("timestamp", descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    var messages = snapshot.data!.docs;

                    return ListView.builder(
                      padding: EdgeInsets.all(isSmallScreen ? 10 : 20),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        var msg = messages[index];
                        bool isMe = msg["sender_id"] == widget.currentUser;
                        String firstLetter =
                        msg["sender_id"].substring(0, 1).toUpperCase();

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: isMe
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isMe)
                                CircleAvatar(
                                  radius: isSmallScreen ? 14 : 18,
                                  backgroundColor: Color(0xFF1976D2),
                                  child: Text(firstLetter,
                                      style: TextStyle(
                                          fontSize: isSmallScreen ? 14 : 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              if (!isMe) SizedBox(width: 6),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.all(isSmallScreen ? 10 : 14),
                                  decoration: BoxDecoration(
                                    color: isMe
                                        ? Color(0xFF1976D2).withOpacity(0.2)
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: isMe
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        msg["message"],
                                        style: TextStyle(
                                          fontSize: isSmallScreen ? 16 : 18,
                                          color: Color(0xFF212121),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        _formatTime(msg["timestamp"]),
                                        style: TextStyle(
                                          fontSize: isSmallScreen ? 10 : 12,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (isMe) SizedBox(width: 6),
                              if (isMe)
                                CircleAvatar(
                                  radius: isSmallScreen ? 14 : 18,
                                  backgroundColor: Color(0xFF1976D2),
                                  child: Text(firstLetter,
                                      style: TextStyle(
                                          fontSize: isSmallScreen ? 14 : 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Divider(height: 1),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 8 : 16,
                    vertical: isSmallScreen ? 4 : 8
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Type a message...",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 12 : 16,
                              vertical: isSmallScreen ? 8 : 12
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send,
                        color: Color(0xFF1976D2),
                        size: isSmallScreen ? 24 : 28,
                      ),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
