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
    return  Form(
      key: AppConstant.formKeyList[1],
      child: PageTemplate1(
        bottomText: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Do have not signup account? ", style: TextStyle(
              color: Colors.black,
              fontSize: 11.sp
            ),),
            GestureDetector(
              onTap: ()=>Navigator.pushNamed(context, "/SignupScreen"),
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
            validator: (text) {
                if (text == "") {
                  return "Please enter a email";
                } else if (!(AppConstant.isEmail(text!))) {
                  return "Please enter a valid email";
                } else {
                  return null;
                }
              },
            isPassword: false,
          ),
          10.verticalSpace,
          CustomTextField(
            controller: passwordTextController,
            hintText: "Enter a password",
            validator: (text) {
                if (text == "") {
                  return "Please enter a password";
                } else {
                  return null;
                }
                },
            isPassword: true,
          ),
          20.verticalSpace,
          CustomButtonAndroid(
            onTap: (){
              if(AppConstant.formKeyList[1].currentState!.validate()){
                AppConstant.showloader(context);
                FocusScope.of(context).unfocus();
                FirebaseAuthService.signInwithEmailPassword(emailTextController.text.trim(), passwordTextController.text.trim()).then((value) {
                  if(value != null){
                    
                    Navigator.pushNamedAndRemoveUntil(context, "/HomeScreen", (route) => false);

                  }
                  else{
                    Navigator.of(context).pop();
                    debugPrint("Something is wrong");
                  }
                });
              }
            },
            height: 40.h,
            width: 362.w,
            buttonText: "Login",
          )
        ],
      ),
    );
  }
}