class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final MessageType type;

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.timestamp,
    required this.isRead,
    required this.type,
  });
}

enum MessageType {
  text,
  image,
  file,
  system
}

class Chat {
  final String id;
  final String participantId;
  final String participantName;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final String participantImage;

  Chat({
    required this.id,
    required this.participantId,
    required this.participantName,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.participantImage,
  });
}