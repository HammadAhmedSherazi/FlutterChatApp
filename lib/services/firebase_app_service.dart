import '../export_all.dart';

class FirebaseAppService {
  //Firebase Initializer Function
  static initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}

class FirebaseAuthenticationServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<UserCredential?> signUpwithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(
              email: email,
              password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }
}
