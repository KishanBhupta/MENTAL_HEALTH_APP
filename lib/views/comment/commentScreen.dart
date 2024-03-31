import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/commentController.dart';
import 'package:mental_helth_wellness/customWidgets/appImage.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/customWidgets/cSpace.dart';
import 'package:mental_helth_wellness/utils/appEnums.dart';
import 'package:mental_helth_wellness/utils/appExtensions.dart';

import '../../utils/AppColors.dart';
import '../../utils/appConst.dart';
import '../../utils/appString.dart';
import '../../utils/assetImages.dart';
import 'package:timeago/timeago.dart' as timeago;

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
      backgroundColor: Colors.white,
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
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                index = 0;
                return Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      // commenter's photo
                      Container(
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

                      const CSpace(width: 16),

                      // comment data row
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AppText(
                                  text: AppConst().checkAnonymous(controller.comments[index].isAnonymous!)
                                      ? controller.comments[index].commentUser!.userName??"${controller.comments[index].commentUser!.firstName!} ${controller.comments[index].commentUser!.lastName!}"
                                      : AppStrings.anonymousLabel,
                                  fontWeight: FontWeight.w800,
                                ),

                                const CSpace(width: 8,),

                                AppText(text: "- ${timeago.format(controller.comments[index].createdAt.toString().getDate())}",fontSize: 10,)
                              ],
                            ),
                            const CSpace(height: 8),
                            AppText(
                              text:controller.comments[index].commentDescription.toString(),
                            ),

                            const CSpace(height: 8),
                            Row(
                              children: [
                                // button to like
                                FilledButton.tonalIcon(
                                  onPressed: () async {
                                    // comment is liked remove like
                                    if(controller.hasLike(index: index)){
                                      await commentsController.removeLikeFromComment(commentId:controller.comments[index].id!,index:index);
                                    }
                                    // comment is not liked add like
                                    else{
                                      await commentsController.addLikeToComment(commentId:controller.comments[index].id!,index:index);
                                    }
                                  },
                                  icon:Icon(
                                    controller.hasLike(index: index) ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                                    color: controller.hasLike(index: index) ? AppColors().like : Colors.black,
                                  ),
                                  label: AppText(text: controller.comments[index].likes!=null && (controller.comments[index].likes??0) > 0 ? controller.comments[index].likes!.toString() : ""),
                                  style: FilledButton.styleFrom(
                                    surfaceTintColor: Colors.white,
                                    backgroundColor: Colors.white,
                                  ),
                                ),

                                controller.comments[index].commentUser!.id! == AppConst.userModel!.id!
                                    ? FilledButton.tonalIcon(
                                        onPressed: (){

                                        },
                                        icon:Icon(CupertinoIcons.trash,color: AppColors().danger,),
                                        label: const AppText(text: "Report"),
                                        style: FilledButton.styleFrom(
                                          surfaceTintColor: Colors.white,
                                          backgroundColor: Colors.white,
                                        ),
                                      )
                                    : FilledButton.tonalIcon(
                                        onPressed: () async {
                                          await commentsController.reportComment(commentId: controller.comments[index].id!);
                                        },
                                        icon:Icon(CupertinoIcons.info,color: AppColors().danger,),
                                        label: const AppText(text: "Report"),
                                        style: FilledButton.styleFrom(
                                          surfaceTintColor: Colors.white,
                                          backgroundColor: Colors.white,
                                        ),
                                      )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
                
              },
              itemCount: 2,
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
