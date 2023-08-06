import '../export_all.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  PageTemplate1(
      bottomText: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Do have not signup account? ", style: TextStyle(
            color: Colors.black,
            fontSize: 11.sp
          ),),
          GestureDetector(
            onTap: ()=>Navigator.pushNamedAndRemoveUntil(context, "/SignupScreen", (route) => false),
            child: Text('Signup', style: TextStyle(
              color: ColorsApp.kButtonColor,
              fontSize: 11.sp,
              decoration: TextDecoration.underline
            ),),
          )
        ],
      ),
      child: [
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
          buttonText: "Login",
        )
      ],
    );
  }
}