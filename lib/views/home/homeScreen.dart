import 'package:flutter/material.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppText(text: "HomeScreen",fontSize: 18,fontWeight: FontWeight.w800),
      ),
    );
  }
}
