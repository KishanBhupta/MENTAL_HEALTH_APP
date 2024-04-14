import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/authController.dart';
import 'package:mental_helth_wellness/controllers/postController.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/models/userModel.dart';
import 'package:mental_helth_wellness/utils/appColors.dart';
import 'package:mental_helth_wellness/utils/spacing.dart';

import '../../utils/assetImages.dart';
import '../post/widgets/postWidget.dart';
import 'EditProfileScreen.dart';
import 'Setting.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

  void fetchUserData() {

  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showPosts = false;
  final ScrollController scrollController = ScrollController();
  final AuthController authController = Get.find();
  final PostController postController = Get.find();
  final AppColors appColors = AppColors();

  @override
  void initState() {
    super.initState();
    authController.fetchUserData();
    _getMorePosts();
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
            child:IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Add logic to navigate to the settings screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
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
            GetBuilder<AuthController>(
              builder: (controller) {
                if (controller.userModel != null) {
                  return _buildProfileSection(controller.userModel!);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Spacing.getDefaultSpacing(context), vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  ElevatedButton(
                    onPressed: () {
                      int userId = authController.userModel?.id ?? 0;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            EditProfileScreen(userId: userId)),
                      ).then((_) {
                        fetchUserData(
                            context); // Refresh user data when returning from EditProfileScreen
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColors.primaryColor,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Spacing.getDefaultSpacing(context),
                          vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: appColors.secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await postController.getMyProfilePosts();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColors.secondaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          'Thoughts',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),


                    SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showPosts = false;
                        });
                        // Add logic for 'Saved' button
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColors.secondaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          'Saved',
                          style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showPosts = false;
                        });
                        // Add logic for 'Anonymous' button
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColors.secondaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          'Anonymous',
                          style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: _showPosts,
              child: GetBuilder<PostController>(
                builder: (controller) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      controller.page = 1;
                      await _getMorePosts();
                    },
                    child: ListView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.symmetric(
                          horizontal: Spacing.getDefaultSpacing(context),
                          vertical: 8),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return PostWidget(
                          post: controller.posts[index],
                          index: index,
                        );
                      },
                      itemCount: controller.posts.length,
                    ),
                  );
                },
              ),
            ),
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
                '${userModel.firstName ?? ''} ${userModel.lastName ?? ''}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '@${userModel.userName ?? ''}',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _getMorePosts() async {
    await postController.getPosts();
  }


// Define fetchUserData method
  void fetchUserData(BuildContext context) {
    final AuthController authController = Get.find();
    authController.fetchUserData().then((_) {
      // After fetching the data, trigger a rebuild of the widget
      if (mounted) {
        setState(() {});
      }
    });
  }
}

