import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/commentController.dart';
import 'package:mental_helth_wellness/customWidgets/appImage.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/customWidgets/appTextField.dart';
import 'package:mental_helth_wellness/customWidgets/cSpace.dart';
import 'package:mental_helth_wellness/utils/appColors.dart';
import 'package:mental_helth_wellness/utils/appEnums.dart';
import 'package:mental_helth_wellness/utils/appExtensions.dart';
import 'package:mental_helth_wellness/utils/appMethods.dart';
import 'package:mental_helth_wellness/utils/spacing.dart';
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

  TextEditingController commentTextController = TextEditingController();
  ValueNotifier<bool> isAnonymous = ValueNotifier(false);

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
        title: const AppText(text: AppStrings.commentsScreenTitle,fontSize: 20,fontWeight: FontWeight.w800),
      ),
      body: GetBuilder<CommentsController>(
        builder: (controller) {
          if(controller.comments.isEmpty){
            return const Center(
              child: AppText(
                text: AppStrings.noCommentsLabel,
              ),
            );
          }else{
            return ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: Spacing.getDefaultSpacing(context),right: Spacing.getDefaultSpacing(context),bottom: 80),
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          imageType:AppConst().checkAnonymous(controller.comments[index].isAnonymous!) ?  ImageType.assetImage : controller.comments[index].commentUser!.profileImage!=null ? ImageType.networkImage : ImageType.assetImage,
                          imagePath:AppConst().checkAnonymous(controller.comments[index].isAnonymous!) ?  AssetImages.appLogo : controller.comments[index].commentUser!.profileImage!=null ? controller.comments[index].commentUser!.profileImage.toString() : AssetImages.appLogo,
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
                                      ? AppStrings.anonymousLabel
                                      : controller.comments[index].commentUser!.userName??"${controller.comments[index].commentUser!.firstName!} ${controller.comments[index].commentUser!.lastName!}",
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
                                        onPressed: () async {
                                          await commentsController.deleteMyComment(commentId:controller.comments[index].id!,index:index);
                                        },
                                        icon:Icon(CupertinoIcons.trash,color: AppColors().danger,),
                                        label: const AppText(text: "Delete"),
                                        style: FilledButton.styleFrom(
                                          surfaceTintColor: Colors.white,
                                          backgroundColor: Colors.white,
                                        ),
                                      )
                                    : FilledButton.tonalIcon(
                                        onPressed: () async {
                                          AppMethods().showReportReasonDialog(title: AppStrings.reportCommentDialogTitle, message: AppStrings.reportCommentMessage, reportType: ReportType.comment,data: {"commentId":controller.comments[index].id!});
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
              itemCount: controller.comments.length,
            );
          }
        },
      ),
      floatingActionButton: ValueListenableBuilder(
          valueListenable: isAnonymous,
        builder: (context,value,child) {
          return Container(
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                  )
                ]
            ),
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: Spacing.getDefaultSpacing(context)),
            margin: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context)),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: isAnonymous.value ? const AppImage(imageType: ImageType.assetImage, imagePath: AssetImages.appLogo) : AppImage(imageType: ImageType.networkImage, imagePath: AppConst.userModel!.profileImage.toString()),
                ),

                CSpace(width: Spacing.getDefaultSpacing(context)),

                Expanded(
                    child: AppTextField(
                      controller: commentTextController,
                      validator: (comment){
                        return null;
                      },
                      isDense: true,
                      consistentBorderColor: AppColors().primaryColor,
                      isConsistentBorderColor: true,
                      borderType: BorderType.underlineBorder,
                      isBorderEnabled: true,
                      hintText: "Comment as ${ value ? "Anonymous" : AppConst.userModel!.userName}",
                    )
                ),

                CSpace(width: Spacing.getDefaultSpacing(context)),

                InkWell(
                  onTap: (){
                    isAnonymous.value = !isAnonymous.value;
                  },
                  child: const Icon(Icons.swap_horiz),
                ),

                CSpace(width: Spacing.getDefaultSpacing(context)),

                InkWell(
                  onTap: () async {
                    if(commentTextController.text.toString().isNotEmpty) {
                      await commentsController.addCommentToPost(postId:widget.postId,comment: commentTextController.text.toString(),isAnonymous: isAnonymous.value);
                      commentTextController.clear();
                    }
                  },
                  child: Icon(Icons.send,color: AppColors().primaryColor),
                )
              ],
            ),
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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

