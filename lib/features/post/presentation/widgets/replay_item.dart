import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/constants/images.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/replay/domain/entities/replay_entity.dart';
import 'package:instagram_clone/features/replay/presentation/bloc/replay_bloc.dart';
import 'package:intl/intl.dart';

class ReplayItem extends StatelessWidget {
  final Size size;
  final num index;
  final AppFontSize appFontSize;
  final ColorScheme colorScheme;
  final ReplayEntity replay;
  final num length;
  final VoidCallback onLongPress;
  final String uid;

  const ReplayItem({
    super.key,
    required this.size,
    required this.index,
    required this.appFontSize,
    required this.colorScheme,
    required this.replay,
    required this.onLongPress,
    required this.length,
    required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    String _profilePicture() {
      if (replay.userProfileUrl == "") {
        return IMAGES.defaultProfile;
      } else {
        return replay.userProfileUrl!;
      }
    }

    bool isLiked = replay.likes!.contains(uid);

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
                        replay.username!,
                        style: robotoMedium.copyWith(
                          fontSize: appFontSize.mediumFontSize,
                          color: colorScheme.onSecondary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        replay.description!,
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
                                .format(replay.createAt!.toDate()),
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
                  BlocProvider.of<ReplayBloc>(context).add(LikeReplayEvent(
                      replay: ReplayEntity(
                    replayId: replay.replayId,
                    commentId: replay.commentId,
                    postId: replay.postId,
                  )));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.small),
                  child: Column(
                    children: [
                      Icon(
                        isLiked
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: isLiked ? Colors.red : colorScheme.onPrimary,
                      ),
                      Text(
                        "${replay.likes!.length}",
                        style: robotoRegular.copyWith(
                          color: colorScheme.onPrimary,
                          fontSize: 10,
                        ),
                      ),
                    ],
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
