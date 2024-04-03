import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/postController.dart';
import 'package:mental_helth_wellness/utils/appMethods.dart';
import 'package:mental_helth_wellness/views/post/widgets/postWidget.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/utils/assetImages.dart';
import 'package:mental_helth_wellness/utils/AppColors.dart';
import 'package:mental_helth_wellness/utils/spacing.dart';

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
