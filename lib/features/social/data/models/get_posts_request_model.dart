

class GetPostsRequestModel {
  final String token;
  final String doctorId; // ID of the doctor whose posts you want to retrieve
  

  GetPostsRequestModel({
    required this.token,
    required this.doctorId,
  
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'doctorId': doctorId,
     
    };
  }
}
