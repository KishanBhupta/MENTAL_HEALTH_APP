import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/authController.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/utils/appColors.dart';
import 'package:mental_helth_wellness/utils/spacing.dart';

import '../../models/userModel.dart';
import '../../utils/assetImages.dart';
import 'EditProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showPosts = false;
  final ScrollController scrollController = ScrollController();
  late final AuthController authController; // Define authController variable
  final AppColors appColors = AppColors();

  @override
  void initState() {
    super.initState();
    authController =
        Get.put(AuthController()); // Initialize authController using Get.put
    authController
        .fetchUserData(); // Fetch user data when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
            text: "My Profile", fontSize: 20, fontWeight: FontWeight.w800),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Spacing.getDefaultSpacing(context), vertical: 8),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Add logic to navigate to the settings screen
              },
              iconSize: 35,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // Updated profile section
            GetBuilder<AuthController>(
              builder: (controller) {
                if (controller.userModel != null) {
                  return _buildProfileSection(controller.userModel!);
                } else {
                  return CircularProgressIndicator(); // Show loading indicator while data is being fetched
                }
              },
            ),
            SizedBox(height: 20),
            // Remaining profile screen UI...
          ],
        ),
      ),
    );
  }
  Widget _buildProfileSection(UserModel userModel) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Spacing.getDefaultSpacing(context), vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(AssetImages.appLogo),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${userModel.firstName ?? ''} ${userModel.lastName ?? ''}', // Display first name and last name
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '@${userModel.userName ?? ''}', // Provide a default value if userName is null
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }



}