class Message {
  final int? id; //id for database
  final String message;
  final bool isUser;
  final String timestamp;

  Message({
    this.id,
    required this.message,
    required this.isUser,
    required this.timestamp,
  });

  //save on database

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'isUser': isUser ? 1 : 0,
      'timestamp': timestamp,
    };
  }

  // تبدیل Map به مدل
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      message: map['message'],
      isUser: map['isUser'] == 1,
      timestamp: map['timestamp'],
    );
  }
}
