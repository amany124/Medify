class GetMessagesResponseModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String senderModel;
  final String receiverModel;
  final String content;
  final bool read;
  final List<dynamic> attachments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  GetMessagesResponseModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.senderModel,
    required this.receiverModel,
    required this.content,
    required this.read,
    required this.attachments,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GetMessagesResponseModel.fromJson(Map<String, dynamic> json) {
    return GetMessagesResponseModel(
      id: json['_id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      senderModel: json['senderModel'],
      receiverModel: json['receiverModel'],
      content: json['content'],
      read: json['read'],
      attachments: json['attachments'] ?? [],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'senderModel': senderModel,
      'receiverModel': receiverModel,
      'content': content,
      'read': read,
      'attachments': attachments,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}
