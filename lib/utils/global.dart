import 'package:flutter/services.dart';

import '../export_all.dart';

class AppConstant {

  static late final String? deviceToken;

  //Firebase Current User on Device
  static final User? user = FirebaseAuthService.auth.currentUser;

  //assets Path
  static String imagePath = "assets/";

  // static final formKey = GlobalKey<FormState>();
  static List<GlobalObjectKey<FormState>> formKeyList =
      List.generate(3, (index) => GlobalObjectKey<FormState>(index));

  //Email Validation Checker function
  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }

//Username Validation Checker function
  static bool isUsername(String username) {
    String pattern =
        r'^[a-zA-Z0-9_]+$'; // This pattern allows letters (both cases), digits, and underscores
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(username);
  }

  //Password Validation Checker function
//   static bool isStrongPassword(String password) {
//   String pattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
//   RegExp regExp = RegExp(pattern);
//   return regExp.hasMatch(password);
// }
  static bool isStrongPassword(String password) {
    String pattern =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

  //Message Alert 
  static messageDialog(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorsApp.kButtonColor,
        textColor: Colors.white,
        fontSize: 14.sp);
  }

  //Loader 
  static final spinkit =  SpinKitDancingSquare(
    color: ColorsApp.kButtonColor,
    size: 50.r,
  );

  //loader ShowDialog
  static showloader(BuildContext context){
    return showDialog(context: context , builder: (context) => WillPopScope(child: spinkit, onWillPop:()async{
      SystemNavigator.pop();
      return true;
    }),);
  }
}
