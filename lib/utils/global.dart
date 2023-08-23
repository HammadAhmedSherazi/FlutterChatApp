import '../export_all.dart';

class AppConstant {
  // static final formKey = GlobalKey<FormState>();
  static List<GlobalObjectKey<FormState>> formKeyList = List.generate(2, (index) => GlobalObjectKey<FormState>(index));

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
  String pattern = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(password);
}
}
