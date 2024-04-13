import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/apiController.dart';
import 'package:mental_helth_wellness/controllers/authController.dart'; // Import the AuthController
import 'package:mental_helth_wellness/utils/appConst.dart';
import 'package:mental_helth_wellness/utils/appMethods.dart';

class CreatePostController extends GetxController {
  // final AuthController _authController = Get.find<AuthController>(); // Get the AuthController instance


  Future<void> createPosts({
    required String title,
    required String content,
    required String imageUrl,
    required bool isAnonymous,
  }) async {
    AppMethods.showLoading();

    try {
      // Retrieve the userId of the currently logged-in user from AuthController
      // final int userId = _authController.userModel?.id ?? 0;

      var postData = {
        'users_id': AppConst.userModel!.id,
        'imageUrl': imageUrl,
        'postText': title,
        'postDescription': content,
        'isAnonymous': isAnonymous ? 1 : 0,
        'likes': 0,
        'postStatus': 1,
      };

      var response = await ApiController().createPost(data: postData);
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
      AppMethods.showToast(
          message: "Failed to create post. Please try again later.");
    } finally {
      // Dismiss loading indicator
      AppMethods.dismissLoading();
    }
  }
}
