import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mental_helth_wellness/utils/apiUrls.dart';
import 'package:mental_helth_wellness/utils/cacheKeys.dart';
import 'package:mental_helth_wellness/utils/localStorage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiController {
  /*
  * */
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
  // Future<String?> authToken() async {
  //   String? token = LocalStorage().getStringValue(key: CacheKeys.accessToken);
  //   return "Bearer $token";
  // }

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
}
