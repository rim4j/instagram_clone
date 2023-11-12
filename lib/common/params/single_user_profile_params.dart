import 'package:flutter/material.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';

class SingleUserProfileParams {
  final PostEntity postEntity;
  final PageController? pageController;

  SingleUserProfileParams({required this.postEntity, this.pageController});
}
