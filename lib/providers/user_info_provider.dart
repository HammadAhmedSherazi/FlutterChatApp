import 'package:chat_app/export_all.dart';


class UserInfoProvider extends StateNotifier<UserModel ?>{
  UserInfoProvider() : super(null);
  

  void setUser(UserModel userData){
    state = userData;
  }


}

final userInfoProvider = Provider.autoDispose<UserInfoProvider>((ref) => UserInfoProvider());


final fetchUserProvider = FutureProvider.family<dynamic , String>((ref, uid) async {
  final userData = await FirebaseAppStorage.fireStore.collection('Users').doc(uid).get();
    // final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;


});