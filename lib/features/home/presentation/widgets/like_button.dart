import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/bloc/post_bloc.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/auth_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/user_bloc.dart';

class LikeButton extends StatelessWidget {
  final PostEntity post;
  final ColorScheme colorScheme;

  const LikeButton({
    super.key,
    required this.post,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: colorScheme.background,
          borderRadius: BorderRadius.circular(Dimens.large),
        ),
        child: GestureDetector(
          onTap: () {
            BlocProvider.of<PostBloc>(context)
                .add(LikePostEvent(post: PostEntity(postId: post.postId)));
          },
          child: Row(
            children: [
              const SizedBox(width: Dimens.medium),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, userState) {
                  final auth = userState.authStatus as Authenticated;

                  if (post.likes!.contains(auth.uid)) {
                    return BouncingWidget(
                      onPressed: () {
                        BlocProvider.of<PostBloc>(context).add(LikePostEvent(
                            post: PostEntity(postId: post.postId)));
                      },
                      duration: const Duration(milliseconds: 100),
                      scaleFactor: 3,
                      child: const Icon(
                        CupertinoIcons.heart_fill,
                        color: Colors.red,
                      ),
                    );
                  }

                  return BouncingWidget(
                    duration: const Duration(milliseconds: 100),
                    scaleFactor: 3,
                    onPressed: () {
                      BlocProvider.of<PostBloc>(context).add(
                          LikePostEvent(post: PostEntity(postId: post.postId)));
                    },
                    child: const Icon(
                      CupertinoIcons.heart,
                    ),
                  );
                },
              ),
              const SizedBox(width: Dimens.small),
              Text("${post.likes!.length}"),
              const SizedBox(width: Dimens.medium),
            ],
          ),
        ),
      ),
    );
  }
}
