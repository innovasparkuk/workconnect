import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:workroom/profile_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileSetupApp(),
      theme: ThemeData(
        primaryColor: Color(0xFF66B2FF),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFF66B2FF).withOpacity(0.8),
        ),
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          // Define darker text colors for better visibility
          bodyMedium: TextStyle(color: Color(0xFF424242)), // Dark gray instead of default
          bodySmall: TextStyle(color: Color(0xFF616161)), // Medium gray
          titleMedium: TextStyle(color: Color(0xFF212121)), // Very dark gray
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Freelancer Profile",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header with Photo and Name side by side
            _buildCompactProfileHeader(context),

            // Stats Section
            _buildStatsSection(context),

            // Skills Section
            _buildSkillsSection(context),

            // About Section
            _buildAboutSection(),

            // Experience Section
            _buildExperienceSection(context),

            // Milestones Section (New)
            _buildMilestonesSection(context),

            // Action Buttons
            _buildActionButtons(context),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
              radius: 40,
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2), // Darker blue for better contrast
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
                      child: const Text(
                        "Boosted",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
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
                    fontSize: 14,
                    color: Color(0xFF424242), // Darker gray
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Color(0xFF616161)), // Darker icon
                    SizedBox(width: 4),
                    Text(
                      "Mumbai, India",
                      style: TextStyle(fontSize: 12, color: Color(0xFF616161)), // Darker text
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
                          color: Colors.green[800], // Darker green
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
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

  Widget _buildStatsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
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
            _buildStatItem(context, "\$17/hr", "Rate"),
            _buildStatItem(context, "100%", "Job Success"),
            _buildStatItem(context, "\$60K+", "Earned"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1976D2), // Darker blue
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF616161), // Darker gray
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Skills & Expertise",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1976D2), // Darker blue
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _buildSkillChip(context, "API Integration"),
              _buildSkillChip(context, "Database Architecture"),
              _buildSkillChip(context, "DevOps"),
              _buildSkillChip(context, "Salesforce Service Cloud"),
              _buildSkillChip(context, "Salesforce CPQ"),
              _buildSkillChip(context, "HubSpot CRM"),
              _buildSkillChip(context, "Flutter Development"),
              _buildSkillChip(context, "+5 more"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: Color(0xFF1976D2), // Darker blue
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About Me",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1976D2), // Darker blue
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Certified Salesforce Developer, Consultant, and Business Analyst with over 10 years of experience in delivering robust CRM solutions. Specialized in Salesforce implementations, integrations, and custom development.",
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF424242), // Darker gray
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Experience",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1976D2), // Darker blue
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.business,
                  color: Color(0xFF1976D2), // Darker blue
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Audentes Technologies",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF212121), // Darker text
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Senior Salesforce Architect",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF424242), // Darker gray
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "\$50K+ earned • 5+ years",
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF616161), // Darker gray
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
  }

  Widget _buildMilestonesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Project Milestones",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1976D2), // Darker blue
            ),
          ),
          SizedBox(height: 12),
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
                  Colors.green[800]!, // Darker green
                ),
                _buildMilestoneItem(
                  context,
                  "UI/UX Design Implementation",
                  "\$250",
                  "In Progress",
                  Icons.autorenew,
                  Colors.orange[800]!, // Darker orange
                ),
                _buildMilestoneItem(
                  context,
                  "Backend Development",
                  "\$350",
                  "Pending",
                  Icons.schedule,
                  Colors.grey[700]!, // Darker gray
                ),
                _buildMilestoneItem(
                  context,
                  "Testing & Deployment",
                  "\$250",
                  "Pending",
                  Icons.schedule,
                  Colors.grey[700]!, // Darker gray
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Budget: \$1,000",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1976D2), // Darker blue
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "40% Completed",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800], // Darker green
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneItem(BuildContext context, String title, String amount,
      String status, IconData icon, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.flag,
              color: Color(0xFF1976D2), // Darker blue
              size: 20,
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
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF212121), // Darker text
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1976D2), // Darker blue
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
                    size: 16,
                    color: statusColor,
                  ),
                  SizedBox(width: 4),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              if (status == "In Progress")
                SizedBox(
                  width: 80,
                  child: LinearProgressIndicator(
                    value: 0.7,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF1976D2), // Darker blue
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
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
              icon: Icon(Icons.message, size: 18),
              label: Text(
                "Message",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1976D2), // Darker blue
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Invite sent successfully!")),
                );
              },
              icon: Icon(Icons.work, size: 18),
              label: Text(
                "Hire Now",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Color(0xFF1976D2), // Darker blue
                side: BorderSide(color: Color(0xFF1976D2)), // Darker blue
                padding: EdgeInsets.symmetric(vertical: 14),
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

// Chat Screen with blue theme (keep your existing implementation)
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF1976D2), // Darker blue
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
                  padding: EdgeInsets.all(10),
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
                              radius: 14,
                              backgroundColor: Color(0xFF1976D2), // Darker blue
                              child: Text(firstLetter,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          if (!isMe) SizedBox(width: 6),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? Color(0xFF1976D2).withOpacity(0.2) // Darker blue
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
                                      fontSize: 16,
                                      color: Color(0xFF212121), // Darker text
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    _formatTime(msg["timestamp"]),
                                    style: TextStyle(
                                      fontSize: 10,
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
                              radius: 14,
                              backgroundColor: Color(0xFF1976D2), // Darker blue
                              child: Text(firstLetter,
                                  style: TextStyle(
                                      fontSize: 14,
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
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Color(0xFF1976D2)), // Darker blue
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}