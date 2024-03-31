import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/models/comment/commentLikeModal.dart';
import 'package:mental_helth_wellness/models/comment/commentModal.dart';
import 'package:mental_helth_wellness/models/userModel.dart';

import '../utils/appAnimations.dart';
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


  // function to get posts
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

}