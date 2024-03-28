import 'package:flutter/material.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppText(text: "Search",fontSize: 16,fontWeight: FontWeight.w800),
      ),
    );
  }
}
