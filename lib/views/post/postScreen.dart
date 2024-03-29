import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/postController.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/utils/appMethods.dart';
import 'package:mental_helth_wellness/utils/spacing.dart';
import 'package:mental_helth_wellness/views/post/widgets/postWidget.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  final postController = Get.find<PostController>();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(
        scrollController.position.pixels == scrollController.position.maxScrollExtent
        && postController.hasNext
      ){
        postController.page++;
        _getMorePosts();
      }
    });
  }

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
      body: GetBuilder<PostController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              postController.page = 1;
              await _getMorePosts();
            },
            child: ListView.builder(
              controller:scrollController,
              padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context),vertical: 8),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return PostWidget(post: controller.posts[index]);
              },
              itemCount: controller.posts.length,
            ),
          );
        }
      ),
    );
  }

  Future _getMorePosts() async {
    AppMethods.showLoading();
    await postController.getPosts();
    AppMethods.dismissLoading();
  }
}
