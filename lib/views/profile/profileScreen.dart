import 'package:flutter/material.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppText(text: "Profile",fontSize: 16,fontWeight: FontWeight.w800),
      ),
    );
  }
}
