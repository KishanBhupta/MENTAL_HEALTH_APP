import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental_helth_wellness/customWidgets/appImage.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/customWidgets/cSpace.dart';
import 'package:mental_helth_wellness/utils/appEnums.dart';
import 'package:mental_helth_wellness/utils/appExtensions.dart';
import 'package:mental_helth_wellness/utils/assetImages.dart';

import '../../../models/postModel.dart';
import '../../../utils/spacing.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8
      ),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1, 1),
            blurRadius: 5
          )
        ],
        borderRadius: BorderRadius.circular(15)
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header user data row
          Row(
            children: [
              // user profile image
              CircleAvatar(
                radius: 20,
                backgroundImage:Image.asset(AssetImages.appLogo).image,
              ),

              const CSpace(width: 16),
              
              // user name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(text: "User Name"),
                    AppText(text: timeago.format(post.createdAt.toString().getDate()),fontSize: 10,)
                  ],
                ),
              ),
              
              PopupMenuButton(
                surfaceTintColor: Colors.white,
                itemBuilder: (context) {
                  return <PopupMenuItem>[
                    const PopupMenuItem(
                        value: 0,
                        child: AppText(text: "Delete")
                    )
                  ];
                },
              )
            ],
          ),

          const CSpace(height: 8),

          // thought
          AppText(text: post.postText.toString()),

          const CSpace(height: 8),

          // description
          AppText(text: post.postDescription.toString()),

          const CSpace(height: 8),

          // image
          post.imageUrl!=null ? Center(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: AppImage(
                height: 280,
                imageType: ImageType.networkImage,
                imagePath: post.imageUrl.toString(),
              ),
            ),
          ) : const CSpace(),

          CSpace(height: Spacing.getDefaultSpacing(context)),

          // bottom option row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // like button
                    Column(
                      children: [
                        InkWell(
                            onTap: (){},
                            child: const Icon(CupertinoIcons.heart,size: 30),
                        ),
                        AppText(text: "${post.likes}")
                      ],
                    ),

                    const CSpace(width: 8),

                    // comment button
                    Column(
                      children: [
                        InkWell(
                          onTap: (){},
                          child: const Icon(CupertinoIcons.chat_bubble,size: 30),
                        ),
                        const AppText(text: "100")
                      ],
                    ),
                  ],
                ),


                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // share button
                    Column(
                      children: [
                        InkWell(
                          onTap: (){},
                          child: const Icon(CupertinoIcons.share,size: 30),
                        ),
                      ],
                    ),

                    const CSpace(width: 8),
                    // save button
                    Column(
                      children: [
                        InkWell(
                          onTap: (){},
                          child: const Icon(CupertinoIcons.bookmark,size: 30),
                        ),
                      ],
                    ),
                  ],
                ),


              ],
            ),
          )
        ],
      ),
    );
  }
}
