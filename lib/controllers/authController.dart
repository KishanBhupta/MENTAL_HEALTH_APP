import 'package:dio/dio.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/apiController.dart';
import 'package:mental_helth_wellness/utils/appMethods.dart';
import 'package:mental_helth_wellness/utils/cacheKeys.dart';
import 'package:mental_helth_wellness/utils/localStorage.dart';
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

}
