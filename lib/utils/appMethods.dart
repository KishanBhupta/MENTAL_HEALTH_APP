/*
* File to add methods which are used in this app multiple times from different screens or controllers
* */

import 'dart:ui';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mental_helth_wellness/utils/appColors.dart';

class AppMethods {

  // function to show custom loading
  static void showLoading({String? message}){
    EasyLoading.instance
      ..textAlign = TextAlign.center
      ..toastPosition = EasyLoadingToastPosition.center
      ..userInteractions = false
      ..animationStyle = EasyLoadingAnimationStyle.opacity
      ..indicatorType = EasyLoadingIndicatorType.hourGlass
      ..backgroundColor = AppColors().primaryColor;

    EasyLoading.show(
      status: message??"Loading",
    );
  }

  // function to dismiss loading
  static void dismissLoading() {
    EasyLoading.dismiss(animation:true);
  }

  static void showToast({ required String message,bool isError = false}) {
    if(isError){
      EasyLoading.showError(message);
    }else{
      EasyLoading.showInfo(message);
    }
  }

}