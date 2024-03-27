import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/apiController.dart';
import 'package:mental_helth_wellness/models/userModel.dart';
import 'package:mental_helth_wellness/utils/appAnimations.dart';
import 'package:mental_helth_wellness/utils/appConst.dart';
import 'package:mental_helth_wellness/utils/cacheKeys.dart';
import 'package:mental_helth_wellness/utils/localStorage.dart';
import 'package:mental_helth_wellness/views/auth/loginScreen.dart';
import 'package:mental_helth_wellness/views/home/mainScreen.dart';

class SplashScreenController extends GetxController {

  // function to check the current authentication state
  Future<void> checkCurrentAuthState() async {
    // shared pref contains access token key
    if(LocalStorage().hasKey(key: CacheKeys.accessToken)){
      try {
        var accessToken = LocalStorage().getStringValue(key: CacheKeys.accessToken);
        if(accessToken != null){
          // check the auth token in database and login user
          var response = await ApiController().getCurrentLoggedInUser();
          if(response.statusCode == 200 && response.data!=null){
            UserModel userModel = UserModel.fromJSON(response.data);
            AppConst.userModel ??= userModel;
            if(AppConst.userModel!=null){
              Get.to(()=>const MainScreen());
            }
          }
        }
      } on DioException catch (error) {
        if(error.type == DioExceptionType.badResponse){
          if(error.response!.statusCode == 401){
            Get.offAll(()=>const LoginScreen(),transition: AppAnimations.appNavigationTransition,duration: AppAnimations.appNavigationTransitionDuration);
          }
        }else {
          debugPrint("Error While Login : $error");
        }
      }
    }
    // shared pref doesn't contain access token key
    else{
      Get.to(()=>const LoginScreen());
    }
  }

}