import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/replay/domain/entities/replay_entity.dart';

class ReplayModel extends ReplayEntity {
  const ReplayModel({
    final String? creatorUid,
    final String? replayId,
    final String? commentId,
    final String? postId,
    final String? description,
    final String? username,
    final String? userProfileUrl,
    final List<String>? likes,
    final Timestamp? createAt,
  }) : super(
            description: description,
            commentId: commentId,
            postId: postId,
            creatorUid: creatorUid,
            userProfileUrl: userProfileUrl,
            username: username,
            likes: likes,
            createAt: createAt,
            replayId: replayId);

  factory ReplayModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ReplayModel(
      postId: snapshot['postId'],
      creatorUid: snapshot['creatorUid'],
      description: snapshot['description'],
      userProfileUrl: snapshot['userProfileUrl'],
      commentId: snapshot['commentId'],
      replayId: snapshot['replayId'],
      createAt: snapshot['createAt'],
      username: snapshot['username'],
      likes: List.from(snap.get("likes")),
    );
  }

  Map<String, dynamic> toJson() => {
        "creatorUid": creatorUid,
        "description": description,
        "userProfileUrl": userProfileUrl,
        "commentId": commentId,
        "createAt": createAt,
        "replayId": replayId,
        "postId": postId,
        "likes": likes,
        "username": username,
      };
}
