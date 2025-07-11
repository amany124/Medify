// TODO: token , content, image

import 'dart:io';

import 'package:dio/dio.dart';

class CreatePostRequestModel {
  final String token;
  final String content;
  final File? image; //
  CreatePostRequestModel({
    required this.token,
    required this.content,
    this.image,
  });

  Future<Map<String, dynamic>> toJson() async {
    return {
      'token': token,
      'content': content,
      'image': image != null ? await MultipartFile.fromFile(image!.path) : null,
    };
  }
  //ToMulti
}
