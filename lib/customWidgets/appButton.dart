import 'package:flutter/material.dart';
import 'package:mental_helth_wellness/utils/appColors.dart';

import 'appText.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.text,
      this.height,
      this.fontSize,
      this.letterSpacing,
      this.wordSpacing,
      this.fontWeight,
      this.borderRadius,
      this.padding,
        this.backgroundColor, required this.onPressed, this.width, this.textColor});

  final double? height, width, fontSize, letterSpacing, wordSpacing, borderRadius, padding;
  final String text;
  final FontWeight? fontWeight;
  final Color? backgroundColor,textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor??AppColors().primaryColor,
            padding: EdgeInsets.symmetric(vertical: padding ?? 15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
            ),
        ),
        onPressed: onPressed,
        child: AppText(
          text: text,
          color: textColor,
          fontSize: 16,
          fontWeight: fontWeight ?? FontWeight.w600,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
        ),
      ),
    );
  }
}
