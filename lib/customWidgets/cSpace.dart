import 'package:flutter/material.dart';

class CSpace extends StatelessWidget {
  const CSpace({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width:width,
    );
  }
}
