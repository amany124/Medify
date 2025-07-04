class GetMessagesRequestModel {
  final String token;
  final String userId; 
  GetMessagesRequestModel({
    required this.token,
    required this.userId,
  });


  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'doctorId': userId,
    };
  }
}
