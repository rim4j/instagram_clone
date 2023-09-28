import 'dart:io';

abstract class StorageRepository {
  Future<String> uploadProfileImage(File file);
  Future<String> uploadCoverImage(File file);
  Future<String> uploadPostImage(File file);
}
