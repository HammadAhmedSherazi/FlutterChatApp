import 'package:chat_app/export_all.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
   final TextEditingController emailTextController = TextEditingController();
    final TextEditingController passwordTextController =
        TextEditingController();
    final TextEditingController confirmPasswordTextController =
        TextEditingController();

    
  @override
  Widget build(BuildContext context) {
   
    return Form(
      key: AppConstant.formKeyList[0],
      child: PageTemplate1(
        child: [
          
          
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
          10.verticalSpace,
          CustomTextField(
            controller: confirmPasswordTextController,
            validator: (text) {
              if (text == "") {
                return "Please enter a password";
              } else if (text != passwordTextController.text) {
                return "Password is not match";
              } else {
                return null;
              }
            },
            hintText: "Enter a confirm password",
            isPassword: true,
          ),
          20.verticalSpace,
          CustomButtonAndroid(
            onTap: (){
              if(AppConstant.formKeyList[0].currentState!.validate()){
                AppConstant.showloader(context);
                FocusScope.of(context).unfocus();
                FirebaseAuthService.signUpwithEmailPassword(emailTextController.text.trim(), passwordTextController.text.trim()).then((value) {
                  if(value != null){
                      Navigator.of(context)..pop()..pop();
                  }
                  else{
                    Navigator.of(context).pop();
                    AppConstant.messageDialog("Something is Wrong");
                  }
                });
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
