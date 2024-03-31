import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/apiController.dart';
import 'package:mental_helth_wellness/models/posts/subSavedPostModal.dart';
import 'package:mental_helth_wellness/utils/appMethods.dart';
import 'package:mental_helth_wellness/utils/appString.dart';

import '../models/posts/postLikeModal.dart';
import '../models/posts/postModel.dart';
import '../utils/appAnimations.dart';
import '../utils/appConst.dart';
import '../views/auth/loginScreen.dart';

class PostController extends GetxController {

  // all post variables
  List<Post> posts = [];
  int page = 1;
  bool hasNext = true;
  Map<String,dynamic> getPostData = {};


  // function to get posts
  Future<void> getPosts() async {
    AppMethods.showLoading();
    getPostData['page'] = page;
    if(page == 1){
      posts.clear();
    }
    try {
      var response = await ApiController().getPosts(data:getPostData);
      if(response.statusCode == 200){
        if(response.data!=null){
          // getting posts
          for(var post in response.data['data']){
            var data = Post.fromJson(post);
            post['with_likes'].forEach((element) => data.postLikes.add(PostLike.fromJson(element)));
            post['get_saved_post'].forEach((element) => data.postSave.add(SubSavedPost.fromJson(element)));
            posts.add(data);
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

  // function to add like to post
  Future<void> addLike({required int index, required int postId}) async {
    try {
      var data = {"post_id":postId,"user_id":AppConst.userModel!.id!};
      var response = await ApiController().addLikeToPost(postId: postId,data:data);
      if(response.statusCode == 200){
        if(posts[index].likes!=null){
          posts[index].likes = posts[index].likes! + 1;
          posts[index].postLikes.add(PostLike(postsId: postId,usersId: AppConst.userModel!.id!));
        }
      }
      update();
    } on DioException catch (error) {
      if(error.response!.statusCode == 401){
        Get.offAll(()=>const LoginScreen(),transition: AppAnimations.appNavigationTransition,duration: AppAnimations.appNavigationTransitionDuration);
      }
    }
  }

  Future<void> removeLike({required int index, required int postId}) async {
    try {
      var data = {"post_id":postId,"user_id":AppConst.userModel!.id!};
      var response = await ApiController().removeLikeFromPost(postId: postId,data:data);
      if(response.statusCode == 200){
        if(posts[index].likes!=null){
          posts[index].likes = posts[index].likes! - 1;
          posts[index].postLikes.removeWhere((element) => element.usersId == AppConst.userModel!.id!);
        }
      }
      update();
    } on DioException catch (error) {
      if(error.response!.statusCode == 401){
        Get.offAll(()=>const LoginScreen(),transition: AppAnimations.appNavigationTransition,duration: AppAnimations.appNavigationTransitionDuration);
      }
    }
  }

  // function to save the post
  Future<void> savePost({required int index, required int postId}) async {
    var data = {
      "users_id":AppConst.userModel!.id!,
      "posts_id":postId
    };
    try {
      var response = await ApiController().savePost(data:data);

      if(response.statusCode == 200){
        posts[index].postSave.add(SubSavedPost(usersId: AppConst.userModel!.id!,postsId: postId));
        AppMethods.showToast(message: AppStrings.postSavesMessage);
      }
    } on DioException catch (error) {
      if(error.response!.statusCode == 401){
        Get.offAll(()=>const LoginScreen(),transition: AppAnimations.appNavigationTransition,duration: AppAnimations.appNavigationTransitionDuration);
      }else{
        AppMethods.showToast(message: AppStrings.postSaveError);
      }
    }
    update();
  }

  Future<void> removePost({required int index, required int postId}) async {
    var data = {
      "users_id":AppConst.userModel!.id!,
      "posts_id":postId
    };
    try {
      var response = await ApiController().removeSavedPost(data:data);

      if(response.statusCode == 200){
        posts[index].postSave.removeWhere((element)=>element.usersId==AppConst.userModel!.id!);
      }
    } on DioException catch (error) {
      if(error.response!.statusCode == 401){
        Get.offAll(()=>const LoginScreen(),transition: AppAnimations.appNavigationTransition,duration: AppAnimations.appNavigationTransitionDuration);
      }else{
        AppMethods.showToast(message: AppStrings.postSaveError);
      }
    }
    update();
  }

  // function to check if post contains user likes
  bool hasLike({required int index}) {
    return posts[index].postLikes.any((element) => element.usersId == AppConst.userModel!.id);
  }

  // function to check if post save list contains user id
  bool isSaved({required int index}){
    return posts[index].postSave.any((element) => element.usersId == AppConst.userModel!.id);
  }

}