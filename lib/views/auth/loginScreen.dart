import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental_helth_wellness/customWidgets/appText.dart';
import 'package:mental_helth_wellness/customWidgets/cSpace.dart';
import 'package:mental_helth_wellness/utils/spacing.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _fromKey = GlobalKey<FormState>();
  //text fields controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key:_fromKey,
          child: Container(
            padding: EdgeInsets.all(Spacing.getDefaultSpacing(context)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // login header title starts
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  alignment: Alignment.center,
                  child: const AppText(
                      text: "How are you doing outside ? Come inside..",
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                  ),
                ),

                CSpace(height: 40,),
                
                const AppText(text: "Sign In",fontSize: 32,),
                
                CSpace(height: 40,),
            
                Column(
                  children: [
                    CSpace(height: Spacing.getDefaultSpacing(context)),

                    // email text field
                    TextFormField(
                        controller: emailController,
                        decoration:InputDecoration(
                          hintText:"Enter Email Address",
                        )
                    ),
                    CSpace(height: Spacing.getDefaultSpacing(context)),

                    // password text field
                    TextFormField(
                        controller: passwordController,
                        decoration:const InputDecoration(
                          hintText:"Enter Email Address",
                        )
                    ),
                    CSpace(height: Spacing.getDefaultSpacing(context)),

                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: (){},
                        child: const AppText(
                          text: "Forgot Password?",
                          textDecoration: TextDecoration.underline,
                        ),
                      ),
                    ),

                    // login button
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                        onPressed: (){

                        },
                        child: const AppText(
                            text: "Login",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    CSpace(height: 40,),

                    RichText(
                        text: const TextSpan(
                          text: "Don't have an account ? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16
                          ),
                          children: [
                            TextSpan(
                              text: "Create Account",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                                fontSize: 16
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
    );
  }
}
