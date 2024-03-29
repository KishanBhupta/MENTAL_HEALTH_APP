import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/splashScreenController.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/customWidgets/cSpace.dart';
import 'package:mental_helth_wellness/utils/assetImages.dart';
import 'package:mental_helth_wellness/utils/spacing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final splashScreenController = Get.put(SplashScreenController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      splashScreenController.checkCurrentAuthState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width*0.25,
              backgroundImage: Image.asset(AssetImages.appLogo).image,
            ),

            CSpace(height: Spacing.getDefaultSpacing(context)),

            const AppText(text: "Mental Health Wellness",fontSize: 28,color: Colors.blue,fontWeight: FontWeight.w600)
          ],
        ),
      ),
    );
  }
}
