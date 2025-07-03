import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/domain/modules/org/org_admin.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';

import '../domain/models/chatboot.dart';
import 'chat_bubble.dart';
import 'cubit/chat_bot_cubit.dart';

class ChatBootScreenContent extends StatefulWidget {
  const ChatBootScreenContent({Key? key}) : super(key: key);

  @override
  State<ChatBootScreenContent> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBootScreenContent> {
  final TextEditingController _controller = TextEditingController();

  final List<String> quickReplies = [
    "Available Jobs",
    "Explore Courses",
  ];
  List<String> quickOrg = [
    "About HireNy",
    "available services",
  ];
  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      chatBotCubit.messages.add(text);
    });
    chatBotCubit.getChatBoot(ChatBootModel(message: text.toLowerCase()));
    setState(() {
      _controller.clear();
    });
  }

  late ChatBotCubit chatBotCubit = context.read<ChatBotCubit>();
  void _onQuickReplyTap(String option) {
    setState(() {
      chatBotCubit.messages.add("You selected: $option");
    });
    chatBotCubit.getChatBoot(ChatBootModel(message: option.toLowerCase()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HireNy ChatBoot 🤖',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              reverse: false,
              padding: const EdgeInsets.all(8),
              itemCount: chatBotCubit.messages.length,
              itemBuilder: (context, index) {
                final isUser = index % 2 == 0;
                return isUser
                    ? FadeInRight(
                      duration: const Duration(milliseconds: 300),
                      child: MessageBubble(
                        sender: 'user',
                        text: chatBotCubit.messages[index],
                      ),
                    )
                    : FadeInLeft(
                      duration: const Duration(milliseconds: 300),
                      child: MessageBubble(
                        sender: 'bot',
                        text: chatBotCubit.messages[index],
                      ),
                    );
              },
            ),
          ),

          // Quick reply chips
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: AppSharedData.user is OrgAdmin ?  quickOrg.map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: BounceInRight(
                    duration: const Duration(milliseconds: 400),
                    child: ActionChip(
                      label: Text(option),
                      backgroundColor: Colors.deepPurple.shade100,
                      onPressed: () => _onQuickReplyTap(option),
                    ),
                  ),
                );
              }).toList()
             : quickReplies.map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: BounceInRight(
                        duration: const Duration(milliseconds: 400),
                        child: ActionChip(
                          label: Text(option),
                          backgroundColor: Colors.deepPurple.shade100,
                          onPressed: () => _onQuickReplyTap(option),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),

          const Divider(height: 1),

          // Text input
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                const SizedBox(width: 8),
                Bounce(
                  duration: const Duration(milliseconds: 300),
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => _sendMessage(_controller.text),
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
