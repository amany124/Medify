import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medify/core/failures/failure.dart';
import 'package:medify/features/chat/models/get_conversation_request_model.dart';
import 'package:medify/features/chat/models/get_conversation_response_model.dart';
import 'package:medify/features/chat/models/send_message_request_model.dart';
import 'package:medify/features/chat/models/send_message_response_model.dart';

import '../../../../../core/constant/endpoints.dart';
import '../../../../../core/services/api_service.dart';
import '../models/getMessages_request_model.dart';
import '../models/get_messages_response_model.dart';

abstract class ChatRepo {
  Future<Either<Failure, SendMessageResponseModel>> sendMesssage({
    required SendMessageRequestModel requestModel,
  });

  Future<Either<Failure, List<GetConversationResponseModel>>> getConversation({
    required GetConversationRequestModel requestModel,
  });

  Future<Either<Failure, List<GetMessagesResponseModel>>> getAllMessages({
    required GetMessagesRequestModel requestModel,
  });
}

class ChatRepoImpl implements ChatRepo {
  final ApiServices apiServices;
  ChatRepoImpl({
    required this.apiServices,
  });

  @override
  Future<Either<Failure, SendMessageResponseModel>> sendMesssage({
    required SendMessageRequestModel requestModel,
  }) async {
    try {
      // send request to the server
      final response = await apiServices.postRequest(
        endpoint: Endpoints.sendMessage,
        token: requestModel.token,
        data: requestModel.toJson(),
      );
      print(response.data);

      // map response to the model
      final responseModel = SendMessageResponseModel.fromJson(response.data);

      return Right(responseModel);
    } on DioException catch (e) {
      print(e.response!.data);
      return Left(Failure(
        e.response!.data['message'] ?? 'An error occurred during create post',
      ));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GetConversationResponseModel>>> getConversation({
    required GetConversationRequestModel requestModel,
  }) async {
    try {
      // print('*' * 30);
      // print(LocalData.getAuthResponseModel()!.user.id.toString());
      // send request to the server
      final response = await apiServices.getRequest(
        endpoint: Endpoints.getConversation,
        token: requestModel.token,
      );
      print(response.data);
      final responseList = response.data as List<dynamic>;
      final responseModelList = <GetConversationResponseModel>[];
      for (var response in responseList) {
        responseModelList.add(GetConversationResponseModel.fromJson(response));
      }

      // map response to the model

      return Right(responseModelList);
    } on DioException catch (e) {
      print(e.response!.data);
      return Left(Failure(
        e.response!.data['message'] ?? 'An error occurred during create post',
      ));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GetMessagesResponseModel>>> getAllMessages({
    required GetMessagesRequestModel requestModel,
  }) async {
    try {
      // send request to the server
      final response = await apiServices.getRequest(
        endpoint: Endpoints.getMessages(requestModel.userId),
        token: requestModel.token,
      );
      // map response to the model
      print(response.data);

      final responseList = response.data as List<dynamic>;
      final responseModelList = <GetMessagesResponseModel>[];
      for (var response in responseList) {
        responseModelList.add(GetMessagesResponseModel.fromJson(response));
      }

      return Right(responseModelList);
    } on DioException catch (e) {
      print(e.response!.data);
      return Left(Failure(
        e.response!.data['message'] ?? 'An error occurred during create post',
      ));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
