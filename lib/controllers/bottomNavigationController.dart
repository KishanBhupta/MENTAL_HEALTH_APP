import 'package:get/get.dart';
import 'package:mental_helth_wellness/utils/appEnums.dart';

class BottomNavigationController extends GetxController {

  BottomBarScreens screen = BottomBarScreens.home;
  int selectedBottomNavbarIndex = 0;

  void changeScreen({required int gotoScreen}){
    selectedBottomNavbarIndex = gotoScreen;

    switch(gotoScreen){
      case 0:{
        screen = BottomBarScreens.home;
        break;
      }
      case 1:{
        screen = BottomBarScreens.chat;
        break;
      }
      case 2:{
        screen = BottomBarScreens.search;
        break;
      }
      case 3:{
        screen = BottomBarScreens.addPost;
        break;
      }
      case 4:{
        screen = BottomBarScreens.profile;
        break;
      }
    }
    update();
  }

}