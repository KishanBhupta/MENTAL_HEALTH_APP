import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/customWidgets/appButton.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/customWidgets/appTextField.dart';
import 'package:mental_helth_wellness/customWidgets/cSpace.dart';
import 'package:mental_helth_wellness/utils/AppColors.dart';
import 'package:mental_helth_wellness/utils/appEnums.dart';
import 'package:mental_helth_wellness/utils/spacing.dart';

import '../../controllers/searchController.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextController = TextEditingController();

  final searchController = Get.find<SearchQueryController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(Spacing.getDefaultSpacing(context)),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: searchTextController,
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
                  ),

                  CSpace(width: Spacing.getDefaultSpacing(context)),

                  AppButton(
                  text: "Search",
                  onPressed: () async {
                    await searchController.searchNewUsers();
                  },
                  backgroundColor: AppColors().primaryColor,width: 75,fontWeight: FontWeight.w600)
                ],
              ),

              Expanded(child: Container()),


              
            ],
          ),
        ),
      ),
    );
  }
}
