import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mental_helth_wellness/utils/appFonts.dart';

import '../utils/appEnums.dart';

class AppTextField extends StatelessWidget {

  final TextEditingController controller;
  final String? Function(String?) validator;

  final bool? isDense;
  final bool? isCollapsed;
  final bool? isPassword;
  final int? maxLines, maxLength;
  final String? fontFamily;

  //border policy booleans
  final bool? isBorderEnabled;
  final bool? isConsistentBorderRadius;
  final bool? isConsistentBorderColor;
  final bool? applyOnlyRadius;

  //border policy values
  final Color? consistentBorderColor;
  final double? consistentBorderRadius;
  final BorderType? borderType;
  //borders
  InputBorder? border;
  InputBorder? enableBorder;
  InputBorder? focusBorder;
  InputBorder? errorBorder;
  //border radius
  final double? borderRadius;
  final double? enableBorderRadius;
  final double? focusBorderRadius;
  final double? errorBorderRadius;
  //border colors
  final Color? borderColor;
  final Color? enableBorderColor;
  final Color? focusBorderColor;
  final Color? errorBorderColor;

  //hint & label & text properties
  final String? hintText, labelText;
  final double? hintFontSize, hintLetterSpacing, hintWordSpacing, labelFontSize, labelLetterSpacing, labelWordSpacing , textFontSize, textLetterSpacing, textWordSpacing;
  final FontWeight? hintFontWeight, labelFontWeight, textFontWeight;
  final Color? hintFontColor, labelFontColor, textFontColor;

  // custom validations for input
  final List<TextInputFormatter>? inputFormatters;

  //suffix and prefix
  final Widget? suffix, prefix, suffixIcon, prefixIcon;




  AppTextField({super.key,
    required this.controller,
    required this.validator,
    this.isBorderEnabled,
    this.isConsistentBorderRadius,
    this.isConsistentBorderColor,
    this.consistentBorderColor,
    this.consistentBorderRadius,
    this.borderType,
    this.border,
    this.enableBorder,
    this.focusBorder,
    this.errorBorder,
    this.borderRadius,
    this.enableBorderRadius,
    this.focusBorderRadius,
    this.errorBorderRadius,
    this.borderColor,
    this.enableBorderColor,
    this.focusBorderColor,
    this.errorBorderColor,
    this.applyOnlyRadius,
    this.hintText,
    this.labelText,
    this.hintFontSize,
    this.hintLetterSpacing,
    this.hintWordSpacing,
    this.labelFontSize,
    this.labelLetterSpacing,
    this.labelWordSpacing,
    this.hintFontWeight,
    this.labelFontWeight,
    this.hintFontColor,
    this.labelFontColor,
    this.isDense,
    this.isCollapsed,
    this.isPassword,
    this.maxLines,
    this.inputFormatters,
    this.fontFamily = AppFonts.publicSans,
    this.textFontSize,
    this.textLetterSpacing,
    this.textWordSpacing,
    this.textFontWeight,
    this.textFontColor,
    this.suffix,
    this.prefix,
    this.suffixIcon,
    this.prefixIcon, this.maxLength}
      ):assert(
      ((isConsistentBorderColor != null && consistentBorderColor != null) || (isConsistentBorderColor == null && consistentBorderColor == null))
          &&
      ((isConsistentBorderRadius!=null && consistentBorderRadius!=null) || (isConsistentBorderRadius==null && consistentBorderRadius==null)
          &&
      ((isBorderEnabled!=null && borderType!=null) || (isBorderEnabled==null&&borderType==null)))
  );

  @override
  Widget build(BuildContext context) {
    _buildBorders();

    return TextFormField(
      controller: controller,
      validator: validator,
      inputFormatters: inputFormatters,
      obscureText: isPassword??false,
      maxLines: maxLines??1,
      maxLength: maxLength,
      style: TextStyle(
        fontSize: textFontSize,
        fontWeight: textFontWeight,
        fontFamily: fontFamily,
        letterSpacing: textLetterSpacing,
        wordSpacing: textWordSpacing,
        color: textFontColor,
      ),
      decoration: InputDecoration(
        suffix: suffix,
        suffixIcon: suffixIcon,
        prefix: prefix,
        prefixIcon: prefixIcon,
        isDense: isDense,
        isCollapsed: isCollapsed,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: hintFontSize,
          fontWeight: hintFontWeight,
          letterSpacing: hintLetterSpacing,
          wordSpacing: hintWordSpacing,
          color: hintFontColor??Colors.grey,
          fontFamily: fontFamily
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: labelFontSize,
          fontWeight: labelFontWeight,
          letterSpacing: labelLetterSpacing,
          wordSpacing: labelWordSpacing,
          color: labelFontColor,
          fontFamily: fontFamily
        ),
        border: isBorderEnabled??false ? border : null,
        enabledBorder: isBorderEnabled??false ? enableBorder :null,
        focusedBorder:isBorderEnabled??false ? focusBorder : null,
        errorBorder: isBorderEnabled??false ? errorBorder : null,
      ),
    );
  }

  //function to build borders
  _buildBorders() {
    switch(borderType){
      case BorderType.underlineBorder:
          border = UnderlineInputBorder(
            borderRadius: BorderRadius.circular(
              isConsistentBorderRadius ?? false ? consistentBorderRadius! : borderRadius??0,
            ),
            borderSide: BorderSide(
              color: applyOnlyRadius??false ? Colors.transparent : isConsistentBorderColor??false ? consistentBorderColor! : borderColor??Colors.grey
            )
          );
          enableBorder = UnderlineInputBorder(
              borderRadius: BorderRadius.circular(
                  isConsistentBorderRadius ?? false ? consistentBorderRadius! : enableBorderRadius??0
              ),
              borderSide: BorderSide(
                  color: applyOnlyRadius??false ? Colors.transparent : isConsistentBorderColor??false ? consistentBorderColor! : enableBorderColor??Colors.grey
              )
          );
          focusBorder = UnderlineInputBorder(
            borderRadius: BorderRadius.circular(
                isConsistentBorderRadius ?? false ? consistentBorderRadius! : focusBorderRadius??0
            ),
              borderSide: BorderSide(
                  color: applyOnlyRadius??false ? Colors.transparent : isConsistentBorderColor??false ? consistentBorderColor! : focusBorderColor??Colors.grey
              )
          );
          errorBorder = UnderlineInputBorder(
              borderRadius: BorderRadius.circular(
                  isConsistentBorderRadius ?? false ? consistentBorderRadius! : errorBorderRadius??0
              ),
              borderSide: BorderSide(
                  color: applyOnlyRadius??false ? Colors.transparent : isConsistentBorderColor??false ? consistentBorderColor! : errorBorderColor??Colors.grey
              )
          );
          break;
      case BorderType.rectangleBorder:
          border = OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  isConsistentBorderRadius ?? false ? consistentBorderRadius! : borderRadius??0
              ),
              borderSide: BorderSide(
                  color: applyOnlyRadius??false ? Colors.transparent : isConsistentBorderColor??false ? consistentBorderColor! : borderColor??Colors.grey
              )
          );
          enableBorder = OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  isConsistentBorderRadius ?? false ? consistentBorderRadius! : enableBorderRadius??0
              ),
              borderSide: BorderSide(
                  color: applyOnlyRadius??false ? Colors.transparent : isConsistentBorderColor??false ? consistentBorderColor! : enableBorderColor??Colors.grey
              )
          );
          focusBorder = OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  isConsistentBorderRadius ?? false ? consistentBorderRadius! : focusBorderRadius??0
              ),
              borderSide: BorderSide(
                  color: applyOnlyRadius??false ? Colors.transparent : isConsistentBorderColor??false ? consistentBorderColor! : focusBorderColor??Colors.grey
              )
          );
          errorBorder = OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  isConsistentBorderRadius ?? false ? consistentBorderRadius! : errorBorderRadius??0
              ),
              borderSide: BorderSide(
                  color: applyOnlyRadius??false ? Colors.transparent : isConsistentBorderColor??false ? consistentBorderColor! : errorBorderColor??Colors.grey
              )
          );
          break;
      case null:
          border = OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  isConsistentBorderRadius ?? false ? consistentBorderRadius! : borderRadius??0
              ),
              borderSide: BorderSide(
                  color: applyOnlyRadius??false ? Colors.transparent : isConsistentBorderColor??false ? consistentBorderColor! : borderColor??Colors.grey
              )
          );
          enableBorder = OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  isConsistentBorderRadius ?? false ? consistentBorderRadius! : enableBorderRadius??0
              ),
              borderSide: BorderSide(
                  color: applyOnlyRadius??false ? Colors.transparent : isConsistentBorderColor??false ? consistentBorderColor! : enableBorderColor??Colors.grey
              )
          );
          focusBorder = OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  isConsistentBorderRadius ?? false ? consistentBorderRadius! : focusBorderRadius??0
              ),
              borderSide: BorderSide(
                  color: applyOnlyRadius??false ? Colors.transparent : isConsistentBorderColor??false ? consistentBorderColor! : focusBorderColor??Colors.grey
              )
          );
          errorBorder = OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  isConsistentBorderRadius ?? false ? consistentBorderRadius! : errorBorderRadius??0
              ),
              borderSide: BorderSide(
                  color: applyOnlyRadius??false ? Colors.transparent : isConsistentBorderColor??false ? consistentBorderColor! : errorBorderColor??Colors.grey
              )
          );
          break;
    }
  }
}
