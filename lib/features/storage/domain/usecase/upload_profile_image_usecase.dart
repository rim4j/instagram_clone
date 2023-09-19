import 'dart:io';

import 'package:instagram_clone/common/usecase/use_case.dart';
import 'package:instagram_clone/features/storage/domain/repository/storage_repository.dart';

class UploadProfileImageUseCase implements UseCase<String, File> {
  final StorageRepository storageRepository;

  UploadProfileImageUseCase({
    required this.storageRepository,
  });

  @override
  Future<String> call({File? params}) async {
    return storageRepository.uploadProfileImage(params!);
  }
}
