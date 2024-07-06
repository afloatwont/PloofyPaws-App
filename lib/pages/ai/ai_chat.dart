import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:ploofypaws/chat/models/message.dart';
import 'package:ploofypaws/pages/ai/ai_appbar.dart';
import 'package:ploofypaws/pages/ai/gemini.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_auth.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_store.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/user_model.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final _getIt = GetIt.instance;
  late AuthServices _authServices;
  late UserDatabaseService _userDatabaseService;
  late GenModel bot;
  List<Message> messages = [];

  UserModel currUser =
      UserModel(id: "", displayName: "", email: "", photoUrl: "");
  UserModel helper = UserModel(
      id: "ploofypaws", displayName: "AI Assistant", email: ".", photoUrl: ".");

  @override
  void initState() {
    super.initState();
    _initializeServices();
    _initializeBot();
    _loadInitialMessages();
    _setSystemUIOverlayStyle();
  }

  void _initializeServices() {
    _authServices = _getIt.get<AuthServices>();
    _userDatabaseService = _getIt.get<UserDatabaseService>();
    _userDatabaseService
        .getUserProfileByUID(_authServices.user!.uid)
        .then((value) {
      setState(() {
        currUser = value!;
      });
    });
  }

  void _initializeBot() {
    bot = GenModel();
    bot.init();
  }

  void _loadInitialMessages() {
    bot.getResponse("Hey!!!").then((value) {
      setState(() {
        messages.add(Message(text: value, id: "ploofypaws"));
      });
    });
  }

  void _setSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
  }

  Future<void> _sendMessage(String text) async {
    if (text.isNotEmpty) {
      setState(() {
        messages.add(Message(text: text, id: _authServices.user!.uid));
        _controller.clear();
      });
      String response = await bot.getResponse(text);
      setState(() {
        messages.add(Message(text: response, id: "ploofypaws"));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight = MediaQuery.of(context).size.height * 0.34;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                AiAppBar(appBarHeight: appBarHeight),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _buildMessageBubble(index);
                    },
                    childCount: messages.length,
                  ),
                ),
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(int index) {
    bool isCurrentUser = messages[index].id == currUser.id;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisAlignment:
              isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isCurrentUser)
              const CircleAvatar(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.black,
                child: Icon(Icons.smart_toy),
              ),
            if (!isCurrentUser) const SizedBox(width: 8),
            Flexible(
              child: Container(
                margin: isCurrentUser
                    ? const EdgeInsets.only(left: 30)
                    : const EdgeInsets.only(right: 30),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: isCurrentUser ? Colors.black : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  messages[index].text!,
                  style: TextStyle(
                    color: isCurrentUser ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            if (isCurrentUser) const SizedBox(width: 8),
            if (isCurrentUser)
              const CircleAvatar(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                child: Icon(Icons.person),
                // child: Image.network(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(32),
        ),
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
              icon: const CircleAvatar(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                child: Icon(Icons.arrow_forward_ios),
              ),
              onPressed: () async {
                await _sendMessage(_controller.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
