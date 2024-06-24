import 'message.dart';

class ChatModel {
  String? chatId;
  List<Message>? messages;

}

String generateChatId(String userId1, String userId2) {
    List<String> users = [userId1, userId2];
    users.sort();
    return users.join("_");
  }