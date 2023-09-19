import 'dart:io';

abstract class StorageRemoteDataSource {
  Future<String> uploadProfileImage(File file);
  Future<String> uploadCoverImage(File file);
}
