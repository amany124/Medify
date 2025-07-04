import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medify/features/chat/models/get_conversation_response_model.dart';
import 'package:medify/features/chat/models/get_messages_response_model.dart';
import 'package:medify/features/chat/models/send_message_request_model.dart';
import 'package:medify/features/chat/repo/chat_repo.dart';
import 'package:meta/meta.dart';

import '../../models/getMessages_request_model.dart';
import '../../models/get_conversation_request_model.dart';
import '../../models/send_message_response_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  // ChatCubit() : super(ChatInitial());
  final ChatRepo chatRepo;
  ChatCubit(this.chatRepo) : super(ChatInitial());

  Future<void> sendMessage({
    required SendMessageRequestModel requestModel,
  }) async {
    emit(SendMessageLoading());
    final result = await chatRepo.sendMesssage(requestModel: requestModel);
    result.fold(
      (failure) {
        emit(SendMessageError(failure.message));
      },
      (response) {
        emit(SendMessageSuccess(response));
      },
    );
  }

  Future<void> getConversation({
    required GetConversationRequestModel requestModel,
  }) async {
    emit(GetConversationLoading());
    final result = await chatRepo.getConversation(requestModel: requestModel);
    result.fold(
      (failure) {
        emit(GetConversationError(failure.message));
      },
      (response) {
        emit(GetConversationSuccess(response));
      },
    );
  }

  Future<void> getAllMessages({
    required GetMessagesRequestModel requestModel,
  }) async {
    emit(GetMessagesLoading());
    final result = await chatRepo.getAllMessages(requestModel: requestModel);
    result.fold(
      (failure) {
        emit(GetMessagesError(failure.message));
      },
      (response) {
        emit(GetMessagesSuccess(response));
      },
    );
  }
}
