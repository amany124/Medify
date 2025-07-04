class GetConversationRequestModel {
  final String token;
  

  GetConversationRequestModel({
    required this.token,
    
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }
}