import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? imageUrl;
  final String? email;
  final bool? isOnline;
  final String? token;
  final int? createTime;
  final String? createDate;
  final String? lastOnlineTime;
  final List friends;
  final List friendRequests;
  final List notification;

  UserModel(
      this.uid,
      this.username,
      this.firstName,
      this.lastName,
      this.imageUrl,
      this.email,
      this.isOnline,
      this.token,
      this.createDate,
      this.createTime,
      this.friendRequests,
      this.friends,
      this.lastOnlineTime,
      this.notification);

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    UserModel user = UserModel(
        doc.id,
        data['username'] ?? '',
        data['firstName'] ?? "",
        data['lastName'] ?? "",
        data['userImageUrl'] ?? '',
        data['email'] ?? '',
        data['isOnline'] ?? false,
        data['token'] ?? '',
        data['createDate'] ?? '',
        data['createTime'] ?? 0,
        data['friendRequests'] ?? [],
        data['friends'] ?? [],
       data['lastOnlineTime'] ?? "",
        data['notification'] ?? []);
     return user;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['userImageUrl'] = imageUrl;
    data['email'] = email;
    data['isOnline'] = isOnline;
    data['token'] = token;
    data['createTime'] = createTime;
    data['createDate'] = createDate;
    data['lastOnlineTime'] = lastOnlineTime;
    data['friends'] = friends;
    data['friendRequests'] = friendRequests;
    data['notification'] = notification;

    return data;
  }
}
