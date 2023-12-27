import 'package:chatgpt/models/message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final List<Message> messages = [
    Message(content: 'Hello', isUser: true, timestamp: DateTime.now()),
    Message(content: 'How are you', isUser: false, timestamp: DateTime.now()),
    Message(
        content: 'Fine,Thank you. And you',
        isUser: true,
        timestamp: DateTime.now()),
    Message(content: 'I am fine', isUser: false, timestamp: DateTime.now()),
  ];

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Chat'),
          backgroundColor: Colors.blue,
          centerTitle: true,
          titleTextStyle: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          elevation: 4,
          shadowColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      MessageItem(message: messages[index]),
                  separatorBuilder: (context, index) =>
                      const Divider(height: 16, color: Color(0xfff2f2f2)),
                  itemCount: messages.length),
            ),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                  hintText: 'Type a message...',
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (_textController.text.isNotEmpty) {
                          _sendMessage(_textController.text);
                        }
                      },
                      icon: const Icon(Icons.send))),
            )
          ],
        ),
      ),
    );
  }

  void _sendMessage(String content) {
    final Message message =
        Message(content: content, isUser: true, timestamp: DateTime.now());
    messages.add(message);
    _textController.clear();
  }
}

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: message.isUser ? Colors.blue : Colors.grey,
          child: Text(
            message.isUser ? 'A' : 'GPT',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
        Text(message.content),
      ],
    );
  }
}
