import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/apiController.dart';
import 'package:mental_helth_wellness/models/posts/postModel.dart';
import 'package:mental_helth_wellness/utils/appMethods.dart';
import 'package:mental_helth_wellness/utils/appString.dart';

class CreatePostController extends GetxController {
  // Function to create a new post
  Future<void> createPosts({
    required String title,
    required String content,
    required String image,
    required bool anonymous,
    required int userId, // Add userId parameter
  }) async {
    AppMethods.showLoading();

    try {
      var postData = {
        'postText': title,
        'postDescription': content,
        'imageUrl': image,
        'isAnonymous': anonymous ? 1 : 0,
        'user_id': userId, // Pass the userId to the postData
      };

      var response = await ApiController().createPosts(data: postData);

      if (response.statusCode == 200) {
        // If post created successfully, show a toast message
        AppMethods.showToast(message: "Post created successfully");
        // Optionally, you can navigate to a different screen or perform any other action here
      } else {
        // If there was an error creating the post, show a toast message
        AppMethods.showToast(message: "Failed to create post");
      }
    } on DioError catch (error) {
      print("API Error: $error");
      // Handle API errors
      AppMethods.showToast(message: "Failed to create post. Please try again later.");
    } finally {
      // Dismiss loading indicator
      AppMethods.dismissLoading();
    }
  }
}
