import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/constants/images.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/comment/domain/entities/comment_entity.dart';
import 'package:instagram_clone/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:intl/intl.dart';

class CommentItem extends StatelessWidget {
  final Size size;
  final num index;
  final AppFontSize appFontSize;
  final ColorScheme colorScheme;
  final CommentEntity comment;
  final num length;
  final VoidCallback onLongPress;
  final String uid;

  const CommentItem({
    Key? key,
    required this.size,
    required this.index,
    required this.appFontSize,
    required this.colorScheme,
    required this.comment,
    required this.length,
    required this.onLongPress,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _profilePicture() {
      if (comment.userProfileUrl == "") {
        return IMAGES.defaultProfile;
      } else {
        return comment.userProfileUrl!;
      }
    }

    bool isLiked = comment.likes!.contains(uid);

    return InkWell(
      onLongPress: onLongPress,
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            Dimens.medium,
            Dimens.medium,
            Dimens.medium,
            //check for last index on comment list
            //commentList.length-1
            index == length - 1 ? size.height / 10 : Dimens.small,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(width: Dimens.small),
                  //avatar
                  SizedBox(
                    width: size.width * 0.1,
                    height: size.width * 0.1,
                    child: CachedNetworkImage(
                      imageUrl: _profilePicture(),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => SizedBox(
                        width: size.width / 3,
                        height: size.width / 3,
                        child: SpinKitPulse(
                          color: colorScheme.primary,
                          size: 100,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(width: Dimens.small),
                  //name profile
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.username!,
                        style: robotoMedium.copyWith(
                          fontSize: appFontSize.mediumFontSize,
                          color: colorScheme.onSecondary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        comment.description!,
                        style: robotoMedium.copyWith(
                          fontSize: appFontSize.smallFontSize,
                          color: colorScheme.onSecondary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            DateFormat("dd/MMM/yyy")
                                .format(comment.createAt!.toDate()),
                            style: robotoMedium.copyWith(
                              fontSize: appFontSize.verySmallFontSize,
                              color: colorScheme.onSecondary,
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              print("reply");
                              // setState(() {
                              //   isReply = !isReply;
                              // });
                            },
                            child: Text(
                              "Replay",
                              style: robotoMedium.copyWith(
                                fontSize: appFontSize.verySmallFontSize,
                                color: colorScheme.onSecondary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "View Replays",
                            style: robotoMedium.copyWith(
                              fontSize: appFontSize.verySmallFontSize,
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<CommentBloc>(context)
                      .add(LikeCommentEvent(comment: comment));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.small),
                  child: Icon(
                    isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                    color: isLiked ? Colors.red : Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
