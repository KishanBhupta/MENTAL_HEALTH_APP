import 'package:dio/dio.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/apiController.dart';
import 'package:mental_helth_wellness/utils/appMethods.dart';
import 'package:mental_helth_wellness/utils/cacheKeys.dart';
import 'package:mental_helth_wellness/utils/localStorage.dart';
import 'package:mental_helth_wellness/views/auth/loginScreen.dart';
import 'package:mental_helth_wellness/views/home/homeScreen.dart';

import '../models/userModel.dart';
import '../utils/appConst.dart';

class AuthController {

  UserModel? userModel;

  // function to login user
  Future<void> login({required String email, required String password}) async {
    var data = {"email": email, "password": password};
    AppMethods.showLoading(message: "Checking Credentials");
    api.Response response = await ApiController().login(data: data);
    if(response.statusCode == 200){
      userModel = UserModel.fromJSON(response.data['user']);
      await LocalStorage().setStringValue(key: CacheKeys.accessToken, value: response.data['token']);
      AppConst().currentAccessToken = response.data['token'];
      Get.to(()=>const HomeScreen());
    }
    AppMethods.dismissLoading();
  }

  // function to register user
  Future<void> register(
      {required String firstName, required String lastName,
        required String email, required String password, required String phoneNumber}
      ) async {

    var data = {
      "firstName":firstName,
      "lastName":lastName,
      "email":email,
      "password":password,
      "phoneNumber":phoneNumber,
      "isBlocked":false
    };

    try {
      AppMethods.showLoading(message: "Creating Account");
      api.Response response = await ApiController().registerUser(data:data);
      if(response.statusCode == 200){
        EasyLoading.showToast("${response.data['message']}, Please Login To Continue.");
        Get.offAll(()=>const LoginScreen());
      }
      AppMethods.dismissLoading();
    } on api.DioException catch(error) {
      EasyLoading.showToast(error.message??"Something went wrong try again later.");
    }
  }

}
