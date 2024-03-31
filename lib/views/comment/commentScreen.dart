import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/commentController.dart';
import 'package:mental_helth_wellness/customWidgets/appImage.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/utils/appEnums.dart';

import '../../utils/appString.dart';
import '../../utils/assetImages.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key, required this.postId, required this.isNewPostId});

  final int postId;
  final bool isNewPostId;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

  final commentsController = Get.find<CommentsController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getComments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(text: AppStrings.commentsScreenTitle,fontSize: 20,fontWeight: FontWeight.w800),
      ),
      body: GetBuilder<CommentsController>(
        builder: (controller) {
          if(controller.comments.isEmpty){
            return Center(
              child: AppText(
                text: AppStrings.noCommentsLabel,
              ),
            );
          }else{
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    height: 45,
                    width: 45,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle
                    ),
                    child: AppImage(
                      imageType: controller.comments[index].commentUser!.profileImage!=null ? ImageType.networkImage : ImageType.assetImage,
                      imagePath: controller.comments[index].commentUser!.profileImage!=null ? controller.comments[index].commentUser!.profileImage.toString() : AssetImages.appLogo,
                    ),
                  ),
                );
              },
              itemCount: controller.comments.length,
            );
          }
        },
      ),
    );
  }


  // function to get initial comment
  Future _getComments() async {
    print("IS NEW POST ID : ${widget.isNewPostId}");
    if(widget.isNewPostId){
      commentsController.page = 1;
      await commentsController.getComments(id:widget.postId);
    }
  }

  Future _getMoreComments() async {
    commentsController.page = 2;
    await commentsController.getComments(id:widget.postId);
  }
}
