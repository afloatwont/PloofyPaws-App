import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:ploofypaws/chat/models/message.dart';
import 'package:ploofypaws/pages/ai/ai_appbar.dart';
import 'package:ploofypaws/pages/ai/gemini.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_auth.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_store.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/user_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  final TextEditingController _controller = TextEditingController();
  // final GlobalKey<FormState> formKey = GlobalKey();
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
      if (mounted) {
        setState(() {
          currUser = value!;
        });
      }
    });
  }

  void _initializeBot() {
    bot = GenModel();
    bot.init();
  }

  void _loadInitialMessages() {
    bot.getResponse("Hey!!!").then((value) {
      if (mounted) {
        setState(() {
          messages.add(Message(text: value, id: "ploofypaws"));
        });
      }
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
      if (mounted) {
        setState(() {
          messages.add(Message(text: response, id: "ploofypaws"));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight = MediaQuery.of(context).size.height * 0.34;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AiAppBar(appBarHeight: appBarHeight),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.66,
            minChildSize: 0.66,
            maxChildSize: 1.0,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: List.generate(
                              messages.length, _buildMessageBubble),
                        ),
                      ),
                    ),
                    _buildMessageInput(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(int index) {
    final urlProvider = context.read<UrlProvider>();
    final avatarUrl =
        urlProvider.urlMap['assets/images/content/dog_with_coat.jpeg'];
    final userProvider = context.read<UserProvider>();
    final userAvatar = userProvider.user!.photoUrl;
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
              CircleAvatar(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.black,
                backgroundImage: CachedNetworkImageProvider(avatarUrl!),
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
              CircleAvatar(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                backgroundImage: userAvatar != null
                    ? CachedNetworkImageProvider(userAvatar)
                    : null,
                child: userAvatar == null ? const Icon(Icons.person) : null,
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
