import 'package:flutter/material.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/utils/assetImages.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mental_helth_wellness/utils/spacing.dart';
import 'package:mental_helth_wellness/utils/AppColors.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Adjust the height of the app bar as needed
        child: AppBar(
          title: const AppText(text: "Add Post", fontSize: 20, fontWeight: FontWeight.w800),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context),vertical: 8),// Add horizontal and vertical padding
              child: ElevatedButton(
                onPressed: () {
                  // Add logic to send the post
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColors.primaryColor, // Set primary color
                  elevation: 3, // Elevation of the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context),vertical: 8),// Add horizontal and vertical padding
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
                      SizedBox(width: 8), // Add some spacing between text and icon
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          Column(
            children: [
              // Top profile photo with title text field
              Container(
                padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context),vertical: 8),// Add horizontal and vertical padding
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start vertically
                  children: [
                    CircleAvatar(
                      // Fetch and display user's profile photo here
                      backgroundImage: AssetImage(AssetImages.appLogo),
                      radius: 35,
                    ),
                    SizedBox(width: 16), // Add some horizontal space between the avatar and the text field
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10), // Add some vertical space between the title text field and the top
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Add a Title',
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
                              contentPadding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context),vertical: 8),// Add horizontal and vertical padding
                              filled: true, // Fill the text field with color
                              fillColor: appColors.secondaryColor, // Background color of the text field
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
                decoration: InputDecoration(
                  hintText: 'What\'s on your mind?',
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
                  contentPadding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context),vertical: 8),// Add horizontal and vertical padding
                  filled: true, // Fill the text field with color
                  fillColor: appColors.secondaryColor, // Background color of the text field
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),

              // Add photo button
              SizedBox(height: 50),
              // if (_pickedImage != null) // Show the picked image if available
              //   Container(
              //     margin: EdgeInsets.symmetric(vertical: 10),
              //     width: 200,
              //     height: 200,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: FileImage(File(_pickedImage!.path)), // Use FileImage to load image from file path
              //         fit: BoxFit.cover,
              //       ),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              ElevatedButton(
                onPressed: () {
                  _openImagePicker(); // Call function to open image picker
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColors.primaryColor, // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Set borderRadius to add slight edge
                    side: BorderSide(
                      color: appColors.primaryColor, // Border color
                      width: 1, // Border width
                    ),
                  ),
                  minimumSize: Size(double.infinity, 50), // Set width to full width and height to 50
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_album), // Icon on the left side
                    SizedBox(width: 8), // Adjust the space between the icon and text as needed
                    Text('Add Photo', style: TextStyle(fontSize: 19)), // Text
                  ],
                ),
              ),
              // Spacer to push content to the top
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
                Divider(height: 1, color: appColors.secondaryColor), // Line at the top of the box
                Container(
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context),vertical: 8),// Add horizontal and vertical padding
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
                            // Toggle between username and "Anonymous" text
                            username = isAnonymous ? "@username" : "Anonymous";
                            isAnonymous = !isAnonymous;
                          });
                        },
                        icon: Icon(Icons.swap_horiz),
                        color: Colors.black, // Color of the icon
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
}
void _openImagePicker() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    // setState(() {
    //   _pickedImage = pickedImage;
    // });
  }
}
