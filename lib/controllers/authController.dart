import 'package:dio/dio.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/apiController.dart';
import 'package:mental_helth_wellness/utils/appMethods.dart';
import 'package:mental_helth_wellness/utils/cacheKeys.dart';
import 'package:mental_helth_wellness/utils/localStorage.dart';
import 'package:mental_helth_wellness/views/auth/loginScreen.dart';
import 'package:mental_helth_wellness/views/mainScreen/mainScreen.dart';

import '../models/userModel.dart';
import '../utils/appConst.dart';

class AuthController extends GetxController {

  UserModel? userModel;
  Map<String, dynamic>? userData; // Define userData property to store user data


  // function to login user
  Future<void> login({required String email, required String password}) async {
    var data = {"email": email, "password": password};
    AppMethods.showLoading(message: "Checking Credentials");
    api.Response response = await ApiController().login(data: data);
    try {
      if (response.statusCode == 200) {
        userModel = UserModel.fromJSON(response.data['user']);
        await LocalStorage().setStringValue(
            key: CacheKeys.accessToken, value: response.data['token']);
        AppConst().currentAccessToken = response.data['token'];
        AppConst.userModel = userModel;
        Get.offAll(() => const MainScreen());
      }
    }
    on api.DioException catch(error) {
    if(error.response != null){
      if(error.response!.statusCode == 422){

      AppMethods.showToast(message: error.response!.data['message'],isError: true);

      }
    }
    else  {
        AppMethods.showToast(message: error.response!.data['message'],isError: true);
      }
    }



    AppMethods.dismissLoading();
  }

  // function to register user
  Future<void> register(
      {required String firstName, required String lastName,
        required String email, required String password, required String phoneNumber, required String userName}
      ) async {

    var data = {
      "firstName":firstName,
      "lastName":lastName,
      "email":email,
      "password":password,
      "phoneNumber":phoneNumber,
      "userName":userName,
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
      if(error.response != null){
        if(error.response!.statusCode == 422){
          // EasyLoading.showToast(message: error.response!.data['message'],isError: true);
          AppMethods.showToast(message: error.response!.data['message'],isError: true);
        }
      } else {
        EasyLoading.showToast(error.message??"Something went wrong try again later.");
      }
    }
  }
// Fetch user data from the server
  // Fetch user data from the server
  Future<void> fetchUserData() async {
    try {
      AppMethods.showLoading(message: "Fetching User Data");
      api.Response response = await ApiController().getCurrentLoggedInUser();
      if (response.statusCode == 200) {
        userModel = UserModel.fromJSON(response.data);
      }
    } catch (error) {
      EasyLoading.showToast("Failed to fetch user data");
    } finally {
      AppMethods.dismissLoading();
    }
  }

}
