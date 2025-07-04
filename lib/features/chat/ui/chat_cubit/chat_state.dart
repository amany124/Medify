part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class SendMessageLoading extends ChatState {}

final class SendMessageInitial extends ChatState {}

final class SendMessageError extends ChatState {
  final String message;
  SendMessageError(this.message);
}

final class SendMessageSuccess extends ChatState {
  final SendMessageResponseModel sendMessageResponseModel;
  SendMessageSuccess(this.sendMessageResponseModel);
}

final class GetConversationInitial extends ChatState {}

final class GetConversationLoading extends ChatState {}

final class GetConversationError extends ChatState {
  final String message;
  GetConversationError(this.message);
}

final class GetConversationSuccess extends ChatState {
  final List<GetConversationResponseModel> conversationsList;
  GetConversationSuccess(this.conversationsList);

 // get messages loading
 


}

final class GetMessagesLoading extends ChatState {}
final class GetMessagesError extends ChatState {
  final String message;
  GetMessagesError(this.message);
}
final class GetMessagesSuccess extends ChatState {
  final List<GetMessagesResponseModel> messagesList;
  GetMessagesSuccess(this.messagesList);
}