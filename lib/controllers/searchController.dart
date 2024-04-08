import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/apiController.dart';
import 'package:mental_helth_wellness/models/userModel.dart';

import '../utils/appMethods.dart';

class SearchQueryController extends GetxController {
  List<UserModel> users = [];

  // function to search new query
  Future<void> searchNewUsers({required String query}) async {
    users.clear();
    AppMethods.showLoading(message: "Searching");

    try {

      var response = await ApiController().searchUser({'search':query});

      if(response.statusCode == 200){
        for (var user in response.data){
          users.add(UserModel.fromJSON(user));
        }
      }

    } on DioException catch (error) {
      print(error);
      if(error.response != null){
        if(error.response!.statusCode == 422){
          AppMethods.showToast(message: error.response!.data['message'],isError: true);
        }
      }
    }
    update();
    AppMethods.dismissLoading();
  }
}