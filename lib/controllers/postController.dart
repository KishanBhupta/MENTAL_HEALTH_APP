import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/apiController.dart';
import 'package:mental_helth_wellness/utils/appMethods.dart';

import '../models/postModel.dart';

class PostController extends GetxController {
  @override
  onInit() {
    super.onInit();
    getPosts();
  }


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
    var response = await ApiController().getPosts(data:getPostData);
    if(response.statusCode == 200){
      if(response.data!=null){
        // getting posts
        for(var post in response.data['data']){
          posts.add(Post.fromJson(post));
        }
        // checking if api response contains next page url , if not then set hasNext false
        if(response.data['next_page_url']==null) {
          hasNext = false;
        }
      }
    }
    AppMethods.dismissLoading();
  }

}