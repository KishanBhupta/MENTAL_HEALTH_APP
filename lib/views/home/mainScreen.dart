import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/bottomNavigationController.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/utils/appEnums.dart';
import 'package:mental_helth_wellness/views/addPost/appPostScreen.dart';
import 'package:mental_helth_wellness/views/chat/chatScreen.dart';
import 'package:mental_helth_wellness/views/profile/profileScreen.dart';

import 'bottomNavigationBar.dart';
import 'homeScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final bottomNavigationController = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BottomNavigationController>(
        builder: (controller) {
          return controller.screen == BottomBarScreens.home ? const HomeScreen() :
          controller.screen == BottomBarScreens.chat ? const ChatScreen() :
          controller.screen == BottomBarScreens.addPost ? const AddPostScreen() :
          controller.screen == BottomBarScreens.profile ? const ProfileScreen() : const HomeScreen()
          ;
        },
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }
}
