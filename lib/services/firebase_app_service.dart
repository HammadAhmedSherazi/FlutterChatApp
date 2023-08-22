import '../export_all.dart';

class FirebaseAppService{

    //Firebase Initializer Function
     static initializeFirebase() async {
        await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
     }
}