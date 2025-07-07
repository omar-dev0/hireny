import 'dart:convert';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import '../../domain/model/chat_response.dart';

class ChatSocketScreen extends StatefulWidget {
  final Conversation conversation;

  const ChatSocketScreen({super.key, required this.conversation});

  @override
  State<ChatSocketScreen> createState() => _ChatSocketScreenState();
}

class _ChatSocketScreenState extends State<ChatSocketScreen> {
  WebSocket? _socket;
  final TextEditingController _controller = TextEditingController();
  late List<Message> _messages;
  final currentUserId = AppSharedData.user?.id;

  @override
  void initState() {
    super.initState();
    _messages = List.from(widget.conversation.messages);
    _connectWebSocket();
  }

  Future<void> _connectWebSocket() async {
    final token = AppSharedData.user?.accessToken ?? '';
    final url = 'ws://localhost:8000/ws/messages/?token=$token';

    try {
      _socket = await WebSocket.connect(url);
      debugPrint('✅ Connected to WebSocket');

      _socket!.listen(
        (message) {
          final data = jsonDecode(message)['message'];
          final newMsg = Message.fromJson(data);
          setState(() {
            _messages.add(newMsg);
          });
        },
        onDone: () => debugPrint('🔌 WebSocket closed'),
        onError: (error) => debugPrint('❌ WebSocket error: $error'),
      );

      _socket!.add(
        jsonEncode({
          'type': 'join',
          'participantId': widget.conversation.participantId,
        }),
      );
    } catch (e) {
      debugPrint('❗ WebSocket connection error: $e');
    }
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final token = AppSharedData.user?.accessToken ?? '';
    final receiverId = widget.conversation.participantId;
    final url = Uri.parse(
      'http://localhost:8000/api/messages/messages/send/$receiverId/',
    );

    _controller.clear();

    try {
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode({'content': text.trim()}),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        debugPrint('❌ Message send failed: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('❗ HTTP error while sending message: $e');
    }
  }

  Widget _buildMessage(Message msg) {
    final isMe = msg.sender == currentUserId;
    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    final bgColor = isMe ? const Color(0xFF168C4B) : const Color(0xFFF1EFFF);
    final textColor = isMe ? Colors.white : Colors.black87;
    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
      bottomLeft: Radius.circular(isMe ? 16 : 4),
      bottomRight: Radius.circular(isMe ? 4 : 16),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: SlideInUp(
        duration: const Duration(milliseconds: 300),
        child: Align(
          alignment: alignment,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 280),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Text(
              msg.content,
              style: TextStyle(fontSize: 16, color: textColor, height: 1.3),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _socket?.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final avatarUrl =
        widget.conversation.participantPhoto.startsWith('/media')
            ? 'http://localhost:8000${widget.conversation.participantPhoto}'
            : widget.conversation.participantPhoto;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF168C4B),
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
            const SizedBox(width: 10),
            Text(
              widget.conversation.participantName,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: _messages.length,
              itemBuilder:
                  (_, index) =>
                      _buildMessage(_messages[_messages.length - 1 - index]),
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: _sendMessage,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF168C4B)),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
