import 'package:flutter/material.dart';
import 'package:mental_helth_wellness/utils/appFonts.dart';

class AppText extends StatelessWidget {
  const AppText(
      {super.key,
      required this.text,
      this.maxLines,
      this.letterSpacing,
      this.wordSpacing,
      this.fontSize,
      this.textAlign,
      this.color,
      this.fontWeight,
      this.fontStyle, this.textDecoration, this.fontFamily});

  final String text;

  final int? maxLines;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? fontSize;
  final TextAlign? textAlign;
  final Color? color;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign ?? TextAlign.start,
        // overflow: TextOverflow.ellipsis,
        // maxLines: maxLines,
        style: TextStyle(
          decoration:textDecoration,
          color: color ?? Colors.black,
          fontSize: fontSize ?? 14,
          fontFamily: fontFamily??AppFonts.publicSans,
          fontWeight: fontWeight ?? FontWeight.w400,
          fontStyle: fontStyle ?? FontStyle.normal,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
        ),
    );
  }
}
