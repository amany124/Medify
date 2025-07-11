import 'dart:async';

import 'package:dio/dio.dart';

enum ContentType {
  json,
  formUrlEncoded,
  multipart,
}

extension ContentTypeExtension on ContentType {
  String get value {
    switch (this) {
      case ContentType.json:
        return 'application/json';
      case ContentType.formUrlEncoded:
        return 'application/x-www-form-urlencoded';
      case ContentType.multipart:
        return 'multipart/form-data';
    }
  }
}

class ApiServices {
  final Dio dio;

  ApiServices(this.dio);

  Future<Response> postRequest({
    required String endpoint,
    Map<String, dynamic>? data,
    String? token,
    ContentType contentType = ContentType.json,
  }) async {
    return await dio.post(
      endpoint,
      data:
          contentType == ContentType.json ? data : FormData.fromMap(data ?? {}),
      options: Options(
        headers: {
          'Content-Type': contentType.value,
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> getRequest({
    required String endpoint,
    String? token,
    Map<String, dynamic>? queryParameters,
    ContentType contentType = ContentType.json,
  }) async {
    return await dio.get(
      endpoint,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          'Content-Type': contentType.value,
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> putRequest({
    required String endpoint,
    Map<String, dynamic>? data,
    String? token,
    ContentType contentType = ContentType.json,
  }) async {
    return await dio.put(
      endpoint,
      data:
          contentType == ContentType.json ? data : FormData.fromMap(data ?? {}),
      options: Options(
        headers: {
          'Content-Type': contentType.value,
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> deleteRequest({
    required String endpoint,
    String? token,
    ContentType contentType = ContentType.json,
  }) async {
    return await dio.delete(
      endpoint,
      options: Options(
        headers: {
          'Content-Type': contentType.value,
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> patchRequest({
    required String endpoint,
    Map<String, dynamic>? data,
    String? token,
    ContentType contentType = ContentType.json,
  }) async {
    return await dio.patch(
      endpoint,
      data:
          contentType == ContentType.json ? data : FormData.fromMap(data ?? {}),
      options: Options(
        headers: {
          'Content-Type': contentType.value,
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }
}
