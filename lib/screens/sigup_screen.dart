import 'package:chat_app/export_all.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailTextController = TextEditingController();
    final TextEditingController passwordTextController =
        TextEditingController();
    final TextEditingController userNameTextController =
        TextEditingController();
    return PageTemplate1(
      child: [
        CustomTextField(
          controller: userNameTextController,
          hintText: "Enter a username",
          isPassword: false,
        ),
        10.verticalSpace,
        CustomTextField(
          controller: emailTextController,
          hintText: "Enter a email",
          isPassword: false,
        ),
        10.verticalSpace,
        CustomTextField(
          controller: passwordTextController,
          hintText: "Enter a password",
          isPassword: true,
        ),
        20.verticalSpace,
        CustomButtonAndroid(
          height: 40.h,
          width: 362.w,
          buttonText: "Signup",
        )
      ],
      bottomText: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("You have already an account? ", style: TextStyle(
            color: Colors.black,
            fontSize: 11.sp
          ),),
          GestureDetector(
            onTap: ()=>Navigator.of(context).pop(),
            child: Text('Signup', style: TextStyle(
              color: ColorsApp.kButtonColor,
              fontSize: 11.sp,
              decoration: TextDecoration.underline
            ),),
          )
        ],
      ),

    );
    
  }
}
