 class SendMessageRequestModel {
  final String receiverId;
  final String content;
   final String token;
  

  SendMessageRequestModel({
    required this.receiverId,
    required this.content,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'receiverId': receiverId,
      'content': content,
      'token': token
    };
  }
}