import 'package:chat_app/export_all.dart';


class UserInfoProvider extends StateNotifier<UserModel ?>{
  UserInfoProvider() : super(null);
  

  void setUser(UserModel userData){
    state = userData;
  }


}

// final userInfoProvider = Provider.autoDispose<UserInfoProvider>((ref) => UserInfoProvider());


final fetchUserProvider = FutureProvider.family<UserModel , String>((ref, uid) async {
  final snapshot = await FirebaseAppStorage.fireStore.collection('Users').doc(uid).get();
    final userData = UserModel.fromSnapshot(snapshot);
    return userData;


});

final fetchAllUserProvider = StreamProvider.family.autoDispose<List<UserModel?> , String>((ref, email) async* {
  // Connect to an API using sockets, and decode the output
  final snapshot = await FirebaseAppStorage.fireStore.collection('Users').where('email', isNotEqualTo:  email).get();
    yield snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    
});