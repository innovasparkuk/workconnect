import 'package:flutter/material.dart';

class ContractWorkroomPage extends StatefulWidget {
  @override
  _ContractWorkroomPageState createState() => _ContractWorkroomPageState();
}

class _ContractWorkroomPageState extends State<ContractWorkroomPage> {
  int _selectedIndex = 0;
  bool _showManualForm = false;
  bool _showAutoForm = false;
  String _currentContractTab = 'active';
  bool _showGeneratedContract = false;
  String _selectedPaymentFrequency = 'Per Hour';

  // Form controllers
  TextEditingController _projectTitleController = TextEditingController();
  TextEditingController _projectScopeController = TextEditingController();
  TextEditingController _paymentTermsController = TextEditingController();
  TextEditingController _revisionsController = TextEditingController();
  TextEditingController _keywordController = TextEditingController();
  TextEditingController _workingHoursController = TextEditingController();
  TextEditingController _workingDaysController = TextEditingController();
  TextEditingController _deadlineController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  // Contract lists
  List<Contract> _activeContracts = [];
  List<Contract> _pendingContracts = [];
  List<Contract> _completedContracts = [];

  // Work Room data
  List<WorkRoom> _workRooms = [];
  Map<String, List<WorkUpdate>> _workUpdates = {};
  Map<String, List<ChatMessage>> _workRoomChats = {};

  // Payment frequency options
  List<String> _paymentFrequencyOptions = [
    'Per Hour',
    'Per Day',
    'Per Week',
    'Per Month',
    'Fixed Price'
  ];

  static String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }

  static String _getCurrentDate() {
    final now = DateTime.now();
    return '${now.day}/${now.month}/${now.year}';
  }

  static String _getFutureDate(int days) {
    final now = DateTime.now();
    final future = now.add(Duration(days: days));
    return '${future.day}/${future.month}/${future.year}';
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Reset forms when navigating
      _showManualForm = false;
      _showAutoForm = false;
      _showGeneratedContract = false;
    });
  }

  void _showManualContractForm() {
    setState(() {
      _showManualForm = true;
      _showAutoForm = false;
      _showGeneratedContract = false;
    });
  }

  void _showAutoContractForm() {
    setState(() {
      _showManualForm = false;
      _showAutoForm = true;
      _showGeneratedContract = false;
    });
  }

  void _createManualContract() {
    if (_projectTitleController.text.isEmpty) {
      _showErrorDialog('Please enter a project title');
      return;
    }

    // Create new contract
    final newContract = Contract(
      title: _projectTitleController.text,
      details: 'Created: ${_getCurrentDate()} • Due: ${_deadlineController.text.isNotEmpty ? _deadlineController.text : _getFutureDate(30)} • \$${_paymentTermsController.text.isNotEmpty ? _paymentTermsController.text : "0"} ${_selectedPaymentFrequency.toLowerCase()}',
      status: 'Pending',
      statusColor: Colors.orange,
      scope: _projectScopeController.text,
      paymentTerms: '${_paymentTermsController.text} ${_selectedPaymentFrequency.toLowerCase()}',
      revisions: _revisionsController.text,
      workingHours: _workingHoursController.text,
      workingDays: _workingDaysController.text,
      deadline: _deadlineController.text,
      createdDate: _getCurrentDate(),
    );

    // Add to pending contracts
    setState(() {
      _pendingContracts.add(newContract);
    });

    // Create a new work room for this contract
    final newWorkRoom = WorkRoom(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      contractTitle: _projectTitleController.text,
      progress: 0,
      nextMilestone: 'Project Kickoff',
      dueDate: _deadlineController.text.isNotEmpty ? _deadlineController.text : _getFutureDate(30),
      status: 'Not Started',
    );

    setState(() {
      _workRooms.add(newWorkRoom);
      _workUpdates[newWorkRoom.id] = [];
      _workRoomChats[newWorkRoom.id] = [];
    });

    _showSuccessDialog('Contract created successfully! It is now in pending status.');

    // Clear the form
    _projectTitleController.clear();
    _projectScopeController.clear();
    _paymentTermsController.clear();
    _revisionsController.clear();
    _workingHoursController.clear();
    _workingDaysController.clear();
    _deadlineController.clear();

    setState(() {
      _showManualForm = false;
      _currentContractTab = 'pending'; // Switch to pending tab
    });
  }

  void _generateAutoContract() {
    if (_keywordController.text.isEmpty) {
      _showErrorDialog('Please enter some keywords to generate a contract');
      return;
    }

    // Process keywords and generate contract content
    setState(() {
      _showGeneratedContract = true;
    });
  }

  void _useAutoContract() {
    // Create contract from auto-generated content
    final newContract = Contract(
      title: _keywordController.text.isNotEmpty ?
      _keywordController.text.split(',').first.trim() :
      'Project from Keywords',
      details: 'Created: ${_getCurrentDate()} • Due: ${_getFutureDate(5)} • \$500 Fixed Price', // Changed to 5 days
      status: 'Pending',
      statusColor: Colors.orange,
      scope: 'Project based on keywords: ${_keywordController.text}',
      paymentTerms: '\$500 Fixed Price',
      revisions: '3 revisions included',
      workingHours: '8 hours/day',
      workingDays: 'Monday - Friday',
      deadline: _getFutureDate(5), // Changed to 5 days
      createdDate: _getCurrentDate(),
    );

    // Add to pending contracts
    setState(() {
      _pendingContracts.add(newContract);
    });

    // Create a new work room for this contract
    final newWorkRoom = WorkRoom(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      contractTitle: _keywordController.text.isNotEmpty ?
      _keywordController.text.split(',').first.trim() :
      'Project from Keywords',
      progress: 0,
      nextMilestone: 'Project Kickoff',
      dueDate: _getFutureDate(5),
      status: 'Not Started',
    );

    setState(() {
      _workRooms.add(newWorkRoom);
      _workUpdates[newWorkRoom.id] = [];
      _workRoomChats[newWorkRoom.id] = [];
    });

    _showSuccessDialog('Contract created successfully! It is now in pending status.');

    setState(() {
      _showAutoForm = false;
      _showGeneratedContract = false;
      _keywordController.clear();
      _currentContractTab = 'pending'; // Switch to pending tab
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error', style: TextStyle(color: Colors.red)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK', style: TextStyle(color: Color(0xFF66B2FF))),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Success', style: TextStyle(color: Color(0xFF00C853))),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK', style: TextStyle(color: Color(0xFF66B2FF))),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String workRoomId) {
    if (_messageController.text.isEmpty) return;

    setState(() {
      _workRoomChats[workRoomId]!.add(
        ChatMessage(
          sender: 'You',
          message: _messageController.text,
          time: _getCurrentTime(),
          isMe: true,
        ),
      );
      _messageController.clear();
    });
  }

  void _addWorkUpdate(String workRoomId, String description, int progress) {
    try {
      setState(() {
        _workUpdates[workRoomId]!.add(
          WorkUpdate(
            date: _getCurrentDate(),
            description: description,
            progress: progress,
          ),
        );

        // Workroom progress update karein
        final roomIndex = _workRooms.indexWhere((room) => room.id == workRoomId);
        if (roomIndex != -1) {
          _workRooms[roomIndex] = _workRooms[roomIndex].copyWith(
              progress: progress,
              status: progress == 100 ? 'Completed' : 'In Progress'
          );
        }
      });

      _showSuccessDialog('Work update added successfully!');
    } catch (e) {
      print('Error in _addWorkUpdate: $e');
    }
  }

  void _showAddUpdateDialog(String workRoomId) {
    final descriptionController = TextEditingController();
    final progressController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text('Add Work Update'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Update Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              TextField(
                controller: progressController,
                decoration: InputDecoration(
                  labelText: 'Progress Percentage (0-100)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (descriptionController.text.isNotEmpty &&
                    progressController.text.isNotEmpty) {
                  final progress = int.tryParse(progressController.text) ?? 0;
                  _addWorkUpdate(workRoomId, descriptionController.text, progress.clamp(0, 100));
                  Navigator.of(ctx).pop(); // YEH LINE ZAROORI HAI
                } else {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    SnackBar(content: Text('Please fill all fields')),
                  );
                }
              },
              child: Text('Add Update'),
            ),
          ],
        );
      },
    );
  }

  void _showContractDetails(Contract contract) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Contract Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title: ${contract.title}', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('Scope: ${contract.scope}'),
              SizedBox(height: 10),
              Text('Payment Terms: ${contract.paymentTerms}'),
              SizedBox(height: 10),
              Text('Revisions: ${contract.revisions}'),
              SizedBox(height: 10),
              Text('Working Hours: ${contract.workingHours}'),
              SizedBox(height: 10),
              Text('Working Days: ${contract.workingDays}'),
              SizedBox(height: 10),
              Text('Deadline: ${contract.deadline}'),
              SizedBox(height: 10),
              Text('Created: ${contract.createdDate}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Contract' : 'Work Room', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF66B2FF),
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          Padding(
            padding: EdgeInsets.only(right: 16.0, left: 8.0),
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
      body: _selectedIndex == 0 ? _buildContractTab() : _buildWorkRoomTab(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Contracts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Work Room',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF66B2FF),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildContractTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Create New Contract Section
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.black, width: 1),
              ),
              shadowColor: Colors.black.withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create New Contract',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF66B2FF)),
                    ),
                    SizedBox(height: 16),
                    Text('Choose how you want to create your contract',
                        style: TextStyle(color: Colors.grey[700], fontSize: 15)),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ContractOptionCard(
                            icon: Icons.edit_document,
                            title: 'Manual Creation',
                            description:
                            'Shape your contract your way — with full control and custom clauses.',
                            onTap: _showManualContractForm,
                            color: Color(0xFF66B2FF),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ContractOptionCard(
                            icon: Icons.auto_awesome_mosaic,
                            title: 'Automatic Generation',
                            description:
                            'Enter keywords to generate a draft contract you can review and edit.',
                            onTap: _showAutoContractForm,
                            color: Color(0xFF00C853),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    if (_showManualForm) ManualContractForm(
                      projectTitleController: _projectTitleController,
                      projectScopeController: _projectScopeController,
                      paymentTermsController: _paymentTermsController,
                      revisionsController: _revisionsController,
                      workingHoursController: _workingHoursController,
                      workingDaysController: _workingDaysController,
                      deadlineController: _deadlineController,
                      selectedPaymentFrequency: _selectedPaymentFrequency,
                      paymentFrequencyOptions: _paymentFrequencyOptions,
                      onPaymentFrequencyChanged: (String? newValue) {
                        setState(() {
                          _selectedPaymentFrequency = newValue!;
                        });
                      },
                      onCreate: _createManualContract,
                    ),
                    if (_showAutoForm) AutoContractForm(
                      keywordController: _keywordController,
                      onGenerate: _generateAutoContract,
                      onUse: _useAutoContract,
                      showGeneratedContract: _showGeneratedContract,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Contract Dashboard
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.black, width: 1),
              ),
              shadowColor: Colors.black.withOpacity(0.1),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contract Dashboard',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF66B2FF)),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            count: _activeContracts.length.toString(),
                            label: 'Active Contracts',
                            color: Color(0xFF00C853),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: StatCard(
                            count: _pendingContracts.length.toString(),
                            label: 'Pending Contracts',
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: StatCard(
                            count: _completedContracts.length.toString(),
                            label: 'Completed Contracts',
                            color: Color(0xFF66B2FF),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        ContractTabButton(
                          label: 'Active',
                          isActive: _currentContractTab == 'active',
                          onTap: () {
                            setState(() {
                              _currentContractTab = 'active';
                            });
                          },
                          color: Color(0xFF00C853),
                        ),
                        SizedBox(width: 8),
                        ContractTabButton(
                          label: 'Pending',
                          isActive: _currentContractTab == 'pending',
                          onTap: () {
                            setState(() {
                              _currentContractTab = 'pending';
                            });
                          },
                          color: Colors.orange,
                        ),
                        SizedBox(width: 8),
                        ContractTabButton(
                          label: 'Completed',
                          isActive: _currentContractTab == 'completed',
                          onTap: () {
                            setState(() {
                              _currentContractTab = 'completed';
                            });
                          },
                          color: Color(0xFF66B2FF),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    if (_currentContractTab == 'active') ActiveContracts(
                      contracts: _activeContracts,
                      onViewContract: _showContractDetails,
                    ),
                    if (_currentContractTab == 'pending') PendingContracts(
                      contracts: _pendingContracts,
                      onViewContract: _showContractDetails,
                    ),
                    if (_currentContractTab == 'completed')
                      CompletedContracts(
                        contracts: _completedContracts,
                        onViewContract: _showContractDetails,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkRoomTab() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'My Work Rooms',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF66B2FF)),
          ),
        ),
        Expanded(
          child: _workRooms.isEmpty
              ? Center(
            child: Text(
              'No active work rooms',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          )
              : ListView.builder(
            itemCount: _workRooms.length,
            itemBuilder: (context, index) {
              final workRoom = _workRooms[index];
              return WorkRoomCard(
                workRoom: workRoom,
                onTap: () {
                  _showWorkRoomDetails(workRoom);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showWorkRoomDetails(WorkRoom workRoom) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return WorkRoomDetailScreen(
          workRoom: workRoom,
          updates: _workUpdates[workRoom.id] ?? [],
          chats: _workRoomChats[workRoom.id] ?? [],
          messageController: _messageController,
          onSendMessage: () {
            _sendMessage(workRoom.id);
          },
          onAddUpdate: () => _showAddUpdateDialog(workRoom.id),
          onViewContract: () {
            // Find the contract for this workroom
            final contract = _pendingContracts.firstWhere(
                  (c) => c.title == workRoom.contractTitle,
              orElse: () => Contract(
                title: workRoom.contractTitle,
                details: 'No contract details available',
                status: 'Unknown',
                statusColor: Colors.grey,
                scope: '',
                paymentTerms: '',
                revisions: '',
                workingHours: '',
                workingDays: '',
                deadline: '',
                createdDate: '',
              ),
            );
            _showContractDetails(contract);
          },
        );
      },
    );
  }
}

class Contract {
  final String title;
  final String details;
  final String status;
  final Color statusColor;
  final String scope;
  final String paymentTerms;
  final String revisions;
  final String workingHours;
  final String workingDays;
  final String deadline;
  final String createdDate;

  Contract({
    required this.title,
    required this.details,
    required this.status,
    required this.statusColor,
    required this.scope,
    required this.paymentTerms,
    required this.revisions,
    required this.workingHours,
    required this.workingDays,
    required this.deadline,
    required this.createdDate,
  });
}

class WorkRoom {
  final String id;
  final String contractTitle;
  final int progress;
  final String nextMilestone;
  final String dueDate;
  final String status;

  WorkRoom({
    required this.id,
    required this.contractTitle,
    required this.progress,
    required this.nextMilestone,
    required this.dueDate,
    required this.status,
  });

  WorkRoom copyWith({
    int? progress,
    String? nextMilestone,
    String? status,
  }) {
    return WorkRoom(
      id: id,
      contractTitle: contractTitle,
      progress: progress ?? this.progress,
      nextMilestone: nextMilestone ?? this.nextMilestone,
      dueDate: dueDate,
      status: status ?? this.status,
    );
  }
}

class WorkUpdate {
  final String date;
  final String description;
  final int progress;

  WorkUpdate({
    required this.date,
    required this.description,
    required this.progress,
  });
}

class ChatMessage {
  final String sender;
  final String message;
  final String time;
  final bool isMe;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.time,
    required this.isMe,
  });
}

class WorkRoomCard extends StatelessWidget {
  final WorkRoom workRoom;
  final VoidCallback onTap;

  const WorkRoomCard({required this.workRoom, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.black, width: 1),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Color(0xFF66B2FF).withOpacity(0.2),
          child: Icon(Icons.work, color: Color(0xFF66B2FF)),
        ),
        title: Text(
          workRoom.contractTitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text('Progress: ${workRoom.progress}%'),
            LinearProgressIndicator(
              value: workRoom.progress / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF66B2FF)),
            ),
            SizedBox(height: 8),
            Text('Next: ${workRoom.nextMilestone}'),
            Text('Due: ${workRoom.dueDate}'),
          ],
        ),
        trailing: Chip(
          label: Text(workRoom.status),
          backgroundColor: workRoom.status == 'In Progress'
              ? Colors.blue[100]
              : workRoom.status == 'Completed'
              ? Colors.green[100]
              : Colors.orange[100],
        ),
        onTap: onTap,
      ),
    );
  }
}

class WorkRoomDetailScreen extends StatefulWidget {
  final WorkRoom workRoom;
  final List<WorkUpdate> updates;
  final List<ChatMessage> chats;
  final TextEditingController messageController;
  final VoidCallback onSendMessage;
  final VoidCallback onAddUpdate;
  final VoidCallback onViewContract;

  const WorkRoomDetailScreen({
    required this.workRoom,
    required this.updates,
    required this.chats,
    required this.messageController,
    required this.onSendMessage,
    required this.onAddUpdate,
    required this.onViewContract,
  });

  @override
  _WorkRoomDetailScreenState createState() => _WorkRoomDetailScreenState();
}

class _WorkRoomDetailScreenState extends State<WorkRoomDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.workRoom.contractTitle),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.timeline), text: 'Progress'),
              Tab(icon: Icon(Icons.chat), text: 'Chat'),
              Tab(icon: Icon(Icons.info), text: 'Details'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildProgressTab(),
            _buildChatTab(),
            _buildDetailsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressTab() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Overall Progress',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: widget.workRoom.progress / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF66B2FF)),
                    minHeight: 20,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${widget.workRoom.progress}% Complete',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: widget.onAddUpdate,
                    child: Text('Add Progress Update'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF66B2FF),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: widget.updates.isEmpty
              ? Center(
            child: Text('No updates yet'),
          )
              : ListView.builder(
            itemCount: widget.updates.length,
            itemBuilder: (context, index) {
              final update = widget.updates[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFF66B2FF).withOpacity(0.2),
                  child: Icon(Icons.update, color: Color(0xFF66B2FF)),
                ),
                title: Text(update.description),
                subtitle: Text('${update.date} - Progress: ${update.progress}%'),
                trailing: Chip(
                  label: Text('${update.progress}%'),
                  backgroundColor: Color(0xFF66B2FF).withOpacity(0.2),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChatTab() {
    return Column(
      children: [
        Expanded(
          child: widget.chats.isEmpty
              ? Center(
            child: Text('No messages yet'),
          )
              : ListView.builder(
            itemCount: widget.chats.length,
            itemBuilder: (context, index) {
              final message = widget.chats[index];
              return ChatBubble(message: message);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Color(0xFF66B2FF)),
                onPressed: widget.onSendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contract Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          DetailItem(title: 'Contract Title', value: widget.workRoom.contractTitle),
          DetailItem(title: 'Status', value: widget.workRoom.status),
          DetailItem(title: 'Progress', value: '${widget.workRoom.progress}%'),
          DetailItem(title: 'Next Milestone', value: widget.workRoom.nextMilestone),
          DetailItem(title: 'Due Date', value: widget.workRoom.dueDate),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: widget.onViewContract,
              child: Text('View Full Contract Details'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF66B2FF),
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isMe ? Color(0xFF66B2FF) : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!message.isMe)
              Text(
                message.sender,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            Text(
              message.message,
              style: TextStyle(
                color: message.isMe ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              message.time,
              style: TextStyle(
                fontSize: 10,
                color: message.isMe ? Colors.white70 : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final String title;
  final String value;

  const DetailItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

class ContractOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final Color color;

  const ContractOptionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.black, width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Icon(icon, size: 30, color: color),
              ),
              SizedBox(height: 12),
              Text(title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
              SizedBox(height: 8),
              Text(description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }
}

class ManualContractForm extends StatelessWidget {
  final TextEditingController projectTitleController;
  final TextEditingController projectScopeController;
  final TextEditingController paymentTermsController;
  final TextEditingController revisionsController;
  final TextEditingController workingHoursController;
  final TextEditingController workingDaysController;
  final TextEditingController deadlineController;
  final String selectedPaymentFrequency;
  final List<String> paymentFrequencyOptions;
  final ValueChanged<String?> onPaymentFrequencyChanged;
  final VoidCallback onCreate;

  const ManualContractForm({
    required this.projectTitleController,
    required this.projectScopeController,
    required this.paymentTermsController,
    required this.revisionsController,
    required this.workingHoursController,
    required this.workingDaysController,
    required this.deadlineController,
    required this.selectedPaymentFrequency,
    required this.paymentFrequencyOptions,
    required this.onPaymentFrequencyChanged,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Manual Contract Form',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF66B2FF))),
        SizedBox(height: 16),
        TextField(
          controller: projectTitleController,
          decoration: InputDecoration(
            labelText: 'Project Title',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: projectScopeController,
          decoration: InputDecoration(
            labelText: 'Project Scope',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          maxLines: 4,
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: workingHoursController,
                decoration: InputDecoration(
                  labelText: 'Working Hours',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: workingDaysController,
                decoration: InputDecoration(
                  labelText: 'Working Days',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        TextField(
          controller: deadlineController,
          decoration: InputDecoration(
            labelText: 'Deadline (DD/MM/YYYY)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                controller: paymentTermsController,
                decoration: InputDecoration(
                  labelText: 'Payment Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.black, width: 1),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButton<String>(
                    value: selectedPaymentFrequency,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down, color: Color(0xFF66B2FF)),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    underline: SizedBox(),
                    items: paymentFrequencyOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(fontWeight: FontWeight.w500)),
                      );
                    }).toList(),
                    onChanged: onPaymentFrequencyChanged,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        TextField(
          controller: revisionsController,
          decoration: InputDecoration(
            labelText: 'Revisions',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: onCreate,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF00C853),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.black, width: 1),
              ),
              elevation: 3,
            ),
            child: Text('Create Contract', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }
}

class AutoContractForm extends StatelessWidget {
  final TextEditingController keywordController;
  final VoidCallback onGenerate;
  final VoidCallback onUse;
  final bool showGeneratedContract;

  const AutoContractForm({
    required this.keywordController,
    required this.onGenerate,
    required this.onUse,
    required this.showGeneratedContract,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Automatic Contract Generation',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF66B2FF))),
        SizedBox(height: 16),
        Text(
            'Enter project details (e.g., "Logo design, 3 revisions, delivery in 5 days, \$50 fixed")',
            style: TextStyle(color: Colors.grey[700])),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: keywordController,
                decoration: InputDecoration(
                  hintText: 'Describe your project with keywords...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
            ),
            SizedBox(width: 12),
            ElevatedButton(
              onPressed: onGenerate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00C853),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.black, width: 1),
                ),
                elevation: 3,
              ),
              child: Text('Generate'),
            ),
          ],
        ),
        SizedBox(height: 20),
        if (showGeneratedContract) ...[
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF00C853).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Contract Draft Preview',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00C853))),
                SizedBox(height: 12),
                ContractClause(
                  title: 'Project Description',
                  content: 'Project: ${keywordController.text.split(',').first.trim()}',
                ),
                ContractClause(
                  title: 'Timeline',
                  content:
                  'Project will be delivered within 5 business days from the start date.',
                ),
                ContractClause(
                  title: 'Payment Terms',
                  content:
                  'Fixed price of \$500. 50% payable upfront, 50% upon completion.',
                ),
                ContractClause(
                  title: 'Revisions',
                  content:
                  'Includes 3 rounds of revisions. Additional revisions will be billed at \$50 per round.',
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: onUse,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00C853),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.black, width: 1),
                ),
                elevation: 3,
              ),
              child: Text('Use This Draft', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ],
    );
  }
}

class ContractClause extends StatelessWidget {
  final String title;
  final String content;

  const ContractClause({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00C853))),
          SizedBox(height: 6),
          Text(content, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String count;
  final String label;
  final Color color;

  const StatCard({required this.count, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.black, width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(count,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
            SizedBox(height: 8),
            Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class ContractTabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Color color;

  const ContractTabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? color : Colors.grey[200],
        foregroundColor: isActive ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.black, width: 1),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        elevation: 2,
      ),
      child: Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

class ActiveContracts extends StatelessWidget {
  final List<Contract> contracts;
  final Function(Contract) onViewContract;

  const ActiveContracts({required this.contracts, required this.onViewContract});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: contracts.isEmpty ? [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('No active contracts', style: TextStyle(color: Colors.grey)),
        )
      ] : contracts.map((contract) => Column(
        children: [
          ContractItem(
            contract: contract,
            onViewContract: () => onViewContract(contract),
          ),
          SizedBox(height: 12),
        ],
      )).toList(),
    );
  }
}

class PendingContracts extends StatelessWidget {
  final List<Contract> contracts;
  final Function(Contract) onViewContract;

  const PendingContracts({required this.contracts, required this.onViewContract});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: contracts.isEmpty ? [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('No pending contracts', style: TextStyle(color: Colors.grey)),
        )
      ] : contracts.map((contract) => Column(
        children: [
          ContractItem(
            contract: contract,
            onViewContract: () => onViewContract(contract),
          ),
          SizedBox(height: 12),
        ],
      )).toList(),
    );
  }
}

class CompletedContracts extends StatelessWidget {
  final List<Contract> contracts;
  final Function(Contract) onViewContract;

  const CompletedContracts({required this.contracts, required this.onViewContract});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: contracts.isEmpty ? [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('No completed contracts', style: TextStyle(color: Colors.grey)),
        )
      ] : contracts.map((contract) => Column(
        children: [
          ContractItem(
            contract: contract,
            onViewContract: () => onViewContract(contract),
          ),
          SizedBox(height: 12),
        ],
      )).toList(),
    );
  }
}

class ContractItem extends StatelessWidget {
  final Contract contract;
  final VoidCallback onViewContract;

  const ContractItem({
    required this.contract,
    required this.onViewContract,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.black, width: 1),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(contract.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6),
            Text(contract.details, style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: contract.statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Text(contract.status,
                      style: TextStyle(color: contract.statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
                SizedBox(width: 8),
                Text('Created: ${contract.createdDate}', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.visibility, color: Color(0xFF66B2FF)),
          onPressed: onViewContract,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ContractWorkroomPage(),
    debugShowCheckedModeBanner: false,
  ));
}