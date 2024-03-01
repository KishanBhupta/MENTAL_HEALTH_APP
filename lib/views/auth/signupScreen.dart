import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/views/onBoarding/onBoardingMainScreen.dart';

import '../../customWidgets/appButton.dart';
import '../../customWidgets/appText.dart';
import '../../customWidgets/appTextField.dart';
import '../../customWidgets/cSpace.dart';
import '../../utils/appColors.dart';
import '../../utils/appEnums.dart';
import '../../utils/appFonts.dart';
import '../../utils/spacing.dart';
import 'loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isPassword = true;
  bool isConfirmPassword = true;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key:_formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:Spacing.getDefaultSpacing(context)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // login header title starts
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: const AppText(
                      text: "Empowering Minds, Join Us in Prioritizing Mental Health!",
                      fontSize: 26,
                      maxLines: 5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const CSpace(height: 20,),

                  AppText(text: "Sign Up",fontSize: 38,fontWeight: FontWeight.w700,color: AppColors().primaryColor),

                  const CSpace(height: 20,),

                  Column(
                    children: [
                      CSpace(height: Spacing.getDefaultSpacing(context)),

                      // first name text field
                      AppTextField(
                        hintText: "Enter First Name",
                        controller: firstNameController,
                        validator: (email){
                          return null;
                        },
                        isBorderEnabled: true,
                        borderType: BorderType.rectangleBorder,
                        prefixIcon:Icon(Icons.person_2_outlined,color: AppColors().primaryColor),
                      ),
                      CSpace(height: Spacing.getDefaultSpacing(context)),

                      // first name text field
                      AppTextField(
                        hintText: "Enter Last Name",
                        controller: lastNameController,
                        validator: (email){
                          return null;
                        },
                        isBorderEnabled: true,
                        borderType: BorderType.rectangleBorder,
                        prefixIcon:Icon(Icons.person_2_outlined,color: AppColors().primaryColor),
                      ),
                      CSpace(height: Spacing.getDefaultSpacing(context)),

                      // email text field
                      AppTextField(
                        hintText: "Enter Email",
                        controller: emailController,
                        validator: (email){
                          return null;
                        },
                        isBorderEnabled: true,
                        borderType: BorderType.rectangleBorder,
                        prefixIcon:Icon(Icons.email_outlined,color: AppColors().primaryColor),
                      ),
                      CSpace(height: Spacing.getDefaultSpacing(context)),

                      // password text field
                      AppTextField(
                        hintText: "Enter Password",
                        isPassword: isPassword,
                        controller: passwordController,
                        validator: (password) {
                          return null;
                        },
                        isBorderEnabled: true,
                        borderType: BorderType.rectangleBorder,
                        suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          icon: Icon(
                            color: Colors.black54,
                            isPassword ? Icons.remove_red_eye_outlined : CupertinoIcons.eye_slash,
                          ),
                        ),
                        prefixIcon: Icon(Icons.lock_outline,color: AppColors().primaryColor),
                      ),
                      CSpace(height: Spacing.getDefaultSpacing(context)),

                      // confirm password text field
                      AppTextField(
                        hintText: "Confirm Password",
                        isPassword: isConfirmPassword,
                        controller: confirmPasswordController,
                        validator: (password) {
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              isConfirmPassword = !isConfirmPassword;
                            });
                          },
                          icon: Icon(
                            color: Colors.black54,
                            isConfirmPassword ? Icons.remove_red_eye_outlined : CupertinoIcons.eye_slash,
                          ),
                        ),
                        isBorderEnabled: true,
                        borderType: BorderType.rectangleBorder,
                        prefixIcon: Icon(Icons.lock_outline,color: AppColors().primaryColor),
                      ),
                      CSpace(height: Spacing.getDefaultSpacing(context)),


                      // login button
                      SizedBox(
                          width: double.maxFinite,
                          child: AppButton(
                            onPressed: (){
                              // TODO :START ONBOARDING FLOW
                              Get.to(()=>const OnBoardingMainScreen());
                            },
                            text:"Sign Up",
                          )
                      ),

                      CSpace(height: Spacing.getDefaultSpacing(context)),

                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Already have an account ?",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: AppFonts.publicSans,
                                fontWeight: FontWeight.w500
                            ),
                            children: [
                              WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: TextButton(
                                    onPressed: (){
                                      Get.to(()=>const LoginScreen());
                                    },
                                    child: const AppText(
                                      text: "Sign In",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      textDecoration: TextDecoration.underline,
                                    ),
                                  )
                              )
                            ]
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
