import 'package:flutter/material.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/utils/spacing.dart';
import 'package:mental_helth_wellness/views/post/widgets/postWidget.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(text: "Home",fontSize: 20,fontWeight: FontWeight.w800),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal:Spacing.getDefaultSpacing(context)),
            child: const Icon(Icons.notifications_outlined,size:30),
          )
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context),vertical: 8),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return const PostWidget();
        },
        itemCount: 1,
      ),
    );
  }
}
