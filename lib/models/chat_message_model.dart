class ChatMessageModel {
  final String text;
  final bool fromUser;
  final DateTime createdAt;

  const ChatMessageModel({
    required this.text,
    required this.fromUser,
    required this.createdAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      text: json['text'] ?? '',
      fromUser: json['fromUser'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'fromUser': fromUser,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
