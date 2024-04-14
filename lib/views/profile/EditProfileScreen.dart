
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mental_helth_wellness/controllers/authController.dart';
import 'package:mental_helth_wellness/controllers/apiController.dart';
import 'package:mental_helth_wellness/models/userModel.dart';
import 'package:mental_helth_wellness/utils/appColors.dart';
import 'package:mental_helth_wellness/utils/spacing.dart';
import 'package:mental_helth_wellness/views/profile/profileScreen.dart';

class EditProfileScreen extends StatefulWidget {
  final int userId;

  const EditProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final AuthController authController = Get.find();
  File? _image;

  @override
  void initState() {
    super.initState();
    // Fetch current user data and populate text fields
    _firstNameController.text = authController.userModel?.firstName ?? '';
    _lastNameController.text = authController.userModel?.lastName ?? '';
    _emailController.text = authController.userModel?.email ?? '';
    _phoneNumberController.text = authController.userModel?.phoneNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context)),
            child: ElevatedButton(
              onPressed: _updateProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context), vertical: 8),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.getDefaultSpacing(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => _selectImage(context),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                  image: _image != null
                      ? DecorationImage(
                    image: FileImage(_image!),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: _image == null
                    ? Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.grey,
                )
                    : null,
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () => _selectImage(context),
              child: Text(
                'Change Profile Picture',
                style: TextStyle(color: Colors.blue),
              ),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
              ),
            ),
            SizedBox(height: 20),
            _buildTextField('First Name', _firstNameController),
            SizedBox(height: 20),
            _buildTextField('Last Name', _lastNameController),
            SizedBox(height: 20),
            _buildTextField('Email', _emailController),
            SizedBox(height: 20),
            _buildTextField('Phone Number', _phoneNumberController),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  void _updateProfile() async {
    try {
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final email = _emailController.text;
      final phoneNumber = _phoneNumberController.text;

      // Call API to update profile
      final response = await ApiController().updateUserProfile(
        id: authController.userModel?.id ?? 0, // Assuming userModel has an id field
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
      );

      if (response.statusCode == 200) {
        // Update user model with new data
        authController.userModel = UserModel.fromJSON(response.data['user']);
        // Show success message
        Get.snackbar('Success', 'Profile updated successfully');
        // Navigate back to previous screen (ProfileScreen)
        Navigator.pop(context);
        ProfileScreen().fetchUserData(); // Call fetchUserData() to refresh data
      } else {
        // Show error message
        Get.snackbar('Error', 'Failed to update profile');
      }
    } catch (error) {
      // Show error message
      Get.snackbar('Error', 'Failed to update profile');
    }
  }

  Future<void> _selectImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
