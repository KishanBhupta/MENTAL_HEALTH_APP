/*
* File to add methods which are used in this app multiple times from different screens or controllers
* */

import 'dart:ui';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/utils/appColors.dart';
import 'package:mental_helth_wellness/utils/appEnums.dart';

import '../views/sharedWidgets/reportReasonDialog.dart';

class AppMethods {

  // function to show custom loading
  static void showLoading({String? message}){
    EasyLoading.instance
      ..textAlign = TextAlign.center
      ..userInteractions = false
      ..animationStyle = EasyLoadingAnimationStyle.opacity
      ..toastPosition = EasyLoadingToastPosition.bottom
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
      EasyLoading.showToast(message);
    }
  }


  Future showReportReasonDialog({required String title,required String message,required ReportType reportType,required Map<String,dynamic> data}) async {
    Get.dialog(
      ReportReasonDialog(title: title,message: message,reportType: reportType,data: data),
      barrierDismissible: false
    );
  }
}