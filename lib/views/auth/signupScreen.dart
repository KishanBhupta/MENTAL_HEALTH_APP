import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/authController.dart';

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
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  bool isPassword = true;
  bool isConfirmPassword = true;

  AuthController authController = AuthController();

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

                      // user name text field
                      AppTextField(
                        hintText: "Enter User Name",
                        controller: userNameController,
                        validator: (lastName){
                          if(lastName.toString().isEmpty){
                            return "Please enter your user name.";
                          }
                          return null;
                        },
                        isBorderEnabled: true,
                        borderType: BorderType.rectangleBorder,
                        prefixIcon:Icon(Icons.person_2_outlined,color: AppColors().primaryColor),
                      ),
                      CSpace(height: Spacing.getDefaultSpacing(context)),

                      // first name text field
                      AppTextField(
                        hintText: "Enter First Name",
                        controller: firstNameController,
                        validator: (firstName){
                          if(firstName.toString().isEmpty){
                            return "Please enter an your first name.";
                          }
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
                        validator: (lastName){
                          if(lastName.toString().isEmpty){
                            return "Please enter your last name.";
                          }
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
                          if(email.toString().isEmpty){
                            return "Please enter an email address.";
                          }
                          if(!EmailValidator.validate(email.toString())){
                            return "Please enter a valid email address.";
                          }
                          return null;
                        },
                        isBorderEnabled: true,
                        borderType: BorderType.rectangleBorder,
                        prefixIcon:Icon(Icons.email_outlined,color: AppColors().primaryColor),
                      ),
                      CSpace(height: Spacing.getDefaultSpacing(context)),

                      // phone number
                      AppTextField(
                        hintText: "Enter Phone Number",
                        controller: phoneNumberController,
                        validator: (phone){
                          if(phone.toString().isEmpty){
                            return "Please enter your phone number.";
                          }
                          if(!RegExp(r"\d{10}").hasMatch(phone.toString())){
                            return "Phone number must be of 10 digit";
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        isBorderEnabled: true,
                        borderType: BorderType.rectangleBorder,
                        prefixIcon:Icon(Icons.call_outlined,color: AppColors().primaryColor),
                      ),
                      CSpace(height: Spacing.getDefaultSpacing(context)),

                      // password text field
                      AppTextField(
                        hintText: "Enter Password",
                        isPassword: isPassword,
                        controller: passwordController,
                        validator: (password) {
                          if(password.toString().isEmpty){
                            return "Please enter a password.";
                          }
                          if(password.toString().length < 6){
                            return "Password must be 6 character long.";
                          }
                          if(!RegExp(r"(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])").hasMatch(password.toString())){
                            return "Password must contain 1 Capital character and 1 Digit";
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

                      // confirm password text field
                      AppTextField(
                        hintText: "Confirm Password",
                        isPassword: isConfirmPassword,
                        controller: confirmPasswordController,
                        validator: (confirmPassword) {
                          if(confirmPassword.toString().isEmpty){
                            return "Please enter confirmation password";
                          }
                          if(confirmPassword.toString().compareTo(passwordController.text.toString())!=0){
                            return "Confirm password does not match the password.";
                          }
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
                            onPressed: () async {

                              if(_formKey.currentState!.validate()){
                                await authController.register(
                                    userName: userNameController.text,
                                    email: emailController.text,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    password: passwordController.text,
                                    phoneNumber: phoneNumberController.text
                                );
                              }

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
