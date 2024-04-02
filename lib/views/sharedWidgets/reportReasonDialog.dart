import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/commentController.dart';
import 'package:mental_helth_wellness/controllers/postController.dart';
import 'package:mental_helth_wellness/customWidgets/appButton.dart';
import 'package:mental_helth_wellness/customWidgets/appTextField.dart';
import 'package:mental_helth_wellness/customWidgets/cSpace.dart';
import 'package:mental_helth_wellness/utils/appEnums.dart';

import '../../customWidgets/appText.dart';
import '../../utils/spacing.dart';

class ReportReasonDialog extends StatelessWidget {
  ReportReasonDialog({super.key, required this.title, required this.message, required this.reportType, required this.data});

  final String title,message;
  final ReportType reportType;
  final Map<String,dynamic> data;
  final TextEditingController reasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final commentController = Get.find<CommentsController>();
    final postController = Get.find<PostController>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.hardEdge,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      child: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(Spacing.getDefaultSpacing(context)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.warning_amber_outlined,color: Colors.orange),
                  const CSpace(width: 8,),
                  AppText(text: title,fontSize: 16,fontWeight: FontWeight.w600,),
                  const Spacer(),
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(CupertinoIcons.xmark),
                  )
                ],
              ),

              CSpace(height: Spacing.getDefaultSpacing(context)),

              AppText(text: message),

              CSpace(height: Spacing.getDefaultSpacing(context)),

              AppTextField(
                controller: reasonController,
                maxLength: 100,
                borderType: BorderType.rectangleBorder,
                isBorderEnabled: true,
                isDense: true,
                isConsistentBorderRadius: true,
                consistentBorderRadius: 15,
                maxLines: 5,
                hintText: "Enter Reason",
                validator: (reason) {
                  if(reason.toString().isEmpty){
                    return "Please enter reason to submit report";
                  }
                  return null;
                }
              ),

              CSpace(height: Spacing.getDefaultSpacing(context)),

              AppButton(text: "Report", onPressed: () async {

                if(_formKey.currentState!.validate()){
                  switch(reportType){
                    case ReportType.comment:{
                      await commentController.reportComment(commentId: data['commentId'],reason:reasonController.text.toString());
                    }
                    case ReportType.post:
                      {
                        await  postController.reportPost(postId: data['postId'],reason:reasonController.text.toString());
                      }
                    case ReportType.user:
                    // TODO: Handle this case.
                  }

                  Get.back();
                }

              },width: double.maxFinite,fontWeight: FontWeight.bold)
            ],
          ),
        ),
      ),
    );
  }
}