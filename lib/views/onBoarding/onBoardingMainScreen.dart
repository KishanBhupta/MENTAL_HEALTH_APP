import 'package:flutter/material.dart';
import 'package:mental_helth_wellness/customWidgets/appButton.dart';
import 'package:mental_helth_wellness/customWidgets/appImage.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/utils/appColors.dart';

import '../../utils/appEnums.dart';
import '../../utils/assetImages.dart';
import '../../utils/spacing.dart';

class OnBoardingMainScreen extends StatefulWidget {
  const OnBoardingMainScreen({super.key});

  @override
  State<OnBoardingMainScreen> createState() => _OnBoardingMainScreenState();
}

class _OnBoardingMainScreenState extends State<OnBoardingMainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.getDefaultSpacing(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                  child: AppText(
                      text: "Welcome !",
                      fontSize: 38,
                    color: AppColors().primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
              ),

              ClipOval(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 280,
                    minWidth: 240,
                  ),
                  child: const AppImage(
                    imageType: ImageType.assetImage,
                    imagePath: AssetImages.appLogo,
                  ),
                ),
              ),
              
              const AppText(text: "Your journey to a better and happier life begins from here.",fontSize: 22,textAlign: TextAlign.center,fontWeight: FontWeight.w500),

              AppButton(
                  width: double.maxFinite,
                  text: "Let's Get Started", onPressed: (){
                    // TODO : IMPLEMENT HOME SCREEN NAVIGATION FROM HERE
                  },
              )

            ],
          ),
        ),
      ),
    );
  }
}
