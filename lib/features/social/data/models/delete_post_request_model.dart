

class DeletePostRequestModel {
  final String token;
  final String postId; // ID of the doctor whose posts you want to retrieve
  

  DeletePostRequestModel({
    required this.token,
    required this.postId,
  
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'doctorId': postId,
     
    };
  }
}
