import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String username;
  final String imageUrl;
  final String email;
  final bool isOnline;

  UserModel(this.uid, this.username, this.imageUrl, this.email, this.isOnline);

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()  as Map<String, dynamic>;
    return UserModel(
      doc.id,
      data['username'] ?? '', // Replace 'username' with the field name in your Firestore document
      data['userImageUrl'] ?? '', // Replace 'userImageUrl' with the field name in your Firestore document
      data['email'] ?? '', // Replace 'email' with the field name in your Firestore document,
      data['isOnline'] ?? false
    );
  }
}
