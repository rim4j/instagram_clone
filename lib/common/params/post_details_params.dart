import 'package:flutter/material.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';

class PostDetailsParams {
  final PostEntity postEntity;
  final PageController pageController;

  PostDetailsParams({required this.postEntity, required this.pageController});
}
