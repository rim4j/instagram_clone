import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:instagram_clone/features/storage/data/data_source/storage_remote_data_source.dart';
import 'package:uuid/uuid.dart';

class StorageRemoteDataSourceImpl implements StorageRemoteDataSource {
  final FirebaseStorage firebaseStorage;
  final FirebaseAuth firebaseAuth;

  StorageRemoteDataSourceImpl({
    required this.firebaseStorage,
    required this.firebaseAuth,
  });

  @override
  Future<String> uploadProfileImage(File file) async {
    Reference ref = firebaseStorage
        .ref()
        .child("profileImages")
        .child(firebaseAuth.currentUser!.uid);

    final uploadTask = ref.putFile(file);

    final imageUrl =
        (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return imageUrl;
  }

  @override
  Future<String> uploadCoverImage(File file) async {
    Reference ref = firebaseStorage
        .ref()
        .child("coverImages")
        .child(firebaseAuth.currentUser!.uid);

    final uploadTask = ref.putFile(file);

    final imageUrl =
        (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return imageUrl;
  }

  @override
  Future<String> uploadPostImage(File file) async {
    final uuid = const Uuid().v1();

    Reference ref = firebaseStorage
        .ref()
        .child("posts")
        .child("${firebaseAuth.currentUser!.uid}$uuid");

    final uploadTask = ref.putFile(file);

    final imageUrl =
        (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return imageUrl;
  }
}
