import 'package:flutter/material.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppText(text: "Chat",fontSize: 16,fontWeight: FontWeight.w800),
      ),
    );
  }
}
