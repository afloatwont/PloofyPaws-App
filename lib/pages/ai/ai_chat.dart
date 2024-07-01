import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/chat/models/message.dart';
import 'package:ploofypaws/pages/ai/ai_appbar.dart';
import 'package:ploofypaws/pages/ai/genai.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_auth.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_store.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/user_model.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

List<Message> messages = [];

class _AiScreenState extends State<AiScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final _getIt = GetIt.instance;
  late AuthServices _authServices;
  late UserDatabaseService _userDatabaseService;

  GenModel bot = GenModel();

  UserModel currUser =
      UserModel(id: "", displayName: "", email: "", photoUrl: "");

  UserModel helper = UserModel(
      id: "ploofypaws", displayName: "AI Assistant", email: ".", photoUrl: ".");

  Future<void> _sendMessage(String text) async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(Message(text: text, id: _authServices.user!.uid));
        _controller.clear();
      });
      String res = await bot.getResponse(text);
      setState(() {
        messages.add(Message(text: res, id: "ploofypaws"));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _authServices = _getIt.get<AuthServices>();
    _userDatabaseService = _getIt.get<UserDatabaseService>();

    _userDatabaseService.getUserProfileByUID(_authServices.user!.uid).then(
          (value) => setState(() {
            currUser = value!;
          }),
        );

    bot.init();
    bot.getResponse("Hey!!!").then(
          (value) => setState(() {
            messages.add(Message(text: value, id: "ploofypaws"));
          }),
        );

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight = MediaQuery.of(context).size.height * 0.34;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              AiAppBar(appBarHeight: appBarHeight),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: messages[index].id == currUser.id
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: messages[index].id == currUser.id
                              ? const EdgeInsets.only(left: 30)
                              : const EdgeInsets.only(right: 30),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: messages[index].id == currUser.id
                                ? Colors.black
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            messages[index].text!,
                            style: TextStyle(
                              color: messages[index].id == currUser.id
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: messages.length,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                      icon: const Icon(
                        Iconsax.gallery,
                        size: 28,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const CircleAvatar(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          child: Icon(Icons.arrow_forward_ios)),
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
          ),
        ],
      ),
    );
  }
}
