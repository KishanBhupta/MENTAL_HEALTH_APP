import 'package:flutter/material.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppText(text: "Add Post",fontSize: 16,fontWeight: FontWeight.w800),
      ),
    );
  }
}
