import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new message
  Future<void> createMessage(String chatId, Message message) async {
    await _firestore.collection('chats').doc(chatId).collection('messages').add(message.toJson());
  }

  // Read messages from a chat
  Future<List<Message>> readMessages(String chatId) async {
    QuerySnapshot snapshot = await _firestore.collection('chats').doc(chatId).collection('messages').get();
    return snapshot.docs.map((doc) => Message.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }

  // Update a message
  Future<void> updateMessage(String chatId, Message message) async {
    await _firestore.collection('chats').doc(chatId).collection('messages').doc(message.id).update(message.toJson());
  }

  // Delete a message
  Future<void> deleteMessage(String chatId, String messageId) async {
    await _firestore.collection('chats').doc(chatId).collection('messages').doc(messageId).delete();
  }
}
