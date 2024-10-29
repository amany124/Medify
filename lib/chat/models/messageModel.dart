import 'package:jiffy/jiffy.dart';
import 'package:meta/meta.dart';

@immutable
class messageModel {
  messageModel({
    required this.senderName,
    required this.messageContent,
    required this.messageDate,
    required this.dateMessage,
    this.profilePicture,
  });
  String senderName;
  String messageContent;
  DateTime messageDate;
  String dateMessage;
  String? profilePicture;
}
