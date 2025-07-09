class GetConversationResponseModel {
  String? id;
  LastMessage? lastMessage;
  int? unreadCount;
  User? user;

  GetConversationResponseModel({
    this.id,
    this.lastMessage,
    this.unreadCount,
    this.user,
  });

  GetConversationResponseModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"]?["id"];
    lastMessage = LastMessage.fromJson(json["lastMessage"]);
    unreadCount = json["unreadCount"];
    user = User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = <String, dynamic>{"id": id};
    data["lastMessage"] = lastMessage!.toJson();
    data["unreadCount"] = unreadCount;
    data["user"] = user!.toJson();
    return data;
  }
}

class LastMessage {
  String? id;
  String? senderId;
  String? receiverId;
  String? senderModel;
  String? receiverModel;
  String? content;
  bool? read;
  List<dynamic>? attachments;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  LastMessage({
    this.id,
    this.senderId,
    this.receiverId,
    this.senderModel,
    this.receiverModel,
    this.content,
    this.read,
    this.attachments,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    senderId = json["senderId"];
    receiverId = json["receiverId"];
    senderModel = json["senderModel"];
    receiverModel = json["receiverModel"];
    content = json["content"];
    read = json["read"];
    attachments = json["attachments"].cast<String>();
    createdAt = DateTime.parse(json["createdAt"]);
    updatedAt = DateTime.parse(json["updatedAt"]);
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["senderId"] = senderId;
    data["receiverId"] = receiverId;
    data["senderModel"] = senderModel;
    data["receiverModel"] = receiverModel;
    data["content"] = content;
    data["read"] = read;
    data["attachments"] = attachments;
    data["createdAt"] = createdAt!.toIso8601String();
    data["updatedAt"] = updatedAt!.toIso8601String();
    data["__v"] = v;
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? role;

  User({
    this.id,
    this.name,
    this.role,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    role = json["role"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["role"] = role;
    return data;
  }
}
