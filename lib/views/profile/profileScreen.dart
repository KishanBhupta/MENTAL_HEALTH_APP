import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/postController.dart';
import 'package:mental_helth_wellness/utils/appMethods.dart';
import 'package:mental_helth_wellness/views/post/widgets/postWidget.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/utils/assetImages.dart';
import 'package:mental_helth_wellness/utils/AppColors.dart';
import 'package:mental_helth_wellness/utils/spacing.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showPosts = false;
  final ScrollController scrollController = ScrollController();
  late final PostController postController; // Define postController variable
  final AppColors appColors = AppColors();

  @override
  void initState() {
    super.initState();
    postController = Get.put(PostController()); // Initialize postController using Get.put
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(text: "My Profile", fontSize: 20, fontWeight: FontWeight.w800),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context),vertical: 8),// Add horizontal and vertical padding
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
            // Profile photo, name, and username
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context),vertical: 8),// Add horizontal and vertical padding
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
                        'Name',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '@username',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Edit profile button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context),vertical: 8),// Add horizontal and vertical padding
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
                      padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context),vertical: 8),// Add horizontal and vertical padding
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
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
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
                      padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context),vertical: 8),// Add horizontal and vertical padding
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return PostWidget(post: controller.posts[index]);
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

  Future<void> _getMorePosts() async {
    AppMethods.showLoading();
    await postController.getPosts();
    AppMethods.dismissLoading();
  }
}

class EditProfileScreen extends StatelessWidget {
  final AppColors appColors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),

        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context),vertical: 8),// Add horizontal and vertical padding
            child: ElevatedButton(
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
                padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context),vertical: 8),// Add horizontal and vertical padding
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Save',
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Profile picture
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(AssetImages.appLogo),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Add logic for 'Anonymous' button
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, // Keep the text color unchanged
                      elevation: 0, // Remove elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        'Change Profile Picture',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            // Profile details
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context),vertical: 8),// Add horizontal and vertical padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: appColors.secondaryColor, // Border color
                          width: 1.0, // Border width
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: appColors.primaryColor, // Focused border color
                          width: 2.0, // Focused border width
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0), // Padding inside the text field
                      filled: true, // Fill the text field with color
                      fillColor: appColors.secondaryColor, // Background color of the text field
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: appColors.secondaryColor, // Border color
                          width: 1.0, // Border width
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: appColors.primaryColor, // Focused border color
                          width: 2.0, // Focused border width
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0), // Padding inside the text field
                      filled: true, // Fill the text field with color
                      fillColor: appColors.secondaryColor, // Background color of the text field
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: appColors.secondaryColor, // Border color
                          width: 1.0, // Border width
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: appColors.primaryColor, // Focused border color
                          width: 2.0, // Focused border width
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0), // Padding inside the text field
                      filled: true, // Fill the text field with color
                      fillColor: appColors.secondaryColor, // Background color of the text field
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: appColors.secondaryColor, // Border color
                          width: 1.0, // Border width
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: appColors.primaryColor, // Focused border color
                          width: 2.0, // Focused border width
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0), // Padding inside the text field
                      filled: true, // Fill the text field with color
                      fillColor: appColors.secondaryColor, // Background color of the text field
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
