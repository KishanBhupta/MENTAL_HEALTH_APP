import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/authController.dart';
import 'package:mental_helth_wellness/controllers/apiController.dart';
import 'package:mental_helth_wellness/utils/apiUrls.dart';
import 'package:mental_helth_wellness/utils/appColors.dart';
import 'package:mental_helth_wellness/utils/spacing.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  final AppColors appColors = AppColors();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Spacing.getDefaultSpacing(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Change Password',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: _changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appColors.primaryColor,
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
              ],
            ),
            SizedBox(height: 20),
            _buildTextField('Old Password', _oldPasswordController),
            SizedBox(height: 20),
            _buildTextField('New Password', _newPasswordController),
            SizedBox(height: 20),
            _buildTextField('Confirm New Password', _confirmPasswordController),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Feedback',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: _saveFeedback,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appColors.primaryColor,
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
              ],
            ),
            SizedBox(height: 20),
            _buildTextField('Feedback', _feedbackController),
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

  void _changePassword() async {
    try {
      final oldPassword = _oldPasswordController.text;
      final newPassword = _newPasswordController.text;
      final confirmPassword = _confirmPasswordController.text;

      // Validate passwords
      if (newPassword != confirmPassword) {
        Get.snackbar('Error', 'New password and confirm password do not match');
        return;
      }

      // Call API to change password
      final response = await ApiController().changePassword(
        id: authController.userModel?.id ?? 0,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Password changed successfully');
      } else {
        Get.snackbar('Error', 'Failed to change password');
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to change password');
    }
  }

  void _saveFeedback() async {
    try {
      final int userId = authController.userModel?.id ?? 0;
      final String feedbackData = _feedbackController.text;

      // Call the storeFeedback method from the ApiController
      final response = await ApiController().storeFeedback(
        userId: userId,
        feedbackData: feedbackData,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Feedback saved successfully');
      } else {
        final dynamic responseData = response.data;
        Get.snackbar('Error', responseData['message'] ?? 'Failed to save feedback');
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to save feedback');
    }
  }



}
