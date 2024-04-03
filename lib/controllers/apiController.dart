import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mental_helth_wellness/utils/apiUrls.dart';
import 'package:mental_helth_wellness/utils/cacheKeys.dart';
import 'package:mental_helth_wellness/utils/localStorage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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

  // function to get posts
  Future<Response> getPosts({required Map<String, dynamic> data}) async {
    // var headers = {"Accept":accept};
    var headers = <String,dynamic>{};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.get(ApiUrls.getPostPath,options: Options(headers: headers),data: data);
    return response;
  }

  Future<Response> createPosts({required Map<String, dynamic> data}) async {
    // var headers = {"Accept":accept};
    var headers = <String,dynamic>{};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.post(ApiUrls.createPostPath,options: Options(headers: headers),data: data);
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

  Future<Response> savePost({required Map<String, int> data}) async {
    var headers = <String,dynamic>{"Accept":accept};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.post(ApiUrls.savePostUrl,options: Options(headers: headers),data: data);
    return response;
  }

  Future<Response> removeSavedPost({required Map<String, int> data}) async {
    var headers = <String,dynamic>{"Accept":accept};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.post(ApiUrls.removeSavedPostUrl,options: Options(headers: headers),data: data);
    return response;
  }

  Future<Response> getCommentsForPost({required Map<String, dynamic> data}) async {
    var headers = <String,dynamic>{"Accept":accept};
    headers['Authorization'] = (await authToken())!;
    var response = await dio.post(ApiUrls.getPostCommentsPath,options: Options(headers: headers),data: data);
    return response;
  }
}
