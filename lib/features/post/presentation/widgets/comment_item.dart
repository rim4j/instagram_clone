import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/constants/images.dart';
import 'package:instagram_clone/common/widgets/custom_button.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/comment/domain/entities/comment_entity.dart';
import 'package:instagram_clone/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:instagram_clone/features/post/presentation/widgets/replay_item.dart';
import 'package:instagram_clone/features/replay/domain/entities/replay_entity.dart';
import 'package:instagram_clone/features/replay/presentation/bloc/replay_bloc.dart';
import 'package:instagram_clone/features/replay/presentation/bloc/status/read_replays_status.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CommentItem extends StatefulWidget {
  final Size size;
  final num index;
  final AppFontSize appFontSize;
  final ColorScheme colorScheme;
  final CommentEntity comment;
  final num length;
  final VoidCallback onLongPress;
  final UserEntity user;

  const CommentItem({
    Key? key,
    required this.size,
    required this.index,
    required this.appFontSize,
    required this.colorScheme,
    required this.comment,
    required this.length,
    required this.onLongPress,
    required this.user,
  }) : super(key: key);

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  TextEditingController replayController = TextEditingController();

  Future<void> _deleteDialogReplay(BuildContext context, ReplayEntity replay) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: widget.colorScheme.background,
          title: Text(
            'Delete',
            style: robotoMedium,
          ),
          content: Text(
            'Are you sure to delete the replay?',
            style: robotoRegular,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'No',
                style: robotoRegular.copyWith(
                  color: widget.colorScheme.onPrimary,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: robotoRegular.copyWith(
                  color: widget.colorScheme.onPrimary,
                ),
              ),
              onPressed: () {
                BlocProvider.of<ReplayBloc>(context)
                    .add(DeleteReplayEvent(replay: replay));

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  //show replays
  Future<dynamic> _showViewReplayBottomSheet(
    BuildContext context,
    Size size,
    AppFontSize appFontSize,
    ColorScheme colorScheme,
  ) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: ((context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: size.height / 1.1,
            decoration: BoxDecoration(
              color: widget.colorScheme.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimens.large - 2),
                topRight: Radius.circular(Dimens.large - 2),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: Dimens.small),
                Container(
                  width: size.width / 8,
                  height: 6,
                  decoration: BoxDecoration(
                    color: widget.colorScheme.onPrimary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(Dimens.xLarge),
                  ),
                ),
                BlocBuilder<ReplayBloc, ReplayState>(
                  builder: (context, replayState) {
                    final replaysStatus = replayState.readReplaysStatus;

                    if (replaysStatus is ReadReplaysLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (replaysStatus is ReadReplaysSuccess) {
                      final List<ReplayEntity> replays = replaysStatus.replays;
                      return Flexible(
                        child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: ListView.builder(
                              itemCount: replays.length,
                              itemBuilder: (context, index) {
                                final ReplayEntity replay = replays[index];

                                return ReplayItem(
                                  uid: widget.user.uid!,
                                  size: size,
                                  index: index,
                                  appFontSize: appFontSize,
                                  colorScheme: colorScheme,
                                  replay: replay,
                                  onLongPress: () {
                                    if (widget.user.uid == replay.creatorUid) {
                                      _deleteDialogReplay(
                                          context,
                                          ReplayEntity(
                                            replayId: replay.replayId,
                                            postId: replay.postId,
                                            commentId: replay.commentId,
                                          ));
                                    }
                                    return;
                                  },
                                  length: replays.length,
                                );
                              },
                            )),
                      );
                    }

                    if (replaysStatus is ReadReplaysFailed) {
                      return const Center(
                        child: Text("something went wrong"),
                      );
                    }

                    return Container();
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  //create replay
  Future<dynamic> _showReplayBottomSheet(
    BuildContext context,
    Size size,
  ) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: ((context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: size.height / 3,
            decoration: BoxDecoration(
              color: widget.colorScheme.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimens.large - 2),
                topRight: Radius.circular(Dimens.large - 2),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: Dimens.small),
                Container(
                  width: size.width / 8,
                  height: 6,
                  decoration: BoxDecoration(
                    color: widget.colorScheme.onPrimary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(Dimens.xLarge),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: widget.size.width,
                          child: TextField(
                            controller: replayController,
                            style: robotoRegular,
                            decoration: InputDecoration(
                              hintText: "replay",
                              hintStyle: robotoRegular,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: Dimens.large,
                        ),
                        CustomButton(
                          title: "Replay",
                          onTap: () {
                            if (replayController.text == "") return;

                            BlocProvider.of<ReplayBloc>(context).add(
                              CreateReplayEvent(
                                replay: ReplayEntity(
                                  commentId: widget.comment.commentId,
                                  likes: const [],
                                  replayId: const Uuid().v1(),
                                  createAt: Timestamp.now(),
                                  username: widget.user.username,
                                  userProfileUrl: widget.user.profileUrl,
                                  creatorUid: widget.user.uid,
                                  postId: widget.comment.postId,
                                  description: replayController.text,
                                ),
                              ),
                            );
                            replayController.clear();
                            Navigator.pop(context);
                          },
                          appFontSize: widget.appFontSize,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    String _profilePicture() {
      if (widget.comment.userProfileUrl == "") {
        return IMAGES.defaultProfile;
      } else {
        return widget.comment.userProfileUrl!;
      }
    }

    bool isLiked = widget.comment.likes!.contains(widget.user.uid);

    return InkWell(
      onLongPress: widget.onLongPress,
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            Dimens.medium,
            Dimens.medium,
            Dimens.medium,
            //check for last index on comment list
            //commentList.length-1
            widget.index == widget.length - 1
                ? widget.size.height / 10
                : Dimens.small,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(width: Dimens.small),
                  //avatar
                  SizedBox(
                    width: widget.size.width * 0.1,
                    height: widget.size.width * 0.1,
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
                        width: widget.size.width / 3,
                        height: widget.size.width / 3,
                        child: SpinKitPulse(
                          color: widget.colorScheme.primary,
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
                        widget.comment.username!,
                        style: robotoMedium.copyWith(
                          fontSize: widget.appFontSize.mediumFontSize,
                          color: widget.colorScheme.onSecondary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.comment.description!,
                        style: robotoMedium.copyWith(
                          fontSize: widget.appFontSize.smallFontSize,
                          color: widget.colorScheme.onSecondary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            DateFormat("dd/MMM/yyy")
                                .format(widget.comment.createAt!.toDate()),
                            style: robotoMedium.copyWith(
                              fontSize: widget.appFontSize.verySmallFontSize,
                              color: widget.colorScheme.onSecondary,
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              print("reply");
                              _showReplayBottomSheet(context, widget.size);
                            },
                            child: Text(
                              "Replay",
                              style: robotoMedium.copyWith(
                                fontSize: widget.appFontSize.verySmallFontSize,
                                color: widget.colorScheme.onSecondary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<ReplayBloc>(context).add(
                                ReadReplaysEvent(
                                    replay: ReplayEntity(
                                  postId: widget.comment.postId,
                                  commentId: widget.comment.commentId,
                                )),
                              );
                              _showViewReplayBottomSheet(
                                context,
                                widget.size,
                                widget.appFontSize,
                                widget.colorScheme,
                              );
                            },
                            child: Text(
                              "View Replays",
                              style: robotoMedium.copyWith(
                                fontSize: widget.appFontSize.verySmallFontSize,
                                color: widget.colorScheme.onSecondary,
                              ),
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
                      .add(LikeCommentEvent(comment: widget.comment));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.small),
                  child: Column(
                    children: [
                      Icon(
                        isLiked
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color:
                            isLiked ? Colors.red : widget.colorScheme.onPrimary,
                      ),
                      Text(
                        "${widget.comment.likes!.length}",
                        style: robotoRegular.copyWith(
                          color: widget.colorScheme.onPrimary,
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
