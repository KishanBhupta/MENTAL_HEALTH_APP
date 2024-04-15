import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/authController.dart';
import 'package:mental_helth_wellness/controllers/postController.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/utils/appColors.dart';
import 'package:mental_helth_wellness/utils/appConst.dart';
import 'package:mental_helth_wellness/utils/spacing.dart';

import '../../models/userModel.dart';
import '../../utils/assetImages.dart';
import '../post/widgets/postWidget.dart';
import 'EditProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key,});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showPosts = false;
  final ScrollController scrollController = ScrollController();
  late final AuthController authController; // Define authController variable
  late final PostController postController; // Define postController variable
  final AppColors appColors = AppColors();

  @override
  void initState() {
    super.initState();
    authController =
        Get.put(AuthController()); // Initialize authController using Get.put
    authController.fetchUserData(); // Fetch user data when the screen initializes
    postController = Get.put(PostController()); // Initialize postController using Get.put
    _getMorePosts(); // Fetch posts when the screen initializes
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
              icon: const Icon(Icons.settings),
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
          children: <Widget>[
            const SizedBox(height: 20),
            // Updated profile section
            GetBuilder<AuthController>(
              builder: (controller) {
                if (controller.userModel != null) {
                  return _buildProfileSection(controller.userModel!);
                } else {
                  return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
                }
              },
            ),
            const SizedBox(height: 20),
            // Edit profile button
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Spacing.getDefaultSpacing(context), vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfileScreen()),
                      );
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
                          horizontal: Spacing.getDefaultSpacing(context), vertical: 8),
                      child: const Row(
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
            const SizedBox(height: 20),
            // Box containing options
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
                      onPressed: () {
                        setState(() {
                          _showPosts = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColors.secondaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(2),
                        child: Text(
                          'Thoughts',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
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
                      child: const Padding(
                        padding: EdgeInsets.all(2),
                        child: Text(
                          'Saved',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
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
                      child: const Padding(
                        padding: EdgeInsets.all(2),
                        child: Text(
                          'Anonymous',
                          style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Posts section
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
                          horizontal: Spacing.getDefaultSpacing(context), vertical: 8),
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
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(AssetImages.appLogo),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${AppConst.userModel!.firstName ?? ''} ${AppConst.userModel!.lastName ?? ''}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '@${AppConst.userModel!.userName ?? ''}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
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
}
