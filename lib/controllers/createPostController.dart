import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/apiController.dart';
import 'package:mental_helth_wellness/controllers/authController.dart';
import 'package:mental_helth_wellness/utils/appMethods.dart';

class CreatePostController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  Future<void> createPosts({
    required String title,
    required String content,
    required File? imageFile,
    required bool isAnonymous,
  }) async {
    AppMethods.showLoading();

    try {
      final int userId = _authController.userModel?.id ?? 0;

      dio.FormData formData = dio.FormData.fromMap({
        'users_id': userId,
        'postText': title,
        'postDescription': content,
        'isAnonymous': isAnonymous ? 1 : 0,
        'likes': 0,
        'postStatus': 1,
      });

      if (imageFile != null) {
        formData.files.add(MapEntry(
          'imageUrl',
          await dio.MultipartFile.fromFile(
            imageFile.path,
          ),
        ));
      }

      var response = await ApiController().createPost(data: formData);

      if (response.statusCode == 200) {
        AppMethods.showToast(message: "Post created successfully");
      } else {
        AppMethods.showToast(message: "Failed to create post");
      }
    } on dio.DioError catch (error) {
      print("API Error: $error");
      AppMethods.showToast(
          message: "Failed to create post. Please try again later.");
    } finally {
      AppMethods.dismissLoading();
    }
  }
}
