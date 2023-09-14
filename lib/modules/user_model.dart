import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? username;
  final String? imageUrl;
  final String? email;
  final bool? isOnline;
  final String? token;
  final String? createTime;
  final String? createDate;
  final String? lastOnlineTime;
  final List<String?> ? friends;
  final List<String?> ? friendRequests;
  final List<String?> ? notification; 
  

 UserModel(this.uid, this.username, this.imageUrl, this.email, this.isOnline, this.token, this.createDate, this.createTime, this.friendRequests, this.friends, this.lastOnlineTime, this.notification);

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()  as Map<String, dynamic>;
    return UserModel(
      doc.id,
      data['username'] ?? '', // Replace 'username' with the field name in your Firestore document
      data['userImageUrl'] ?? '', // Replace 'userImageUrl' with the field name in your Firestore document
      data['email'] ?? '', // Replace 'email' with the field name in your Firestore document,
      data['isOnline'] ?? false,
      data['token'] ?? '',
      data['createTime'] ?? '',
      data['createDate'] ?? '',
      data['lastOnlineTime'] ?? '',
      data['friends'] ?? [],
      data['friendRequests'] ?? [],
      data['notification'] ?? [],


    );
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['username'] = username;
    data['userImageUrl'] = imageUrl;
    data['email'] = email;
    data['isOnline'] = isOnline;
    data['token'] = token;
    data['createTime'] = createTime;
      data['createDate'] = createDate;
      data['lastOnlineTime'] = lastOnlineTime;
      data['friends']  = friends;
      data['friendRequests'] = friendRequests;
      data['notification'] = notification;

    return data;
  }
}
