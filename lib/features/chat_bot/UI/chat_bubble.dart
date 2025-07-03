import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;

  const MessageBubble({
    Key? key,
    required this.sender,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUser = sender == "user";
    return FadeInRight(
      duration: const Duration(milliseconds: 400),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          padding: const EdgeInsets.all(12),
          constraints: const BoxConstraints(maxWidth: 280),
          decoration: BoxDecoration(
            color: isUser ? Colors.blueAccent : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            text,
            style: TextStyle(color: isUser ? Colors.white : Colors.black87),
          ),
        ),
      ),
    );
  }
}
