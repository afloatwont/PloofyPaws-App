import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat_model.dart';
import '../models/message.dart';

class ChatDatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference? _chatsCollection;

  ChatDatabaseService() {
    setupCollectionReferences();
  }

  void setupCollectionReferences() {
    // _usersCollection =
    //     _firebaseFirestore.collection('users').withConverter<UserProfile>(
    //           fromFirestore: (snapshots, _) =>
    //               UserProfile.fromJson(snapshots.data()!),
    //           toFirestore: (userprofile, _) => userprofile.toJson(),
    //         );
    _chatsCollection = _firestore.collection('chats').withConverter<ChatModel>(
          fromFirestore: (snapshots, _) =>
              ChatModel.fromJson(snapshots.data()!),
          toFirestore: (chat, _) => chat.toJson(),
        );
  }

  Future<bool> checkChatExists(String uid1, String uid2) async {
    String chatId = generateChatId(uid1, uid2);
    final result = await _chatsCollection!.doc(chatId).get();
    if (result != null) {
      return result.exists;
    }
    return false;
  }

  Future<void> createNewChat(String uid1, String uid2) async {
    String chatId = generateChatId(uid1, uid2);
    final docRef = _chatsCollection!.doc(chatId);
    final chat =
        ChatModel(chatId: chatId, participants: [uid1, uid2], messages: []);
    await docRef.set(chat);
  }

  // Check if a chat exists, if not, create one, otherwise append the message
  Future<void> sendMessage(
      String userId1, String userId2, Message message) async {
    String chatId = generateChatId(userId1, userId2);
    DocumentReference chatDocRef = _firestore.collection('chats').doc(chatId);

    DocumentSnapshot chatSnapshot = await chatDocRef.get();

    if (chatSnapshot.exists) {
      // Append message to existing chat
      await chatDocRef.update({
        'messages': FieldValue.arrayUnion([message.toJson()])
      });
    } else {
      // Create new chat and add message
      await chatDocRef.set({
        'messages': [message.toJson()]
      });
    }
  }

  Future<void> sendChatMessage(
      String uid1, String uid2, Message message) async {
    String chatId = generateChatId(uid1, uid2);
    final docRef = _chatsCollection!.doc(chatId);
    await docRef.update(
      {
        'messages': FieldValue.arrayUnion(
          [
            message.toJson(),
          ],
        ),
      },
    );
    print("Message Sent");
  }

  // Read messages from a chat
  Future<List<Message>> readMessages(String chatId) async {
    DocumentSnapshot chatSnapshot =
        await _firestore.collection('chats').doc(chatId).get();

    if (chatSnapshot.exists) {
      List<dynamic> messageList = chatSnapshot.get('messages');
      return messageList.map((data) => Message.fromJson(data)).toList();
    } else {
      return [];
    }
  }

  Stream<List<Message>> getChatMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        List<dynamic> messageList = snapshot.get('messages');
        return messageList.map((data) => Message.fromJson(data)).toList();
      } else {
        return [];
      }
    });
  }

  // Update a specific message (not applicable directly with arrayUnion, so we fetch all, update locally, and save back)
  Future<void> updateMessage(String chatId, Message message) async {
    DocumentReference chatDocRef = _firestore.collection('chats').doc(chatId);
    DocumentSnapshot chatSnapshot = await chatDocRef.get();

    if (chatSnapshot.exists) {
      List<dynamic> messageList = chatSnapshot.get('messages');
      int messageIndex =
          messageList.indexWhere((msg) => msg['id'] == message.id);

      if (messageIndex != -1) {
        messageList[messageIndex] = message.toJson();
        await chatDocRef.update({'messages': messageList});
      }
    }
  }

  // Delete a specific message (similarly, fetch all, remove locally, and save back)
  Future<void> deleteMessage(String chatId, String messageId) async {
    DocumentReference chatDocRef = _firestore.collection('chats').doc(chatId);
    DocumentSnapshot chatSnapshot = await chatDocRef.get();

    if (chatSnapshot.exists) {
      List<dynamic> messageList = chatSnapshot.get('messages');
      messageList.removeWhere((msg) => msg['id'] == messageId);
      await chatDocRef.update({'messages': messageList});
    }
  }
}
