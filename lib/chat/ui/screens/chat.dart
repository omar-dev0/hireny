import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/chat/domain/model/chat_response.dart';

import '../cubit/chat_cubit.dart';
import 'chat_detailes_screen.dart';

class ChatScreen extends StatelessWidget {
  final ChatResponse? chatResponse;
  const ChatScreen({super.key, this.chatResponse});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ChatCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Conversations'), centerTitle: true),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: chatResponse?.conversations.length ?? 0,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final convo = chatResponse!.conversations[index];

          return GestureDetector(
            onTap: () {
              cubit.markRead(
                chatResponse?.conversations[index].participantId ?? 0,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatSocketScreen(conversation: convo),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      convo.participantPhoto.startsWith('/media')
                          ? 'http://localhost:8000${convo?.participantPhoto}'
                          : convo.participantPhoto,
                    ),
                    backgroundColor: Colors.grey[300],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      convo.participantName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (convo.unreadCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${convo.unreadCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
