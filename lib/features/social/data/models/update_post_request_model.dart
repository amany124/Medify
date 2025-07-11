import 'dart:io';

import 'package:dio/dio.dart';

class UpdatePostsRequestModel {
  final String token;
  final String postId; // ID of the doctor whose posts you want to retrieve
  final String content;
  final File? image; // Optional image file to upload
  UpdatePostsRequestModel({
    required this.token,
    required this.postId,
    required this.content,
    this.image,
  });

  Future<Map<String, dynamic>> toJson() async{
    return {
      'token': token,
      'doctorId': postId,
      'content': content,
      'image': image != null ? await MultipartFile.fromFile(image!.path) : null,
    };
  }
}
