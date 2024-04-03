import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/models/comment/commentLikeModal.dart';
import 'package:mental_helth_wellness/models/comment/commentModal.dart';
import 'package:mental_helth_wellness/models/userModel.dart';
import 'package:mental_helth_wellness/utils/appExtensions.dart';
import 'package:mental_helth_wellness/utils/appString.dart';

import '../utils/appAnimations.dart';
import '../utils/appConst.dart';
import '../utils/appMethods.dart';
import '../views/auth/loginScreen.dart';
import 'apiController.dart';

class CommentsController extends GetxController {

  // all comment variable
  int postId = 0;
  List<Comment> comments = [];
  int page = 1;
  bool hasNext = true;
  Map<String,dynamic> getCommentData = {};


  // function to get commments

  Future<void> getComments({required int id}) async {
    AppMethods.showLoading();
    getCommentData['post_id'] = id;
    getCommentData['page'] = page;
    if(page == 1){
      comments.clear();
    }
    try {
      var response = await ApiController().getCommentsForPost(data:getCommentData);
      if(response.statusCode == 200){
        if(response.data!=null){
          // getting posts
          for(var comment in response.data['data']){
            var data = Comment.fromJson(comment);
            data.commentUser = UserModel.fromJSON(comment['comment_user']);
            comment['with_likes'].forEach((element) => data.commentLikes.add(CommentLike.fromJson(element)));
            comments.add(data);
          }
          // checking if api response contains next page url , if not then set hasNext false
          if(response.data['next_page_url']==null) {
            hasNext = false;
          }
        }
      }
    } on DioException catch (error) {
      print("Api Error : $error");
      if(error.response!.statusCode == 401){
        Get.offAll(()=>const LoginScreen(),transition: AppAnimations.appNavigationTransition,duration: AppAnimations.appNavigationTransitionDuration);
      }
    }
    update();
    AppMethods.dismissLoading();
  }

  // function to add like in comment

  Future addLikeToComment({required int commentId, required int index}) async {
    try {
      var data = {
        "user_id": AppConst.userModel!.id,
        "comment_id": commentId
      };

      var response = await ApiController().addLikeToComment(data: data);
      
      if(response.statusCode == 200){
        comments[index].commentLikes.add(CommentLike(usersId: AppConst.userModel!.id!,commentId: commentId));
        comments[index].likes = (comments[index].likes??0) + 1;
      }
    }
    on DioException catch (error) {
      print("Api Error : $error");
      if (error.response!.statusCode == 401) {
        Get.offAll(() => const LoginScreen(),transition: AppAnimations.appNavigationTransition,duration: AppAnimations.appNavigationTransitionDuration);
      }
    }
    update();
  }

  // function to remove like from comment

  Future removeLikeFromComment({required int commentId, required int index}) async {
    try {
      var data = {
        "user_id": AppConst.userModel!.id,
        "comment_id": commentId
      };

      var response = await ApiController().removeLikeFromComment(data: data);

      if(response.statusCode == 200){
        comments[index].commentLikes.removeWhere((element) => element.usersId! == AppConst.userModel!.id!);
        comments[index].likes = (comments[index].likes??1) - 1;
      }
    }
    on DioException catch (error) {
      print("Api Error : $error");
      if (error.response!.statusCode == 401) {
        Get.offAll(() => const LoginScreen(),transition: AppAnimations.appNavigationTransition,duration: AppAnimations.appNavigationTransitionDuration);
      }
    }
    update();
  }

  // function to report a comment
  Future reportComment({required int commentId, required String reason}) async {
    try {
      var data = {
        "reportedCommentId":commentId,
        "reporterReason":reason,
        "userId":AppConst.userModel!.id!
      };
      var response = await ApiController().reportComment(data:data);
      if(response.statusCode == 200){
        AppMethods.showToast(message: "Report has been submitted !!");
      }
    } on DioException catch(error) {
      if (error.response!.statusCode == 401) {
        Get.offAll(() => const LoginScreen(),transition: AppAnimations.appNavigationTransition,duration: AppAnimations.appNavigationTransitionDuration);
      }
    }
  }


  // function
  Future<void> addCommentToPost({required int postId, required String comment, required bool isAnonymous}) async {
    try {
      var data = {
        "users_id" : AppConst.userModel!.id!,
        "post_id"  : postId,
        "commentDescription" : comment,
        "isAnonymous" : isAnonymous
      };
      var response = await ApiController().addCommentToPost(data:data);
      if(response.statusCode == 200){
        page = 1;
        await getComments(id: postId);
      }else {
        AppMethods.showToast(message: AppStrings.commentAddError);
      }
    } on DioException catch(error) {
      if (error.response!.statusCode == 401) {
        Get.offAll(() => const LoginScreen(),transition: AppAnimations.appNavigationTransition,duration: AppAnimations.appNavigationTransitionDuration);
      }
    }
  }

  // function to delete user's own comment
  Future<void> deleteMyComment({required int commentId, required int index}) async {
    try {
      var response = await ApiController().deleteMyComment(commentId:commentId);
      if(response.statusCode == 200){
        comments.removeAt(index);
      }
    } on DioException catch(error) {
      if (error.response!.statusCode == 401) {
        Get.offAll(() => const LoginScreen(),transition: AppAnimations.appNavigationTransition,duration: AppAnimations.appNavigationTransitionDuration);
      }
    }
    update();
  }

  // function to check if post contains user likes
  bool hasLike({required int index}) {
    return comments[index].commentLikes.any((element) => element.usersId == AppConst.userModel!.id);
  }

  
}