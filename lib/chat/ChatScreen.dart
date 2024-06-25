import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ploofypaws/chat/models/chat_model.dart';
import 'package:ploofypaws/chat/models/message.dart';
import 'package:ploofypaws/chat/models/user_model.dart';
import 'package:ploofypaws/chat/services/database_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  final GetIt _getIt = GetIt.instance;
  late DatabaseService _databaseService;
  late String chatId;

  UserModel user1 = UserModel(
      userId: "id1", userName: "First", email: "first@g.com", pfpUrl: ".");
  UserModel user2 = UserModel(
      userId: "id2", userName: "second", email: "second@g.com", pfpUrl: ".");

  @override
  void initState() {
    super.initState();
    _databaseService = _getIt.get<DatabaseService>();
    _databaseService.checkChatExists(user1.userId, user2.userId).then(
      (value) {
        if (!value) {
          _databaseService.createNewChat(user1.userId, user2.userId);
        }
      },
    );
    chatId = generateChatId(user1.userId, user2.userId);
    
  }

  Future<void> _sendMessage(String text) async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _controller.clear();
      });
      await _databaseService.sendChatMessage(
          user1.userId, user2.userId, Message(text: text, id: user1.userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_back_outlined)),
        title: const Row(
          children: [
            CircleAvatar(
                // backgroundImage:
                // AssetImage('assets/avatar.png'), // Add your avatar image here
                ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User name'),
                Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _databaseService.getChatMessages(chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No messages yet'));
                }

                List<Message> messageMains = snapshot.data!;
                return ListView.builder(
                  itemCount: messageMains.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: messageMains[index].id == user1.userId
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: messageMains[index].id == user1.userId
                              ? const EdgeInsets.only(left: 30)
                              : const EdgeInsets.only(right: 30),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: messageMains[index].id == user1.userId
                                ? Colors.grey.shade300
                                : Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            messageMains[index].text!,
                            style: TextStyle(
                              color: messageMains[index].id == user1.userId
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30, left: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(32)),
              child: Row(
                children: [
                  Expanded(
                    child: Form(
                      key: formKey,
                      onChanged: formKey.currentState?.save,
                      child: TextFormField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Write your message...',
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.image_outlined,
                      size: 32,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.mic_outlined,
                      size: 32,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      print(_controller.text);
                      String m = _controller.text;
                      await _sendMessage(m);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
