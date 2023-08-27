import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../export_all.dart';

class FirebaseAppService {
  //Firebase Initializer Function
  static initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}

class FirebaseAuthService {
  //Firebase Instance Initialize
  static FirebaseAuth auth = FirebaseAuth.instance;

  //Firebase SignUp
  static Future<User?> signUpwithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AppConstant.messageDialog('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        AppConstant.messageDialog('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  //Firebase SignIn
  static Future<User?> signInwithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AppConstant.messageDialog('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        AppConstant.messageDialog('Wrong password provided for that user.');
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }
}

class FirebaseAppStorage {
  static final storage = FirebaseStorage.instance;
  // final storageRef = FirebaseStorage.instance.ref();

  static final fireStore = FirebaseFirestore.instance;

  static Future<String> uploadImage(File imageFile) async {
    String imageUrl = "";
    String fileName = imageFile.path.split('/').last;
    final ref = storage.ref().child('users/ $fileName');
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) => imageUrl = value);
    return imageUrl; 
  }

  static Future saveProfile(File imageFile, String username, email, BuildContext context)async{
    AppConstant.showloader(context);
    String url = await FirebaseAppStorage.uploadImage(imageFile);
    String uid = FirebaseAuthService.auth.currentUser!.uid;
    fireStore.collection('users').doc(uid).set({
      'userImageUrl' : url,
      'username' : username,
      'email' : email
    }).then((value) => {
      Navigator.of(context).pop(),
      AppConstant.messageDialog('User Profile Successfully updated')

    }).onError((error, stackTrace) => {
      AppConstant.messageDialog(error.toString())
    });

  }
}
