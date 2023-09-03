// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  // final String ? uid;
  late final String ? username;
  late final String ? imageUrl;
  late final String ? email;

  UserModel(this.username, this.email, this.imageUrl);

  UserModel.fromJson(Map<String, dynamic>  data){
    // uid = data['']
    username = data['username'];
    imageUrl = data['userImageUrl'];
    email = data['email'];
  }
  UserModel.fromSnapshot(DocumentSnapshot <Map<String, dynamic>> doc){
    final data = doc.data();
    // uid = doc.id;
    username = data?['username'];
    imageUrl = data?['userImageUrl'];
    email = data?['email'];

  }
}