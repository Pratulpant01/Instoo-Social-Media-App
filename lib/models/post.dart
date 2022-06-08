import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postUrl;
  final String postId;
  final datePublished;
  final String profImage;
  final likes;

  Post({
    required this.description,
    required this.uid,
    required this.postUrl,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.likes,
    required this.profImage,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "description": description,
        "uid": uid,
        "postUrl": postUrl,
        "postId": postId,
        "datePublished": datePublished,
        "likes": likes,
        "profImage": profImage,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      username: snapshot['username'],
      uid: snapshot['uid'],
      postUrl: snapshot['postUrl'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
      profImage: snapshot['profImage'],
    );
  }
}
