import 'package:flutter/material.dart';
import '../models/message_model.dart';
import '../utils/constants.dart';
import '../widgets/gradient_app_bar.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({Key? key, required this.chat}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    // Add some dummy messages
    _messages.addAll([
      Message(
        id: "1",
        senderId: widget.chat.participantId,
        senderName: widget.chat.participantName,
        message: "Hi there! I'm interested in your services",
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
        isRead: true,
        type: MessageType.text,
      ),
      Message(
        id: "2",
        senderId: "current_user",
        senderName: "You",
        message: "Hello! Thanks for reaching out. What can I help you with?",
        timestamp: DateTime.now().subtract(Duration(hours: 1)),
        isRead: true,
        type: MessageType.text,
      ),
      Message(
        id: "3",
        senderId: widget.chat.participantId,
        senderName: widget.chat.participantName,
        message: "I need a mobile app developed for my business",
        timestamp: DateTime.now().subtract(Duration(minutes: 30)),
        isRead: true,
        type: MessageType.text,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: GradientAppBar(
        title: widget.chat.participantName,
        showBackButton: true,
        actions: [
          IconButton(
            icon: Icon(Icons.phone, color: Colors.white),
            onPressed: () => _makeCall(context),
          ),
          IconButton(
            icon: Icon(Icons.videocam, color: Colors.white),
            onPressed: () => _startVideoCall(context),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) => _handleMenuSelection(value),
            itemBuilder: (BuildContext context) {
              return {
                'View Profile',
                'Clear Chat',
                'Block User',
                'Report'
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    final isMe = message.senderId == "current_user";

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe)
            CircleAvatar(
              backgroundColor: AppColors.primaryGreen.withOpacity(0.1),
              radius: 16,
              child: Text(
                widget.chat.participantImage,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isMe ? AppColors.primaryGreen : AppColors.cardWhite,
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
                  if (!isMe)
                    Text(
                      message.senderName,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  Text(
                    message.message,
                    style: TextStyle(
                      color: isMe ? Colors.white : AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _formatMessageTime(message.timestamp),
                    style: TextStyle(
                      fontSize: 10,
                      color: isMe ? Colors.white70 : AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isMe)
            SizedBox(width: 8),
          if (isMe)
            Icon(
              message.isRead ? Icons.done_all : Icons.done,
              size: 16,
              color: message.isRead ? AppColors.primaryBlue : AppColors.textLight,
            ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.backgroundWhite,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              maxLines: null,
            ),
          ),
          SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: _sendMessage,
              icon: Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  String _formatMessageTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: "current_user",
      senderName: "You",
      message: _messageController.text,
      timestamp: DateTime.now(),
      isRead: false,
      type: MessageType.text,
    );

    setState(() {
      _messages.add(newMessage);
      _messageController.clear();
    });

    // Auto-reply after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      final autoReply = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: widget.chat.participantId,
        senderName: widget.chat.participantName,
        message: "Thanks for your message! I'll get back to you soon.",
        timestamp: DateTime.now().add(Duration(seconds: 2)),
        isRead: true,
        type: MessageType.text,
      );

      setState(() {
        _messages.add(autoReply);
      });
    });
  }

  void _makeCall(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Voice call feature coming soon!'),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  void _startVideoCall(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Video call feature coming soon!'),
        backgroundColor: AppColors.primaryGreen,
      ),
    );
  }

  void _handleMenuSelection(String value) {
    switch (value) {
      case 'View Profile':
      // Navigate to profile
        break;
      case 'Clear Chat':
        _clearChat();
        break;
      case 'Block User':
        _blockUser();
        break;
      case 'Report':
        _reportUser();
        break;
    }
  }

  void _clearChat() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Clear Chat"),
        content: Text("Are you sure you want to clear this chat?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _messages.clear();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Chat cleared successfully!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: Text("Clear"),
          ),
        ],
      ),
    );
  }

  void _blockUser() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Block User"),
        content: Text("Are you sure you want to block ${widget.chat.participantName}?"),
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
                  content: Text('User blocked successfully!'),
                  backgroundColor: AppColors.success,
                ),
              );
              Navigator.pop(context); // Go back to messages list
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: Text("Block"),
          ),
        ],
      ),
    );
  }

  void _reportUser() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Report feature coming soon!'),
        backgroundColor: AppColors.warning,
      ),
    );
  }
}