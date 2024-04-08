import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/authController.dart';
import 'package:mental_helth_wellness/customWidgets/appButton.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/customWidgets/appTextField.dart';
import 'package:mental_helth_wellness/customWidgets/cSpace.dart';
import 'package:mental_helth_wellness/utils/appAnimations.dart';
import 'package:mental_helth_wellness/utils/appColors.dart';
import 'package:mental_helth_wellness/utils/appFonts.dart';
import 'package:mental_helth_wellness/utils/localStorage.dart';
import 'package:mental_helth_wellness/utils/spacing.dart';
import 'package:mental_helth_wellness/views/auth/signupScreen.dart';

import '../../utils/appEnums.dart';
import '../../utils/cacheKeys.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _fromKey = GlobalKey<FormState>();
  //text fields controllers
  TextEditingController emailController = TextEditingController(text: 'a@gmail.com');
  TextEditingController passwordController = TextEditingController(text: 'Aa123123');
  //password toggle
  bool isPassword = true;
  // controllers
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key:_fromKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:Spacing.getDefaultSpacing(context)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // login header title starts
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    alignment: Alignment.center,
                    child: const AppText(
                        text: "How are you doing outside ? Come inside..",
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                    ),
                  ),
              
                  const CSpace(height: 40,),
                  
                  AppText(text: "Sign In",fontSize: 48,fontWeight: FontWeight.w700,color: AppColors().primaryColor),
                  
                  const CSpace(height: 40,),
              
                  Column(
                    children: [
                      CSpace(height: Spacing.getDefaultSpacing(context)),
              
                      // email text field
                      AppTextField(
                        hintText: "Enter Email",
                        controller: emailController,
                        validator: (email){
                          if(email.toString().isEmpty){
                            return "Please enter an email address";
                          }
                          if(!EmailValidator.validate(email.toString())){
                            return "Please enter a valid email address";
                          }
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
                          if(password.toString().isEmpty){
                            return "Please enter your password";
                          }
                          if(password.toString().length > 8 || password.toString().length < 6){
                            return "Password must be 6 to 8 character long";
                          }
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
              
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: (){},
                          child: const AppText(
                            text: "Forgot Password?",
                            fontWeight: FontWeight.w500,
                            textDecoration: TextDecoration.underline,
                          ),
                        ),
                      ),
              
                      // login button
                      SizedBox(
                        width: double.maxFinite,
                        child: AppButton(
                          onPressed: () async {
                            if(_fromKey.currentState!.validate()){
                              await authController.login(email: emailController.text, password: passwordController.text);
                            }

                          },
                          text:"Login"
                        )
                      ),
              
                      const CSpace(height: 40,),
              
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "Don't have an account ?",
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
                                    Get.to(()=>const SignUpScreen(),
                                        transition: AppAnimations.appNavigationTransition,
                                        duration: AppAnimations.appNavigationTransitionDuration,
                                    );
                                  },
                                  child: const AppText(
                                    text: "Create Account",
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
