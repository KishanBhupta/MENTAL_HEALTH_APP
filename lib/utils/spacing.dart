import 'package:flutter/material.dart';

class Spacing {

  //function to return default spacing from screen size
  static double getDefaultSpacing(context){
    switch(MediaQuery.of(context).size.width){
      case <= 668:
        return 16;
      case <= 1080:
        return 20;
      case > 1080:
        return 24;
      default:
        return 16;
    }
  }
}