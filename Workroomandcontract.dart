import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

// ══════════════════════════════════════════════════════════════
//  THEME COLORS
// ══════════════════════════════════════════════════════════════
const Color _primaryColor = Color(0xFF66B2FF);
const Color _successGreen = Color(0xFF2ECC71);
const Color _darkBg = Color(0xFFF5F7FA);
const Color _textMuted = Color(0xFF6B7280);
const Color _textLight = Color(0xFF1F2937);
const Color _cardBg = Color(0xFFFFFFFF);

LinearGradient get _mainGradient => const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF2ECC71), Color(0xFF66B2FF)],
);

const LinearGradient _btnGradient = LinearGradient(
  colors: [Color(0xFF2ECC71), Color(0xFF66B2FF)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color _green = Color(0xFF2ECC71);
const Color _blue = Color(0xFF66B2FF);

// ══════════════════════════════════════════════════════════════
//  MODELS
// ══════════════════════════════════════════════════════════════
enum MsgType { text, audio, file }
enum FileKind { pdf, word, image, zip, other }

class ChatMsg {
  final String id;
  final String text;
  final bool isMe;
  final String time;
  final MsgType type;
  final FileKind? fileKind;
  final String? fileName;
  final int? audioDuration;
  bool isPinned;
  bool isDeleted;
  Map<String, int> reactions;

  ChatMsg({
    required this.id,
    required this.text,
    required this.isMe,
    required this.time,
    this.type = MsgType.text,
    this.fileKind,
    this.fileName,
    this.audioDuration,
    this.isPinned = false,
    this.isDeleted = false,
    Map<String, int>? reactions,
  }) : reactions = reactions ?? {};
}

class Milestone {
  final String id;
  final String title;
  final String description;
  double progress;
  String status;
  final double funds;
  final String dateLabel;
  final List<String> deliverables;
  final List<String> files;
  String? feedback;
  List<String> tags;

  Milestone({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.status,
    required this.funds,
    required this.dateLabel,
    required this.deliverables,
    required this.files,
    this.feedback,
    List<String>? tags,
  }) : tags = tags ?? [];
}

class ProjectFile {
  final String id, name, size, uploadedBy, url;
  final FileKind kind;
  final DateTime uploadDate;

  ProjectFile({
    required this.id,
    required this.name,
    required this.kind,
    required this.size,
    required this.uploadedBy,
    required this.uploadDate,
    required this.url,
  });
}

class ChatContact {
  final String name;
  final String role;
  final bool isOnline;
  final String avatar;
  const ChatContact({
    required this.name,
    required this.role,
    required this.isOnline,
    required this.avatar,
  });
}

// ══════════════════════════════════════════════════════════════
//  MAIN APP
// ══════════════════════════════════════════════════════════════
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const WorkroomApp());
}

class WorkroomApp extends StatelessWidget {
  const WorkroomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Premium Workroom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: _primaryColor,
        scaffoldBackgroundColor: _darkBg,
      ),
      home: const WorkroomHome(),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  HOME
// ══════════════════════════════════════════════════════════════
class WorkroomHome extends StatefulWidget {
  const WorkroomHome({super.key});

  @override
  State<WorkroomHome> createState() => _WorkroomHomeState();
}

class _WorkroomHomeState extends State<WorkroomHome> with TickerProviderStateMixin {
  int _tab = 0;
  late AnimationController _pulseController;
  late AnimationController _slideController;

  List<Milestone> _milestones = [];
  List<ProjectFile> _projectFiles = [];
  List<ChatMsg> _chatMessages = [];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _slideController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _loadData();
  }

  void _loadData() {
    _milestones = _defaultMilestones();
    _projectFiles = _defaultFiles();
    _chatMessages = _defaultMessages();
  }

  List<Milestone> _defaultMilestones() => [
    Milestone(
      id: 'm1', title: 'UI Design',
      description: 'High-fidelity designs & component library',
      progress: 1.0, status: 'completed', funds: 800,
      dateLabel: 'Released Mar 15',
      deliverables: ['User Flows', 'Wireframes', 'IA Map', 'Style Guide'],
      files: ['user-flows.fig', 'research.pdf', 'wireframes.jpg'],
      tags: ['Design', 'Frontend'],
    ),
    Milestone(
      id: 'm2', title: 'API Development',
      description: 'Backend APIs & database integration',
      progress: 0.6, status: 'review', funds: 1200,
      dateLabel: 'Submitted 2 days ago',
      deliverables: ['REST APIs', 'DB Schema', 'Auth System'],
      files: ['api-docs.pdf', 'postman.json', 'db-schema.png'],
      feedback: 'Colors look good, but let\'s adjust the typography spacing.',
      tags: ['Backend', 'API'],
    ),
    Milestone(
      id: 'm3', title: 'Testing & QA',
      description: 'Quality assurance & bug fixes',
      progress: 0.2, status: 'active', funds: 1250,
      dateLabel: 'Starts in 3 days',
      deliverables: ['Test Cases', 'Bug Reports', 'Performance Report'],
      files: ['test-plan.pdf'],
      tags: ['QA', 'Testing'],
    ),
    Milestone(
      id: 'm4', title: 'Deployment',
      description: 'Production deployment & monitoring',
      progress: 0.0, status: 'locked', funds: 1400,
      dateLabel: 'Est. April 5, 2024',
      deliverables: ['CI/CD Pipeline', 'Monitoring', 'Docs'],
      files: [],
      tags: ['DevOps'],
    ),
  ];

  List<ProjectFile> _defaultFiles() => [
    ProjectFile(id: 'f1', name: 'user-flows.fig', kind: FileKind.other, size: '2.4 MB', uploadedBy: 'Sarah', uploadDate: DateTime.now().subtract(const Duration(days: 3)), url: ''),
    ProjectFile(id: 'f2', name: 'research.pdf', kind: FileKind.pdf, size: '1.2 MB', uploadedBy: 'Alex', uploadDate: DateTime.now().subtract(const Duration(days: 5)), url: ''),
    ProjectFile(id: 'f3', name: 'wireframes.jpg', kind: FileKind.image, size: '3.7 MB', uploadedBy: 'Sarah', uploadDate: DateTime.now().subtract(const Duration(days: 2)), url: ''),
    ProjectFile(id: 'f4', name: 'api-docs.pdf', kind: FileKind.pdf, size: '856 KB', uploadedBy: 'Mike', uploadDate: DateTime.now().subtract(const Duration(days: 1)), url: ''),
  ];

  List<ChatMsg> _defaultMessages() => [
    ChatMsg(id: 'def1', text: 'Hey! How is the API development going?', isMe: false, time: '10:30 AM'),
    ChatMsg(id: 'def2', text: 'Going great! Just finished the auth module. Working on payment gateway now 🚀', isMe: true, time: '10:32 AM'),
    ChatMsg(id: 'def3', text: 'Awesome! Can you share the Postman collection?', isMe: false, time: '10:35 AM'),
    ChatMsg(id: 'def4', text: 'Sure, attaching it now!', isMe: true, time: '10:36 AM'),
    ChatMsg(id: 'def5', text: 'postman-collection.json', isMe: true, time: '10:36 AM', type: MsgType.file, fileKind: FileKind.other, fileName: 'postman-collection.json'),
    ChatMsg(id: 'def6', text: 'Perfect! When can we expect the checkout flow?', isMe: false, time: '10:45 AM'),
    ChatMsg(id: 'def7', text: 'Working on it! Will submit by EOD 👍', isMe: true, time: '11:45 AM'),
  ];

  void _addMilestone(Milestone milestone) {
    setState(() => _milestones.add(milestone));
  }

  void _onFileUploaded(ProjectFile file) {
    setState(() => _projectFiles.add(file));
  }

  void _deleteFile(ProjectFile file) {
    setState(() => _projectFiles.remove(file));
  }

  void _addChatMessage(ChatMsg msg) {
    setState(() => _chatMessages.add(msg));
  }

  void _deleteChatMessage(String msgId) {
    setState(() => _chatMessages.removeWhere((m) => m.id == msgId));
  }

  void _pinChatMessage(String msgId, bool isPinned) {
    setState(() {
      final index = _chatMessages.indexWhere((m) => m.id == msgId);
      if (index != -1) {
        _chatMessages[index].isPinned = isPinned;
      }
    });
  }

  void _addReaction(String msgId, String emoji) {
    setState(() {
      final index = _chatMessages.indexWhere((m) => m.id == msgId);
      if (index != -1) {
        _chatMessages[index].reactions[emoji] = (_chatMessages[index].reactions[emoji] ?? 0) + 1;
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 10),
                _buildTopNav(),
                const SizedBox(height: 10),
                Expanded(
                  child: _buildContent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.fromLTRB(14, 12, 14, 0),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),  // vertical 18 se 24 kar diya
      decoration: BoxDecoration(
        gradient: _mainGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56, height: 56,  // 50 se 56 kar diya
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.work_outline, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'E-Commerce Website Redesign',
                  style: TextStyle(
                    fontSize: 17,  // 15 se 17 kar diya
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      width: 8, height: 8,  // 6 se 8 kar diya
                      decoration: const BoxDecoration(color: _green, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Private Workroom',
                      style: TextStyle(fontSize: 12, color: Colors.white70),  // 11 se 12 kar diya
                    ),
                  ],
                ),
              ],
            ),
          ),
          _animatedAvatar('S', 'Sarah'),
          const SizedBox(width: 8),
          _animatedAvatar('A', 'Alex'),
        ],
      ),
    );
  }

  Widget _animatedAvatar(String initial, String name) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) => Transform.scale(
        scale: 0.9 + value * 0.1,
        child: Container(
          padding: const EdgeInsets.fromLTRB(6, 6, 14, 6),  // padding barha diya
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 34, height: 34,  // 28 se 34 kar diya
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    initial,
                    style: const TextStyle(
                      color: _primaryColor,
                      fontSize: 14,  // 12 se 14 kar diya
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,  // 12 se 13 kar diya
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_tab) {
      case 0:
        return _HomeOverview(
          milestones: _milestones,
          onViewDashboard: () => setState(() => _tab = 2),
          pulseController: _pulseController,
        );
      case 1:
        return ChatPage(
          contact: const ChatContact(
            name: 'Alex Morgan',
            role: 'Client',
            isOnline: true,
            avatar: 'A',
          ),
          messages: _chatMessages,
          onSendMessage: _addChatMessage,
          onDeleteMessage: _deleteChatMessage,
          onPinMessage: _pinChatMessage,
          onAddReaction: _addReaction,
          onFileUploaded: _onFileUploaded,
        );
      case 2:
        return MilestoneDashboard(
          milestones: _milestones,
          onAddMilestone: _addMilestone,
          allFiles: _projectFiles,
          onFileUploaded: _onFileUploaded,
        );
      case 3:
        return FilesPage(
          files: _projectFiles,
          onDeleteFile: _deleteFile,
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildTopNav() {
    final tabs = [
      {'icon': Icons.dashboard_rounded, 'label': 'HOME'},
      {'icon': Icons.chat_bubble_rounded, 'label': 'CHAT'},
      {'icon': Icons.flag_rounded, 'label': 'MILESTONES'},
      {'icon': Icons.folder_rounded, 'label': 'FILES'},
    ];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final active = _tab == i;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _tab = i);
                _slideController.forward(from: 0);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  gradient: active ? _btnGradient : null,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: active
                      ? [BoxShadow(color: _successGreen.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2))]
                      : null,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      tabs[i]['icon'] as IconData,
                      color: active ? Colors.white : _textMuted,
                      size: 20,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tabs[i]['label'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: active ? Colors.white : _textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  HOME OVERVIEW
// ══════════════════════════════════════════════════════════════
class _HomeOverview extends StatelessWidget {
  final List<Milestone> milestones;
  final VoidCallback onViewDashboard;
  final AnimationController pulseController;

  const _HomeOverview({
    required this.milestones,
    required this.onViewDashboard,
    required this.pulseController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _cardBg,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.attach_money_rounded,
                        title: 'Total Budget',
                        value: '\$5,000',
                        color: _successGreen,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.trending_up_rounded,
                        title: 'Progress',
                        value: '60%',
                        color: _primaryColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.people_rounded,
                        title: 'Team',
                        value: '4',
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _darkBg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Project Status',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _textLight),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: _successGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'In Progress',
                              style: TextStyle(fontSize: 11, color: _successGreen, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          value: 0.6,
                          backgroundColor: const Color(0xFFE5E7EB),
                          valueColor: const AlwaysStoppedAnimation(_successGreen),
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: _primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.flag_rounded, color: _primaryColor, size: 18),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'MILESTONES',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1, color: _textMuted),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        gradient: _btnGradient,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '3/4 Complete',
                        style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...milestones.map((m) => _MilestonePreview(milestone: m)),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: onViewDashboard,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      gradient: _btnGradient,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text(
                        'View Dashboard →',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
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
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _darkBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(fontSize: 11, color: _textMuted),
          ),
        ],
      ),
    );
  }
}

class _MilestonePreview extends StatelessWidget {
  final Milestone milestone;

  const _MilestonePreview({required this.milestone});

  Color get _statusColor {
    switch (milestone.status) {
      case 'completed': return _successGreen;
      case 'review': return _primaryColor;
      case 'active': return Colors.orange;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _statusColor;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                milestone.title,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _textLight),
              ),
              Text(
                '${(milestone.progress * 100).toInt()}%',
                style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: milestone.progress,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  CHAT PAGE
// ══════════════════════════════════════════════════════════════
class ChatPage extends StatefulWidget {
  final ChatContact contact;
  final List<ChatMsg> messages;
  final Function(ChatMsg) onSendMessage;
  final Function(String) onDeleteMessage;
  final Function(String, bool) onPinMessage;
  final Function(String, String) onAddReaction;
  final Function(ProjectFile) onFileUploaded;

  const ChatPage({
    super.key,
    required this.contact,
    required this.messages,
    required this.onSendMessage,
    required this.onDeleteMessage,
    required this.onPinMessage,
    required this.onAddReaction,
    required this.onFileUploaded,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();

  String get _now {
    final t = DateTime.now();
    final h = t.hour > 12 ? t.hour - 12 : (t.hour == 0 ? 12 : t.hour);
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m ${t.hour >= 12 ? "PM" : "AM"}';
  }

  void _send(String text) {
    if (text.trim().isEmpty) return;
    final newMsg = ChatMsg(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text.trim(),
      isMe: true,
      time: _now,
    );
    widget.onSendMessage(newMsg);
    _textCtrl.clear();
    _scrollDown();
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 4))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            _buildChatHeader(),
            Expanded(
              child: Container(
                color: _darkBg,
                child: ListView.builder(
                  controller: _scrollCtrl,
                  padding: const EdgeInsets.all(16),
                  itemCount: widget.messages.length,
                  itemBuilder: (_, i) => _buildBubble(widget.messages[i]),
                ),
              ),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: _btnGradient,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 45, height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                widget.contact.avatar,
                style: const TextStyle(
                  color: _primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.contact.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 8, height: 8,
                      decoration: const BoxDecoration(color: _successGreen, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Online',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _cardBg,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: _darkBg,
                borderRadius: BorderRadius.circular(22),
              ),
              child: TextField(
                controller: _textCtrl,
                style: const TextStyle(fontSize: 14, color: _textLight),
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(fontSize: 13, color: _textMuted),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onSubmitted: _send,
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => _send(_textCtrl.text),
            child: Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                gradient: _btnGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(ChatMsg msg) {
    return Align(
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
        decoration: BoxDecoration(
          gradient: msg.isMe ? _btnGradient : null,
          color: msg.isMe ? null : _cardBg,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(msg.isMe ? 16 : 4),
            bottomRight: Radius.circular(msg.isMe ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              msg.text,
              style: TextStyle(
                fontSize: 14,
                color: msg.isMe ? Colors.white : _textLight,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              msg.time,
              style: TextStyle(
                fontSize: 10,
                color: msg.isMe ? Colors.white70 : _textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  MILESTONE DASHBOARD
// ══════════════════════════════════════════════════════════════
class MilestoneDashboard extends StatefulWidget {
  final List<Milestone> milestones;
  final Function(Milestone) onAddMilestone;
  final List<ProjectFile> allFiles;
  final Function(ProjectFile) onFileUploaded;

  const MilestoneDashboard({
    super.key,
    required this.milestones,
    required this.onAddMilestone,
    required this.allFiles,
    required this.onFileUploaded,
  });

  @override
  State<MilestoneDashboard> createState() => _MilestoneDashboardState();
}

class _MilestoneDashboardState extends State<MilestoneDashboard> {
  double get _overall => widget.milestones.isEmpty ? 0 : widget.milestones.map((m) => m.progress).reduce((a, b) => a + b) / widget.milestones.length;

  Color _statusColor(String s) {
    switch (s) {
      case 'completed': return _successGreen;
      case 'review': return _primaryColor;
      case 'active': return Colors.orange;
      default: return Colors.grey;
    }
  }

  void _updateProgress(Milestone m) {
    setState(() {
      m.progress = (m.progress + 0.2).clamp(0.0, 1.0);
      if (m.progress >= 1.0) m.status = 'completed';
      else if (m.status == 'locked') m.status = 'active';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 4))],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: _btnGradient,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'MILESTONE DASHBOARD',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Website Redesign Project',
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Overall Progress',
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${(_overall * 100).toInt()}%',
                              style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Total Budget',
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '\$4,650',
                              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value: _overall,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ...widget.milestones.map((m) => _buildMilestoneCard(m)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMilestoneCard(Milestone m) {
    final c = _statusColor(m.status);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _darkBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      m.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: _textLight),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      m.description,
                      style: const TextStyle(fontSize: 12, color: _textMuted),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: c.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            m.status.toUpperCase(),
                            style: TextStyle(color: c, fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '\$${m.funds.toInt()}',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _successGreen),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                '${(m.progress * 100).toInt()}%',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: c),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: m.progress,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(c),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 12),
          if (m.status != 'completed')
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _updateProgress(m),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Update Progress'),
              ),
            ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  FILES PAGE
// ══════════════════════════════════════════════════════════════
class FilesPage extends StatelessWidget {
  final List<ProjectFile> files;
  final Function(ProjectFile) onDeleteFile;

  const FilesPage({super.key, required this.files, required this.onDeleteFile});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 4))],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: _btnGradient,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.folder_rounded, color: Colors.white, size: 24),
                  const SizedBox(width: 12),
                  const Text(
                    'Project Files',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    '${files.length} files',
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13),
                  ),
                ],
              ),
            ),
            files.isEmpty
                ? const Padding(
              padding: EdgeInsets.all(40),
              child: Column(
                children: [
                  Icon(Icons.folder_open, size: 64, color: _textMuted),
                  SizedBox(height: 16),
                  Text('No files uploaded yet', style: TextStyle(color: _textMuted)),
                ],
              ),
            )
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: files.length,
              itemBuilder: (_, i) => _buildFileTile(files[i]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileTile(ProjectFile file) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _darkBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.insert_drive_file, color: _primaryColor, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: _textLight),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${file.size} • by ${file.uploadedBy} • ${file.uploadDate.day}/${file.uploadDate.month}',
                  style: const TextStyle(color: _textMuted, fontSize: 11),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => onDeleteFile(file),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}