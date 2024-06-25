import 'message.dart';

class ChatModel {
  String? chatId;
  List<String>? participants;
  List<Message>? messages;
  ChatModel({this.chatId, required this.participants, this.messages});

  ChatModel.fromJson(Map<String, dynamic> data) {
    chatId = data['chatId'];
    participants = data['participants'];
    messages = data['messages'];
  }

  Map<String, dynamic> toJson() {
    return {
      'chatid': chatId,
      'participants': participants,
      'messages': messages,
    };
  }
}

String generateChatId(String userId1, String userId2) {
  List<String> users = [userId1, userId2];
  users.sort();
  return users.join("");
}
