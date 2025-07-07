import 'package:flutter/material.dart';
import 'package:hireny/chat/ui/screens/chat.dart';
import 'package:hireny/chat/ui/screens/chat_bloc_proivder.dart';
import 'package:hireny/utils/constants/app_colors.dart';

class ChatFAB extends StatelessWidget {
  final int unreadCount;

  const ChatFAB({super.key, required this.unreadCount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FloatingActionButton(
          heroTag: "chat_fab", // ✅ Unique tag
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ChatBlocProivder()),
            );
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.message, color: Colors.white),
        ),
        if (unreadCount > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 22, minHeight: 22),
              child: Text(
                '$unreadCount',
                style: const TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
