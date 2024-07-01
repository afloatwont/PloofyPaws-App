import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MessageInput extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final Future<void> Function(String text) sendMessage;

  const MessageInput({
    required this.formKey,
    required this.controller,
    required this.sendMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(32)),
      child: Row(
        children: [
          Expanded(
            child: Form(
              key: formKey,
              onChanged: formKey.currentState?.save,
              child: TextFormField(
                controller: controller,
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
              print(controller.text);
              String m = controller.text;
              await sendMessage(m);
            },
          ),
        ],
      ),
    );
  }
}
