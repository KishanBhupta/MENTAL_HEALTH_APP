import 'package:flutter/material.dart';
import 'package:mental_helth_wellness/utils/assetImages.dart';

import '../utils/appEnums.dart';
import 'appText.dart';

class AppImage extends StatelessWidget {
  const AppImage({super.key, required this.imageType, required this.imagePath, this.height, this.width, this.fit});

  final ImageType imageType;
  final String imagePath;
  final double? height,width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return  _buildImageWidget();
  }

  Widget _buildImageWidget() {
    switch(imageType){
      case ImageType.networkImage:
        return FadeInImage(
          image: Image.network(
              imagePath,
            height: height,
            width: width,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(AssetImages.appLogo);
            },
          ).image, placeholder:Image.asset(AssetImages.appLogo).image
        );
      case ImageType.assetImage:
        return Image.asset(
            imagePath,
          height: height,
          width: width,
          errorBuilder: (context, error, stackTrace) => errorWidget(),
        );
      default:
        return errorWidget();
    }
  }

  Widget errorWidget(){
    return Container(
      color: Colors.grey,
      child: const AppText(text:"No Image Found",fontSize: 18,fontWeight: FontWeight.w500),
    );
  }
}
