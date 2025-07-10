part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

// Initial state
final class ChatInitial extends ChatState {}

// ====================
// MESSAGES STATES (for specific conversation)
// ====================

final class MessagesLoadingState extends ChatState {}

final class MessagesLoadedState extends ChatState {
  final List<GetMessagesResponseModel> messages;
  MessagesLoadedState(this.messages);
}

final class MessagesErrorState extends ChatState {
  final String errorMessage;
  MessagesErrorState(this.errorMessage);
}

// ====================
// SEND MESSAGE STATES
// ====================

final class SendingMessageState extends ChatState {}

final class MessageSentSuccessState extends ChatState {
  final SendMessageResponseModel response;
  MessageSentSuccessState(this.response);
}

final class MessageSendErrorState extends ChatState {
  final String errorMessage;
  MessageSendErrorState(this.errorMessage);
}

// ====================
// CONVERSATIONS STATES (for all chats list)
// ====================

final class ConversationsLoadingState extends ChatState {}

final class ConversationsLoadedState extends ChatState {
  final List<GetConversationResponseModel> conversations;
  ConversationsLoadedState(this.conversations);
}

final class ConversationsErrorState extends ChatState {
  final String errorMessage;
  ConversationsErrorState(this.errorMessage);
}

// ====================
// LEGACY STATES (for backward compatibility - marked as deprecated)
// ====================

@Deprecated('Use MessagesLoadingState instead')
final class SendMessageLoading extends ChatState {}

@Deprecated('Use ChatInitial instead')
final class SendMessageInitial extends ChatState {}

@Deprecated('Use MessageSendErrorState instead')
final class SendMessageError extends ChatState {
  final String message;
  SendMessageError(this.message);
}

@Deprecated('Use MessageSentSuccessState instead')
final class SendMessageSuccess extends ChatState {
  final SendMessageResponseModel sendMessageResponseModel;
  SendMessageSuccess(this.sendMessageResponseModel);
}

@Deprecated('Use ChatInitial instead')
final class GetConversationInitial extends ChatState {}

@Deprecated('Use ConversationsLoadingState instead')
final class GetConversationLoading extends ChatState {}

@Deprecated('Use ConversationsErrorState instead')
final class GetConversationError extends ChatState {
  final String message;
  GetConversationError(this.message);
}

@Deprecated('Use ConversationsLoadedState instead')
final class GetConversationSuccess extends ChatState {
  final List<GetConversationResponseModel> conversationsList;
  GetConversationSuccess(this.conversationsList);
}

@Deprecated('Use MessagesLoadingState instead')
final class GetMessagesLoading extends ChatState {}

@Deprecated('Use MessagesErrorState instead')
final class GetMessagesError extends ChatState {
  final String message;
  GetMessagesError(this.message);
}

@Deprecated('Use MessagesLoadedState instead')
final class GetMessagesSuccess extends ChatState {
  final List<GetMessagesResponseModel> messagesList;
  GetMessagesSuccess(this.messagesList);
}
