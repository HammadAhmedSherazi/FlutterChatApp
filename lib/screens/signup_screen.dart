import 'package:chat_app/export_all.dart';


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
    return Form(
      key: AppConstant.formKeyList[0],
      child: PageTemplate1(
        child: [
          CustomTextField(
            controller: userNameTextController,
            validator: (text) {
              if (text == "") {
                return "Please enter a username";
              } else if (!(AppConstant.isUsername(text!))) {
                return "Please enter a valid username";
              } else {
                return null;
              }
            },
            hintText: "Enter a username",
            isPassword: false,
          ),
          10.verticalSpace,
          CustomTextField(
            controller: emailTextController,
            validator: (text) {
              if (text == "") {
                return "Please enter a email";
              } else if (!(AppConstant.isEmail(text!))) {
                return "Please enter a valid email";
              } else {
                return null;
              }
            },
            hintText: "Enter a email",
            isPassword: false,
          ),
          10.verticalSpace,
          CustomTextField(
            controller: passwordTextController,
            hintText: "Enter a password",
            validator: (text){
              if(text == ""){
                return "Please enter a password";
              }
              else if(text!.length< 8 ){
                return "Please a enter 8 character password";
                
              }
              else if(!(AppConstant.isStrongPassword(text))){
                return "Password is too weak, please enter strong password";
              }
              else{
                return null;
              }
              
            },
            isPassword: true,
          ),
          20.verticalSpace,
          CustomButtonAndroid(
            onTap: (){
              if(AppConstant.formKeyList[0].currentState!.validate()){
                FocusScope.of(context).unfocus();
                FirebaseAuthService.signUpwithEmailPassword(emailTextController.text.trim(), passwordTextController.text.trim()).then((value) {
                  if(value != null){
                      Navigator.of(context).pop();
                  }
                  else{
                    debugPrint("Something is Wrong");
                  }
                });
              }
              else{
                debugPrint("Validation work is not successfully");

              }
            },
            height: 40.h,
            width: 362.w,
            buttonText: "Signup",
          )
        ],
        bottomText: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You have already an account? ",
              style: TextStyle(color: Colors.black, fontSize: 11.sp),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Text(
                'Login',
                style: TextStyle(
                    color: ColorsApp.kButtonColor,
                    fontSize: 11.sp,
                    decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
      ),
    );
  }
}
