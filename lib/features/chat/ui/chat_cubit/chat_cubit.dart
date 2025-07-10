import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/helpers/local_data.dart';
import 'package:medify/features/chat/models/get_conversation_response_model.dart';
import 'package:medify/features/chat/models/get_messages_response_model.dart';
import 'package:medify/features/chat/models/send_message_request_model.dart';
import 'package:medify/features/chat/repo/chat_repo.dart';

import '../../models/getMessages_request_model.dart';
import '../../models/get_conversation_request_model.dart';
import '../../models/send_message_response_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo chatRepo;

  // Store current conversation data
  List<GetMessagesResponseModel> _currentMessages = [];
  String? _currentUserId;
  String? _currentToken;

  // Store current token for conversations refresh
  String? _currentConversationsToken;

  ChatCubit(this.chatRepo) : super(ChatInitial());

  // Getters for accessing current data
  List<GetMessagesResponseModel> get currentMessages => _currentMessages;
  String? get currentUserId => _currentUserId;

  /// Initialize chat conversation by loading all messages for a specific user
  /// This should be called immediately when navigating to messages page
  Future<void> initializeChatConversation({
    required String userId,
    required String token,
  }) async {
    if (isClosed) return; // Safety check

    _currentUserId = userId;
    _currentToken = token;

    emit(MessagesLoadingState());

    try {
      final result = await chatRepo.getAllMessages(
        requestModel: GetMessagesRequestModel(
          userId: userId,
          token: token,
        ),
      );

      result.fold(
        (failure) {
          if (!isClosed) emit(MessagesErrorState(failure.message));
        },
        (messages) {
          _currentMessages = messages;
          if (!isClosed) emit(MessagesLoadedState(messages));
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(MessagesErrorState('Failed to load messages: ${e.toString()}'));
      }
    }
  }

  /// Refresh messages for current conversation
  Future<void> refreshMessages() async {
    if (isClosed) return; // Safety check

    if (_currentUserId == null || _currentToken == null) {
      if (!isClosed)
        emit(MessagesErrorState('No active conversation to refresh'));
      return;
    }

    await initializeChatConversation(
      userId: _currentUserId!,
      token: _currentToken!,
    );
  }

  /// Send a message and immediately refresh the conversation
  Future<void> sendMessageAndRefresh({
    required SendMessageRequestModel requestModel,
  }) async {
    if (isClosed) return; // Safety check

    emit(SendingMessageState());

    try {
      final result = await chatRepo.sendMesssage(requestModel: requestModel);

      result.fold(
        (failure) {
          if (!isClosed) emit(MessageSendErrorState(failure.message));
        },
        (response) async {
          if (!isClosed) emit(MessageSentSuccessState(response));
          // Silently refresh messages after sending (without loading state)
          await _refreshMessagesSilently();
          // Silently refresh conversations list to update last message
          if (_currentConversationsToken != null) {
            await _refreshConversationsSilently();
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(MessageSendErrorState('Failed to send message: ${e.toString()}'));
      }
    }
  }

  /// Refresh messages silently (without loading state)
  Future<void> _refreshMessagesSilently() async {
    if (isClosed || _currentUserId == null || _currentToken == null) return;

    try {
      final result = await chatRepo.getAllMessages(
        requestModel: GetMessagesRequestModel(
          userId: _currentUserId!,
          token: _currentToken!,
        ),
      );

      result.fold(
        (failure) {
          // Don't emit error for silent refresh
        },
        (messages) {
          _currentMessages = messages;
          if (!isClosed) emit(MessagesLoadedState(messages));
        },
      );
    } catch (e) {
      // Don't emit error for silent refresh
    }
  }

  /// Load conversations list (for AllChats page)
  Future<void> loadConversations({
    required String token,
  }) async {
    if (isClosed) return; // Safety check

    _currentConversationsToken = token; // Store token for later use

    emit(ConversationsLoadingState());

    try {
      final result = await chatRepo.getConversation(
        requestModel: GetConversationRequestModel(token: token),
      );

      result.fold(
        (failure) {
          if (!isClosed) emit(ConversationsErrorState(failure.message));
        },
        (conversations) {
          if (!isClosed) {
            // Filter out conversations where user is talking to themselves
            final currentUserId =
                LocalData.getAuthResponseModel()?.user.id.toString();
            final filteredConversations = conversations.where((conversation) {
              final senderId = conversation.lastMessage?.senderId;
              final receiverId = conversation.lastMessage?.receiverId;

              // Only show conversations where the current user is not talking to themselves
              return !(senderId == currentUserId &&
                  receiverId == currentUserId);
            }).toList();

            emit(ConversationsLoadedState(filteredConversations));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(ConversationsErrorState(
            'Failed to load conversations: ${e.toString()}'));
      }
    }
  }

  /// Refresh conversations silently (without loading state)
  Future<void> _refreshConversationsSilently() async {
    if (isClosed || _currentConversationsToken == null) return;

    try {
      final result = await chatRepo.getConversation(
        requestModel:
            GetConversationRequestModel(token: _currentConversationsToken!),
      );

      result.fold(
        (failure) {
          // Don't emit error for silent refresh
        },
        (conversations) {
          if (!isClosed) {
            // Filter out conversations where user is talking to themselves
            final currentUserId =
                LocalData.getAuthResponseModel()?.user.id.toString();
            final filteredConversations = conversations.where((conversation) {
              final senderId = conversation.lastMessage?.senderId;
              final receiverId = conversation.lastMessage?.receiverId;

              // Only show conversations where the current user is not talking to themselves
              return !(senderId == currentUserId &&
                  receiverId == currentUserId);
            }).toList();

            emit(ConversationsLoadedState(filteredConversations));
          }
        },
      );
    } catch (e) {
      // Don't emit error for silent refresh
    }
  }

  /// Clear current conversation data
  void clearCurrentConversation() {
    _currentMessages.clear();
    _currentUserId = null;
    _currentToken = null;
    _currentConversationsToken = null;
    if (!isClosed) emit(ChatInitial());
  }

  /// Legacy methods for backward compatibility (marked as deprecated)
  @Deprecated('Use sendMessageAndRefresh instead')
  Future<void> sendMessage({
    required SendMessageRequestModel requestModel,
  }) async {
    await sendMessageAndRefresh(requestModel: requestModel);
  }

  @Deprecated('Use loadConversations instead')
  Future<void> getConversation({
    required GetConversationRequestModel requestModel,
  }) async {
    await loadConversations(token: requestModel.token);
  }

  @Deprecated('Use initializeChatConversation instead')
  Future<void> getAllMessages({
    required GetMessagesRequestModel requestModel,
  }) async {
    await initializeChatConversation(
      userId: requestModel.userId,
      token: requestModel.token,
    );
  }
}
