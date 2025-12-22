import 'package:flutter/material.dart';

void main() {
  runApp(DisputeManagementApp());
}

class DisputeManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dispute Management',
      theme: ThemeData(
        primaryColor: Color(0xFF0066FF),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF0066FF),
          secondary: Color(0xFF00C853),
          background: Colors.white,
          surface: Colors.white,
        ),
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF1A1A1A),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF666666),
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      home: DisputeManagementDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DisputeManagementDashboard extends StatefulWidget {
  @override
  _DisputeManagementDashboardState createState() =>
      _DisputeManagementDashboardState();
}

class _DisputeManagementDashboardState
    extends State<DisputeManagementDashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Dispute Management',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStatsSection(),
          Expanded(
            child: _selectedIndex == 0
                ? DisputeCasesList()
                : ResolutionCenter(), // Empty resolution center for bottom nav
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('24', 'Open Cases', Icons.warning_amber),
          _buildStatItem('12', 'In Progress', Icons.schedule),
          _buildStatItem('48', 'Resolved', Icons.check_circle),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 24,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Color(0xFF666666),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Dispute Cases',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Resolution Center',
          ),
        ],
      ),
    );
  }
}

class DisputeCasesList extends StatelessWidget {
  final List<DisputeCase> disputeCases = [
    DisputeCase(
      id: 'D-2023-001',
      title: 'Website not delivered as agreed',
      client: 'John Smith',
      freelancer: 'Sarah Johnson',
      amount: 1200.00,
      status: DisputeStatus.open,
      date: DateTime.now().subtract(Duration(days: 2)),
      priority: Priority.high,
    ),
    DisputeCase(
      id: 'D-2023-002',
      title: 'Logo design quality issues',
      client: 'Tech Solutions Inc.',
      freelancer: 'Design Pro',
      amount: 450.00,
      status: DisputeStatus.inProgress,
      date: DateTime.now().subtract(Duration(days: 5)),
      priority: Priority.medium,
    ),
    DisputeCase(
      id: 'D-2023-003',
      title: 'Payment not released after completion',
      client: 'Marketing Agency',
      freelancer: 'Content Writer',
      amount: 800.00,
      status: DisputeStatus.resolved,
      date: DateTime.now().subtract(Duration(days: 10)),
      priority: Priority.low,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: disputeCases.length,
      itemBuilder: (context, index) {
        return DisputeCaseCard(disputeCase: disputeCases[index]);
      },
    );
  }
}

class DisputeCaseCard extends StatelessWidget {
  final DisputeCase disputeCase;

  const DisputeCaseCard({Key? key, required this.disputeCase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getPriorityColor(disputeCase.priority)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _getPriorityText(disputeCase.priority),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getPriorityColor(disputeCase.priority),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(context, disputeCase.status)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _getStatusText(disputeCase.status),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(context, disputeCase.status),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        disputeCase.title,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      // FIXED: Overflow issue - Use Column instead of Row for small screens
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 400) {
                            // For larger screens - Row layout
                            return Row(
                              children: [
                                Icon(
                                  Icons.person_outline,
                                  size: 16,
                                  color: Color(0xFF666666),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Client: ${disputeCase.client}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                SizedBox(width: 16),
                                Icon(
                                  Icons.work_outline,
                                  size: 16,
                                  color: Color(0xFF666666),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Freelancer: ${disputeCase.freelancer}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            );
                          } else {
                            // For smaller screens - Column layout
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person_outline,
                                      size: 16,
                                      color: Color(0xFF666666),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Client: ${disputeCase.client}',
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.work_outline,
                                      size: 16,
                                      color: Color(0xFF666666),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Freelancer: ${disputeCase.freelancer}',
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${disputeCase.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      disputeCase.id,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF666666),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${disputeCase.date.day}/${disputeCase.date.month}/${disputeCase.date.year}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[200],
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'VIEW DETAILS',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResolutionCenterPage(
                          disputeCase: disputeCase,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'RESOLVE NOW',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.high:
        return Colors.red;
      case Priority.medium:
        return Colors.orange;
      case Priority.low:
        return Colors.green;
    }
  }

  String _getPriorityText(Priority priority) {
    switch (priority) {
      case Priority.high:
        return 'HIGH PRIORITY';
      case Priority.medium:
        return 'MEDIUM PRIORITY';
      case Priority.low:
        return 'LOW PRIORITY';
    }
  }

  Color _getStatusColor(BuildContext context, DisputeStatus status) {
    switch (status) {
      case DisputeStatus.open:
        return Colors.orange;
      case DisputeStatus.inProgress:
        return Theme.of(context).primaryColor;
      case DisputeStatus.resolved:
        return Theme.of(context).colorScheme.secondary;
    }
  }

  String _getStatusText(DisputeStatus status) {
    switch (status) {
      case DisputeStatus.open:
        return 'OPEN';
      case DisputeStatus.inProgress:
        return 'IN PROGRESS';
      case DisputeStatus.resolved:
        return 'RESOLVED';
    }
  }
}

// New Page for Resolution Center with specific case
class ResolutionCenterPage extends StatelessWidget {
  final DisputeCase disputeCase;

  const ResolutionCenterPage({Key? key, required this.disputeCase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resolution Center',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ResolutionCenter(disputeCase: disputeCase),
    );
  }
}

class ResolutionCenter extends StatefulWidget {
  final DisputeCase? disputeCase;

  const ResolutionCenter({Key? key, this.disputeCase}) : super(key: key);

  @override
  _ResolutionCenterState createState() => _ResolutionCenterState();
}

class _ResolutionCenterState extends State<ResolutionCenter> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: 'Hello, I\'m having issues with the delivered website.',
      isClient: true,
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
    ),
    ChatMessage(
      text: 'Can you please specify what exactly is not working as expected?',
      isClient: false,
      timestamp: DateTime.now().subtract(Duration(hours: 1, minutes: 45)),
    ),
    ChatMessage(
      text: 'The contact form is not sending emails, and the mobile layout is broken.',
      isClient: true,
      timestamp: DateTime.now().subtract(Duration(hours: 1, minutes: 30)),
    ),
    ChatMessage(
      text: 'I see. Let me check the code and fix these issues.',
      isClient: false,
      timestamp: DateTime.now().subtract(Duration(hours: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.disputeCase != null) _buildCaseHeader(context),
        Expanded(
          child: Container(
            color: Colors.grey[50],
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    reverse: false, // Changed to false for proper order
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return ChatBubble(message: message);
                    },
                  ),
                ),
                _buildMessageInput(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCaseHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Icon(
              Icons.gavel,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.disputeCase?.title ?? 'Dispute Resolution',
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  'Case ID: ${widget.disputeCase?.id ?? 'N/A'}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Color(0xFF666666)),
            onSelected: (value) {
              // Handle menu item selection
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'details',
                child: Text('Case Details'),
              ),
              PopupMenuItem<String>(
                value: 'docs',
                child: Text('View Documents'),
              ),
              PopupMenuItem<String>(
                value: 'history',
                child: Text('Case History'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: () {
                if (_messageController.text.isNotEmpty) {
                  setState(() {
                    _messages.add(ChatMessage(
                      text: _messageController.text,
                      isClient: true,
                      timestamp: DateTime.now(),
                    ));
                    _messageController.clear();
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
        message.isClient ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isClient)
            Container(
              margin: EdgeInsets.only(right: 8),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  size: 16,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isClient
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: message.isClient ? Colors.white : Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${_formatTime(message.timestamp)}',
                    style: TextStyle(
                      fontSize: 10,
                      color: message.isClient
                          ? Colors.white70
                          : Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isClient)
            Container(
              margin: EdgeInsets.only(left: 8),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  size: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}

// Data Models
enum DisputeStatus { open, inProgress, resolved }
enum Priority { high, medium, low }

class DisputeCase {
  final String id;
  final String title;
  final String client;
  final String freelancer;
  final double amount;
  final DisputeStatus status;
  final DateTime date;
  final Priority priority;

  DisputeCase({
    required this.id,
    required this.title,
    required this.client,
    required this.freelancer,
    required this.amount,
    required this.status,
    required this.date,
    required this.priority,
  });
}

class ChatMessage {
  final String text;
  final bool isClient;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isClient,
    required this.timestamp, 
  });
}