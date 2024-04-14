import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mental_helth_wellness/utils/apiUrls.dart';
import 'package:mental_helth_wellness/utils/cacheKeys.dart';
import 'package:mental_helth_wellness/utils/localStorage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;

class ApiController {

  static Dio dio = Dio()
    ..interceptors.add(PrettyDioLogger(
        compact: false,
        logPrint: (object) {
          debugPrint(object.toString());
        },
        request: true,
        error: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));

  static String accept = "application/json";

  // function to get user's access token
  Future<String?> authToken() async {
    String? token = LocalStorage().getStringValue(key: CacheKeys.accessToken);
    return "Bearer $token";
  }

  // function to login user
  Future<Response> login({required Map<String, dynamic> data}) async {
    var headers = {"Accept": accept};
    Response response = await dio.post(ApiUrls.loginPath,data: data,options: Options(headers: headers, contentType: accept));
    return response;
  }

  Future<Response> registerUser({required Map<String, Object> data}) async {
    var headers = {"Accept":accept};
    Response response = await dio.post(ApiUrls.registerPath,data:data, options: Options(headers: headers, contentType: accept));
    return response;
  }

  Future<Response> getCurrentLoggedInUser() async {
    var headers = {"Accept":accept};
    headers['Authorization'] = (await authToken())!;
    Response response = await dio.get(ApiUrls.getCurrentUserPath, options: Options(headers: headers));
    return response;
  }


  Future<Response> createPost({
    required FormData data,
  }) async {
    var headers = {
      "Accept": accept,
      "Authorization": await authToken(),
    };
    var response = await dio.post(
      ApiUrls.createPostPath,
      options: Options(headers: headers),
      data: data,
    );
    return response;
  }

  // function to get posts
  Future<Response> getPosts({required Map<String, dynamic> data}) async {
    // var headers = {"Accept":accept};
    var headers = <String,dynamic>{};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.get(ApiUrls.getPostPath,options: Options(headers: headers),data: data);
    return response;
  }

  // function to add like to post
  Future<Response> addLikeToPost({required int postId,required Map<String,dynamic> data}) async {
    var headers = <String,dynamic>{"Accept":accept};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.post(ApiUrls.addPostLikePath,options: Options(headers: headers),data: data);
    return response;
  }

  // function to remove like from post
  Future<Response> removeLikeFromPost({required int postId, required Map<String, int> data}) async {
    var headers = <String,dynamic>{"Accept":accept};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.post(ApiUrls.removePostLikePath,options: Options(headers: headers),data: data);
    return response;
  }

  // function to save post
  Future<Response> savePost({required Map<String, int> data}) async {
    var headers = <String,dynamic>{"Accept":accept};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.post(ApiUrls.savePostUrl,options: Options(headers: headers),data: data);
    return response;
  }

  // function to remove saved post
  Future<Response> removeSavedPost({required Map<String, int> data}) async {
    var headers = <String,dynamic>{"Accept":accept};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.post(ApiUrls.removeSavedPostUrl,options: Options(headers: headers),data: data);
    return response;
  }

  // function to get comment for post
  Future<Response> getCommentsForPost({required Map<String, dynamic> data}) async {
    var headers = <String,dynamic>{"Accept":accept};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.post(ApiUrls.getPostCommentsPath,options: Options(headers: headers),data: data);
    return response;
  }

  // function to add like to comment
  Future<Response> addLikeToComment({required Map<String, int?> data}) async {
    var headers = <String,dynamic>{"Accept":accept};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.post(ApiUrls.addCommentLikePath,options: Options(headers: headers),data: data);
    return response;
  }

  Future<Response> removeLikeFromComment({required Map<String, int?> data}) async {
    var headers = <String,dynamic>{"Accept":accept};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.post(ApiUrls.removeCommentLikePath,options: Options(headers: headers),data: data);
    return response;
  }

  // function to report a comment
  Future<Response> reportComment({required Map<String, Object> data}) async {
    var headers = <String,dynamic>{"Accept":accept};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.post(ApiUrls.reportCommentPath,options: Options(headers: headers),data: data);
    return response;
  }

  Future<Response> reportPost({required Map<String, dynamic> data}) async {
    var headers = <String,dynamic>{"Accept":accept};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.post(ApiUrls.reportPostPath,options: Options(headers: headers),data: data);
    return response;
  }

  // function to add comment to post
  Future<Response> addCommentToPost({required Map<String, Object> data}) async {
    var headers = <String,dynamic>{"Accept":accept};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.post(ApiUrls.addCommentPath,options: Options(headers: headers),data: data);
    return response;
  }

  // function to delete user's own comment
  Future<Response> deleteMyComment({required int commentId}) async {
    var headers = <String,dynamic>{"Accept":accept};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.get("${ApiUrls.deleteCommentPath}/$commentId",options: Options(headers: headers));
    return response;
  }

  // function to delete user's own post
  Future<Response> deleteMyPost({required int postId}) async {
    var headers = <String,dynamic>{"Accept":accept};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.get("${ApiUrls.deleteUserPostPath}/$postId",options: Options(headers: headers));
    return response;
  }

  // function to search user profile
  Future<Response> searchUser(Map<String, String> map) async {
    var headers = <String,dynamic>{"Accept":accept};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.post(ApiUrls.searchProfilesPath,options: Options(headers: headers),data: map);
    return response;
  }

  // Method to get user's profile posts
  Future<Response> getMyProfilePosts(int userId, int page) async {
    try {
      var response = await dio.get(ApiUrls.getMyProfilePostsPath, queryParameters: {'id': userId, 'page': page});
      return response;
    } catch (error) {
      throw error;
    }
  }


// updateUserProfile({required Map<String, dynamic> data}) {}
  Future<Response> updateUserProfile({
    required int id,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
  }) async {
    var headers = {
      "Accept": accept,
      "Authorization": await authToken(),
    };
    var formData = {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
    var response = await dio.post(
      ApiUrls.updateUserProfilePath, // Replace with your actual endpoint
      options: Options(headers: headers),
      data: formData,
    );
    return response;
  }
  //
  Future<Response> changePassword({required int id, required String oldPassword, required String newPassword}) async {
    try {
      var headers = {
        "Accept": accept,
        "Authorization": await authToken(),
      };

      // Validate the new password format
      if (!_isValidPasswordFormat(newPassword)) {
        throw Exception('New password must be 6-8 characters long and contain at least one uppercase letter and one number');
      }

      // Create the request body
      var requestBody = {
        'id': id,
        'oldPassword': oldPassword,
        'password': newPassword,
      };

      // Make the API call
      var response = await dio.post(
        ApiUrls.changePasswordPath,
        options: Options(headers: headers),
        data: requestBody,
      );

      return response;
    } catch (error) {
      throw error;
    }
  }

  bool _isValidPasswordFormat(String password) {
    // Password must be 6-8 characters long and contain at least one uppercase letter and one number
    final RegExp passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9]).{6,8}$');
    return passwordRegExp.hasMatch(password);
  }

  Future<Response> storeFeedback({
    required int userId,
    required String feedbackData,
  }) async {
    try {
      var headers = {
        "Accept": accept,
        "Access Token": await authToken(),
        "Content-Type": "application/json",
      };

      var requestBody = {
        'users_id': userId,
        'feedbackData': feedbackData,
      };

      var response = await dio.post(
        ApiUrls.saveFeedbackPath,
        options: Options(headers: headers),
        data: jsonEncode(requestBody),
      );

      return response;
    } catch (error) {
      throw error;
    }
  }



// Future<Response> getMyProfilePosts({required Map<String, dynamic> data}) async {
  //   // var headers = {"Accept":accept};
  //   var headers = <String,dynamic>{};
  //   headers['Authorization'] = (await authToken())!;
  //   var response = await dio.get(ApiUrls.getPostPath,options: Options(headers: headers),data: data);
  //   return response;
  // }

}
