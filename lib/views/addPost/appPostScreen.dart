import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mental_helth_wellness/controllers/createPostController.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/utils/assetImages.dart';
import 'package:mental_helth_wellness/utils/spacing.dart';
import 'package:mental_helth_wellness/utils/appColors.dart';
import 'package:mental_helth_wellness/utils/appMethods.dart';


class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key); // Add '?' to make 'Key' nullable

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool isAnonymous = false; // Define and initialize isAnonymous variable
  String username = "@username"; // Initial username
  XFile? _pickedImage; // Add this variable to store the picked image
  final AppColors appColors = AppColors();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  int userId = 1; // Set default user_id as 1

  @override
  void dispose() {
    // Dispose the controllers when the state is disposed to avoid memory leaks
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
            text: "Add Post", fontSize: 20, fontWeight: FontWeight.w800),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Spacing.getDefaultSpacing(context), vertical: 8),
            child: ElevatedButton(
              onPressed: _createPost,
              style: ElevatedButton.styleFrom(
                backgroundColor: appColors.primaryColor, // Set primary color
                elevation: 3, // Elevation of the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
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
                      'Post',
                      style: TextStyle(
                        color: Colors.black, // Text color
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 8),
                    // Add some spacing between text and icon
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Top profile photo with title text field
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Spacing.getDefaultSpacing(context),
                    vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(AssetImages.appLogo),
                      radius: 35,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          TextField(
                            controller: _titleController, // Assign the title controller
                            decoration: InputDecoration(
                              hintText: 'Add a Title',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: appColors.secondaryColor,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: appColors.primaryColor,
                                  width: 2.0,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Spacing.getDefaultSpacing(
                                      context), vertical: 8),
                              filled: true,
                            ),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Text field for post
              SizedBox(height: 20),
              TextField(
                controller: _contentController, // Assign the content controller
                decoration: InputDecoration(
                  hintText: 'What\'s on your mind?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: appColors.secondaryColor,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: appColors.primaryColor,
                      width: 2.0,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Spacing.getDefaultSpacing(context),
                      vertical: 8),
                  filled: true,
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              // Add photo button
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: _openImagePicker,
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: appColors.primaryColor,
                      width: 1,
                    ),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_album),
                    SizedBox(width: 8),
                    Text('Add Photo', style: TextStyle(fontSize: 19)),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Divider(height: 1, color: appColors.secondaryColor),
                Container(
                  height: 70,
                  padding: EdgeInsets.symmetric(
                      horizontal: Spacing.getDefaultSpacing(context),
                      vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(AssetImages.appLogo),
                        radius: 25,
                      ),
                      SizedBox(width: 16),
                      Text("Post as a " + username),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            username = isAnonymous ? "@username" : "Anonymous";
                            isAnonymous = !isAnonymous;
                          });
                        },
                        icon: Icon(Icons.swap_horiz),
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openImagePicker() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = pickedImage;
      });
    }
  }

  void _createPost() {
    // Check if title and content are not empty
    if (_titleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty) {
      // Create an instance of CreatePostController
      CreatePostController createPostController = CreatePostController();

      // Call createPosts method on the instance
      createPostController.createPosts(
        title: _titleController.text,
        content: _contentController.text,
        image: _pickedImage?.path ?? "",
        anonymous: isAnonymous,
        userId: userId, // Pass the user_id to the createPosts method
      );

      // Clear the text fields after creating the post
      _titleController.clear();
      _contentController.clear();
    } else {
      // Show an error message if title or content is empty
      AppMethods.showToast(message: "Please fill in title and content");
    }
  }
}