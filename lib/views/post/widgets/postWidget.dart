import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/commentController.dart';
import 'package:mental_helth_wellness/controllers/postController.dart';
import 'package:mental_helth_wellness/customWidgets/appImage.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/customWidgets/cSpace.dart';
import 'package:mental_helth_wellness/models/userModel.dart';
import 'package:mental_helth_wellness/utils/appEnums.dart';
import 'package:mental_helth_wellness/utils/appExtensions.dart';
import 'package:mental_helth_wellness/utils/assetImages.dart';
import 'package:mental_helth_wellness/views/comment/commentScreen.dart';

import '../../../models/posts/postModel.dart';
import '../../../utils/appConst.dart';
import '../../../utils/appMethods.dart';
import '../../../utils/appString.dart';
import '../../../utils/spacing.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {

  const PostWidget({super.key, required this.post, required this.index});

  final Post post;
  final int index;

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find<PostController>();
    CommentsController commentsController = Get.find<CommentsController>();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8
      ),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1, 1),
            blurRadius: 5
          )
        ],
        borderRadius: BorderRadius.circular(15)
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header user data row
          Row(
            children: [
              // user profile image
              Container(
                height: 35,
                width: 35,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle
                ),
                child: AppImage(
                  imageType: post.postUser!.profileImage!=null ? ImageType.networkImage : ImageType.assetImage,
                  imagePath: post.postUser!.profileImage!=null ? post.postUser!.profileImage.toString() : AssetImages.appLogo,
                ),
              ),

              const CSpace(width: 16),
              
              // user name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text:AppConst().checkAnonymous(post.isAnonymous!)
                        ? post.postUser!.userName??"${post.postUser!.firstName!} ${post.postUser!.lastName!}"
                        : AppStrings.anonymousLabel,
                    ),
                    AppText(text: timeago.format(post.createdAt.toString().getDate()),fontSize: 10,)
                  ],
                ),
              ),
              
              PopupMenuButton<PostMenu>(
                surfaceTintColor: Colors.white,
                onSelected: (value)  async {
                  switch(value){
                    case PostMenu.report: {
                      AppMethods().showReportReasonDialog(title: AppStrings.reportPostDialogTitle, message: AppStrings.reportPostMessage, reportType: ReportType.post,data: {"postId":post.id});
                      break;
                    }
                    case PostMenu.delete: {
                      await postController.deleteMyPost(postId:post.id!,index:index);
                    }
                  }
                },
                itemBuilder: (context) {

                  if(post.postUser!.id == AppConst.userModel!.id!){
                    return <PopupMenuItem<PostMenu>>[
                      const PopupMenuItem(
                          value: PostMenu.delete,
                          child: AppText(text: "Delete"),

                      ),
                    ];
                  }
                  else{
                    return <PopupMenuItem<PostMenu>>[
                      const PopupMenuItem(
                          value: PostMenu.report,
                          child: AppText(text: "Report")
                      )
                    ];
                  }
                },
              )
            ],
          ),

          const CSpace(height: 8),

          // thought
         post.postText!= "" ? AppText(text: post.postText.toString()) : const CSpace(),

          const CSpace(height: 8),

          // description
          AppText(text: post.postDescription.toString()),

          const CSpace(height: 8),

          // image
          (post.imageUrl!=null && post.imageUrl != "" )   ? Center(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              clipBehavior: Clip.hardEdge,
              height: 280,
              child: AppImage(
                fit: BoxFit.fill,
                imageType: ImageType.networkImage,
                imagePath: post.imageUrl.toString(),
              ),
            ),
          ) : const CSpace(),

          CSpace(height: Spacing.getDefaultSpacing(context)),

          // bottom option row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // like button
                    Column(
                      children: [
                        InkWell(
                            onTap: () async {
                              // add like if post does not have element with user id
                              if(postController.hasLike(index:index)){
                                await postController.removeLike(index: index, postId: post.id!);
                              }else {
                                await postController.addLike(index: index, postId: post.id!);
                              }
                          },
                            child: Icon(postController.hasLike(index:index) ? CupertinoIcons.heart_fill : CupertinoIcons.heart,size: 30, color: postController.hasLike(index:index) ? Colors.red : Colors.black,),
                        ),
                        AppText(text: "${post.likes}")
                      ],
                    ),

                    const CSpace(width: 8),

                    // comment button
                    Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            bool isNewPostId = commentsController.postId != post.id!;
                            var result = await Get.to(()=>CommentScreen(postId:post.id!,isNewPostId:isNewPostId));
                            postController.updateCommentCountForPost(postId: post.id!,data:result,index:index);
                          },
                          child: const Icon(CupertinoIcons.chat_bubble,size: 30),
                        ),
                        AppText(text: post.comments.toString())
                      ],
                    ),
                  ],
                ),


                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // save button
                    Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            // if post is saved remove it from the list
                            if(postController.isSaved(index: index)){
                              await postController.removePost(
                                  index: index, postId: post.id!);
                            }
                            // if post is not saved add
                            else{
                              await postController.savePost(
                                  index: index, postId: post.id!);
                            }
                          },
                          child: Icon(
                              postController.isSaved(index: index)
                                  ? CupertinoIcons.bookmark_fill
                                  : CupertinoIcons.bookmark,
                              size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
