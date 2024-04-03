// AddPostScreen

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
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool isAnonymous = false;
  String username = "@username";
  XFile? _pickedImage;
  final AppColors appColors = AppColors();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  int userId = 1;

  @override
  void dispose() {
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
                      'Post',
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
      body: Stack(
        children: [
          Column(
            children: [
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
                            controller: _titleController,
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
              SizedBox(height: 20),
              TextField(
                controller: _contentController,
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
              SizedBox(height: 20),
              if (_pickedImage != null) // Display picked image if available
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.file(
                    File(_pickedImage!.path),
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(height: 20),
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
                        onPressed: _toggleAnonymous,
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
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    final imageUrl = _pickedImage?.path ?? ""; // Use picked image path as imageUrl

    if (title.isNotEmpty && content.isNotEmpty) {
      CreatePostController().createPosts(
        title: title,
        content: content,
        imageUrl: imageUrl,
        isAnonymous: isAnonymous,
        userId: userId,
      );
      _titleController.clear();
      _contentController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in title and content'),
        ),
      );
    }
  }

  void _toggleAnonymous() {
    setState(() {
      username = isAnonymous ? "@username" : "Anonymous";
      isAnonymous = !isAnonymous;
    });
  }
}
