import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instoo/models/post.dart';
import 'package:instoo/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String result = "Some error occurred";

    try {
      String photoUrl = await StorageMethods().uploadImagetoStorage(
        'posts',
        file,
        true,
      );
      String postId = Uuid().v1();

      Post post = Post(
          description: description,
          uid: uid,
          postUrl: photoUrl,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          likes: [],
          profImage: profImage);

      _firestore.collection('posts').doc(postId).set(post.toJson());
      result = 'success';
    } catch (err) {
      result = err.toString();
    }
    return result;
  }
}
