import 'dart:io';

import 'package:instagram_clone/features/storage/data/data_source/storage_remote_data_source.dart';
import 'package:instagram_clone/features/storage/domain/repository/storage_repository.dart';

class StorageRepositoryImpl implements StorageRepository {
  final StorageRemoteDataSource storageRemoteDataSource;

  StorageRepositoryImpl({
    required this.storageRemoteDataSource,
  });

  @override
  Future<String> uploadProfileImage(File file) async {
    return storageRemoteDataSource.uploadProfileImage(file);
  }

  @override
  Future<String> uploadCoverImage(File file) async {
    return storageRemoteDataSource.uploadCoverImage(file);
  }

  @override
  Future<String> uploadPostImage(File file) {
    return storageRemoteDataSource.uploadPostImage(file);
  }
}
