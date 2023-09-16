import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import '../export_all.dart';

class FirebaseAppService {
  //Firebase Initializer Function
  static initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
   AppConstant.deviceToken =  await FirebaseMessaging.instance.getToken();
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
  static String uid = AppConstant.user!.uid;
  static String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  static int currentTime = DateTime.now().millisecondsSinceEpoch;
  

  //UPLOAD IMAGE FUNCTION OF PROFILE
  static Future<String> uploadImage(File imageFile) async {
    String imageUrl = "";
    String fileName = imageFile.path.split('/').last;
    var ref = storage.ref().child('users/$fileName');
    UploadTask uploadTask = ref.putFile(File(imageFile.path));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) => imageUrl = value);
    return imageUrl;
    // print(imageUrl);
  }

  //UPDATE CREATE PROFILE
  static Future saveProfile(
      File? imageFile, String username, email, BuildContext context) async {
    AppConstant.showloader(context);
    FirebaseAppStorage.uploadImage(imageFile!).then((value) {
     final UserModel user = UserModel(uid, username, value, email, false, AppConstant.deviceToken,FirebaseAppStorage.currentDate , FirebaseAppStorage.currentTime, [], [], null, []);
      fireStore
          .collection('Users')
          .doc(uid)
          .set(user.toJson())
          // .set({'userImageUrl': value, 'username': username, 'email': email})
          .then((value) => {
                FirebaseAppStorage.fireStore
                    .collection('Users')
                    .get()
                    .then((value) {
                  if (value.docs.isNotEmpty)  {
                    AppConstant.user =  FirebaseAppStorage.fireStore.collection('Users').doc(uid).get();
                    
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false);
                  }
                })
                // AppConstant.messageDialog('User Profile Successfully updated')
              })
          .onError((error, stackTrace) =>
              {AppConstant.messageDialog(error.toString())});
    });
  }

  //UPDATE USER PROFILE
  static Future updateProfile(
      File? imageFile, String username, email, BuildContext context) async {
    AppConstant.showloader(context);
    if (imageFile != null) {
      FirebaseAppStorage.uploadImage(imageFile).then((value) {
        fireStore
            .collection('Users')
            .doc(uid)
            .set({'userImageUrl': value, 'username': username,})
            .then((value) => {
                  FirebaseAppStorage.fireStore
                      .collection('Users')
                      .get()
                      .then((value) {
                    if (value.docs.isNotEmpty) {
                       Navigator.of(context)..pop()..pop();

                    }
                  })
                  // AppConstant.messageDialog('User Profile Successfully updated')
                })
            .onError((error, stackTrace) =>
                {AppConstant.messageDialog(error.toString())});
      });
    }
    else{
      fireStore
            .collection('Users')
            .doc(uid)
            .update({
              'username': username,
            })
            .then((value) => {
                 Navigator.of(context)..pop()..pop()
                  // AppConstant.messageDialog('User Profile Successfully updated')
                })
            .onError((error, stackTrace) =>
                {AppConstant.messageDialog(error.toString())});
    }
  }

  //FETCH LOGIN USER DATA
  static Future<UserModel?> getUserData(String email) async {
    final snapshot = await fireStore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  //FETCH ALL USER DATA

  static Future<List<UserModel?>?> getAllUser(String email) async {
    final snapshot = await fireStore
        .collection('users')
        .where('email', isNotEqualTo: email)
        .get();
    final userList =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();

    return userList;
  }
}
