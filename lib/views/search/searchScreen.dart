import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/customWidgets/appButton.dart';
import 'package:mental_helth_wellness/customWidgets/appImage.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/customWidgets/appTextField.dart';
import 'package:mental_helth_wellness/customWidgets/cSpace.dart';
import 'package:mental_helth_wellness/utils/AppColors.dart';
import 'package:mental_helth_wellness/utils/appEnums.dart';
import 'package:mental_helth_wellness/utils/appMethods.dart';
import 'package:mental_helth_wellness/utils/spacing.dart';

import '../../controllers/searchController.dart';
import '../../utils/dbouncer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextController = TextEditingController();

  DeBouncer deBouncer = DeBouncer();

  final searchController = Get.find<SearchQueryController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(Spacing.getDefaultSpacing(context)),
          child: Column(
            children: [
              AppTextField(
                controller: searchTextController,
                onChange:(value) {
                  deBouncer.startTimer(runTask: () async {
                    await searchController.searchNewUsers(query: value);
                  });
                },
                isBorderEnabled: true,
                borderType: BorderType.rectangleBorder,
                consistentBorderColor: AppColors().primaryColor,
                isConsistentBorderColor: true,
                isDense: true,
                prefixIcon: Icon(CupertinoIcons.search,color: AppColors().primaryColor),
                isConsistentBorderRadius: true,
                consistentBorderRadius: 15,
                hintText: "Find Peoples",
                validator: (searchQuery) {
                  return null;
                }
              ),

              Expanded(
                  child: GetBuilder<SearchQueryController>(
                    builder: (controller) {
                      if(controller.users.isEmpty){
                        return const Center(
                          child: AppText(text: "Get in touch with others by searching users.!"),
                        );
                      }else{
                        return ListView.separated(
                            padding: EdgeInsets.all(Spacing.getDefaultSpacing(context)),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height:  25,
                                      width: 25,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      child: AppImage(imageType: ImageType.networkImage,imagePath: controller.users[index].profileImage.toString(),),
                                    ),
                                    CSpace(width: Spacing.getDefaultSpacing(context)),

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        controller.users[index].userName!=null ? AppText(text: controller.users[index].userName!.toString()) : const CSpace() ,
                                        CSpace(height: controller.users[index].userName!=null ? 8 : 0),
                                        AppText(text: "${controller.users[index].firstName} ${controller.users[index].lastName}")
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              if(index!=controller.users.length-1){
                                return const Divider();
                              }else{
                                return const CSpace();
                              }
                            },
                            itemCount: controller.users.length
                        );
                      }
                    },
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
