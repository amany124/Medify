class SendMessageResponseModel {
  String message;
  Data data;

  SendMessageResponseModel({required this.message, required this.data});

  factory SendMessageResponseModel.fromJson(Map<String, dynamic> json) =>
      SendMessageResponseModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String senderId;
  String receiverId;
  String senderModel;
  String receiverModel;
  String content;
  bool read;
  List<dynamic> attachments;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Data({
    required this.senderId,
    required this.receiverId,
    required this.senderModel,
    required this.receiverModel,
    required this.content,
    required this.read,
    required this.attachments,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        senderModel: json["senderModel"],
        receiverModel: json["receiverModel"],
        content: json["content"],
        read: json["read"],
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "receiverId": receiverId,
        "senderModel": senderModel,
        "receiverModel": receiverModel,
        "content": content,
        "read": read,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
