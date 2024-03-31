/*
* File to add constants which are used in this application
* */

import '../models/userModel.dart';

class AppConst {
  // to access the access token in the application
  String? currentAccessToken;

  // current user
  static UserModel? userModel;

  // check whether the something is anonymous
  bool checkAnonymous(int isAnonymous) => isAnonymous == 1;


}