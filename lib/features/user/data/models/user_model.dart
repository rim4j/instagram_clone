import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    final String? uid,
    final String? username,
    final String? name,
    final String? bio,
    final String? website,
    final String? email,
    final String? profileUrl,
    final String? coverUrl,
    final List? followers,
    final List? following,
    final num? totalFollowers,
    final num? totalFollowing,
    final num? totalPosts,
  }) : super(
          uid: uid,
          username: username,
          name: name,
          bio: bio,
          website: website,
          email: email,
          profileUrl: profileUrl,
          coverUrl: coverUrl,
          followers: followers,
          following: following,
          totalFollowers: totalFollowers,
          totalFollowing: totalFollowing,
          totalPosts: totalPosts,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      uid: snapshot['uid'],
      username: snapshot['username'],
      name: snapshot['name'],
      bio: snapshot['bio'],
      website: snapshot['website'],
      email: snapshot['email'],
      profileUrl: snapshot['profileUrl'],
      coverUrl: snapshot['coverUrl'],
      followers: List.from(snap.get("followers")),
      following: List.from(snap.get("following")),
      totalFollowers: snapshot['totalFollowers'],
      totalFollowing: snapshot['totalFollowing'],
      totalPosts: snapshot['totalPosts'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "username": username,
        "totalFollowers": totalFollowers,
        "totalFollowing": totalFollowing,
        "totalPosts": totalPosts,
        "website": website,
        "bio": bio,
        "profileUrl": profileUrl,
        "coverUrl": coverUrl,
        "followers": followers,
        "following": following,
      };
}
