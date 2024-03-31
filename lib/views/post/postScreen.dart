import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/postController.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/utils/appMethods.dart';
import 'package:mental_helth_wellness/utils/appString.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_){
      _getPosts();
    });

    scrollController.addListener(() {
      if(
        scrollController.position.pixels == scrollController.position.maxScrollExtent
        && postController.hasNext
      ){
        _getMorePosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(text: AppStrings.homeScreenTitle,fontSize: 20,fontWeight: FontWeight.w800),
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
              await _getPosts();
            },
            child: ListView.builder(
              controller:scrollController,
              padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context),vertical: 8),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return PostWidget(post: controller.posts[index],index: index);
              },
              itemCount: controller.posts.length,
            ),
          );
        }
      ),
    );
  }

  // function to get more posts
  Future _getMorePosts() async {
    postController.page++;
    await postController.getPosts();
  }

  // function to get posts
  Future _getPosts() async {
    postController.page = 1;
    await postController.getPosts();
  }
}
