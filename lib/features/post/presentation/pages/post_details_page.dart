import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/constants/images.dart';
import 'package:instagram_clone/config/routes/route_names.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/comment/domain/entities/comment_entity.dart';
import 'package:instagram_clone/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:instagram_clone/features/comment/presentation/bloc/status/read_comment_status.dart';
import 'package:instagram_clone/features/home/presentation/widgets/like_button.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/bloc/post_bloc.dart';
import 'package:instagram_clone/features/post/presentation/bloc/status/single_post_status.dart';
import 'package:instagram_clone/features/post/presentation/widgets/comment_item.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/usecases/get_current_uid_usecase.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/profile_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/user_bloc.dart';
import 'package:instagram_clone/locator.dart';
import 'package:readmore/readmore.dart';
import 'package:uuid/uuid.dart';

class PostDetailsPage extends StatefulWidget {
  final PostEntity post;

  const PostDetailsPage({
    super.key,
    required this.post,
  });

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final uid = locator<GetCurrentUidUseCase>().call();

    uid.then((uid) {
      BlocProvider.of<UserBloc>(context).add(GetProfileEvent(uid: uid));
    });

    BlocProvider.of<PostBloc>(context)
        .add(GetSinglePostEvent(postId: widget.post.postId!));

    BlocProvider.of<CommentBloc>(context)
        .add(ReadCommentEvent(postId: widget.post.postId!));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    AppFontSize appFontSize = AppFontSize(size: size);

    Future<void> _dialogBuilder(BuildContext context) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: colorScheme.background,
            title: Text(
              'Delete',
              style: robotoMedium,
            ),
            content: Text(
              'Are you sure to delete the post?',
              style: robotoRegular,
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'No',
                  style: robotoRegular.copyWith(
                    color: colorScheme.onPrimary,
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
                    color: colorScheme.onPrimary,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  BlocProvider.of<PostBloc>(context).add(DeletePostEvent(
                      post: PostEntity(postId: widget.post.postId)));
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _deleteDialogComment(
        BuildContext context, CommentEntity comment) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: colorScheme.background,
            title: Text(
              'Delete',
              style: robotoMedium,
            ),
            content: Text(
              'Are you sure to delete the comment?',
              style: robotoRegular,
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'No',
                  style: robotoRegular.copyWith(
                    color: colorScheme.onPrimary,
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
                    color: colorScheme.onPrimary,
                  ),
                ),
                onPressed: () {
                  BlocProvider.of<CommentBloc>(context)
                      .add(DeleteCommentEvent(comment: comment));
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    return BlocBuilder<PostBloc, PostState>(
      builder: (context, postState) {
        final singlePost = postState.singlePostStatus;

        if (singlePost is SinglePostLoading) {
          Scaffold(
            backgroundColor: colorScheme.background,
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (singlePost is SinglePostCompleted) {
          final post = singlePost.post;
          return Scaffold(
            backgroundColor: colorScheme.background,
            appBar: AppBar(
              backgroundColor: colorScheme.background,
              elevation: 0,
              iconTheme: IconThemeData(
                color: colorScheme.onPrimary,
              ),
              title: Row(
                children: [
                  const SizedBox(width: Dimens.small),
                  //avatar
                  SizedBox(
                    width: size.width * 0.1,
                    height: size.width * 0.1,
                    child: CachedNetworkImage(
                      imageUrl: post.userProfileUrl! == ""
                          ? IMAGES.defaultProfile
                          : post.userProfileUrl!,
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
                  Text(
                    post.username!,
                    style: robotoMedium.copyWith(
                      fontSize: appFontSize.largeFontSize,
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(width: size.width / 3),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, userState) {
                      final profileStatus = userState.profileStatus;
                      if (profileStatus is ProfileLoading) {
                        return Container();
                      }

                      if (profileStatus is ProfileSuccess) {
                        final UserEntity profile = profileStatus.user;

                        if (profile.username == post.username) {
                          return PopupMenuButton(
                            color: colorScheme.background,
                            icon: Icon(
                              FontAwesomeIcons.ellipsisVertical,
                              color: colorScheme.onPrimary,
                            ),
                            onSelected: (value) {
                              if (value == "/edit") {
                                Navigator.of(context).pushNamed(
                                  RouteNames.editPostPage,
                                  arguments: post,
                                );
                              }
                              if (value == "/delete") {
                                _dialogBuilder(context);
                              }
                            },
                            itemBuilder: (BuildContext bc) {
                              return const [
                                PopupMenuItem(
                                  value: '/edit',
                                  child: Text("Edit"),
                                ),
                                PopupMenuItem(
                                  value: '/delete',
                                  child: Text("Delete"),
                                ),
                              ];
                            },
                          );
                        } else {
                          return Container();
                        }
                      }

                      if (profileStatus is ProfileFailed) {
                        return Container();
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              width: size.width,
                              height: size.width,
                              child: CachedNetworkImage(
                                imageUrl: widget.post.postImageUrl!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
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
                          ),

                          //likes comment and share

                          Positioned(
                            left: Dimens.medium,
                            right: Dimens.medium,
                            bottom: Dimens.medium,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(Dimens.xxLarge),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  width: size.width / 1.3,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color:
                                        colorScheme.background.withOpacity(0.5),
                                    borderRadius:
                                        BorderRadius.circular(Dimens.xxLarge),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          //likes
                                          LikeButton(
                                            post: post,
                                            colorScheme: colorScheme,
                                          ),
                                          //comment

                                          GestureDetector(
                                            onTap: () {},
                                            child: Row(
                                              children: [
                                                const Icon(
                                                    FontAwesomeIcons.comment),
                                                const SizedBox(
                                                    width: Dimens.small),
                                                Text("${post.totalComments}"),
                                              ],
                                            ),
                                          ),

                                          const SizedBox(width: Dimens.medium),
                                          //share
                                          GestureDetector(
                                            onTap: () {
                                              print("share post");
                                            },
                                            child: const Icon(
                                              FontAwesomeIcons.paperPlane,
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          print("added to the bookmark");
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Dimens.large,
                                          ),
                                          child: Icon(
                                            FontAwesomeIcons.bookmark,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //description
                      Padding(
                        padding: const EdgeInsets.all(Dimens.small),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: ReadMoreText(
                            post.description!,
                            trimLines: 2,
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            style: robotoMedium.copyWith(
                              fontSize: appFontSize.mediumFontSize,
                              height: size.height * 0.002,
                            ),
                            moreStyle: robotoBold.copyWith(
                              fontSize: appFontSize.mediumFontSize,
                            ),
                            lessStyle: robotoBold.copyWith(
                              fontSize: appFontSize.mediumFontSize,
                            ),
                          ),
                        ),
                      ),

                      // comments

                      BlocBuilder<CommentBloc, CommentState>(
                        builder: (context, commentState) {
                          final readCommentsStatus =
                              commentState.readCommentStatus;

                          if (readCommentsStatus is ReadCommentLoading) {
                            return SpinKitPulse(
                              color: colorScheme.primary,
                              size: 100,
                            );
                          }

                          if (readCommentsStatus is ReadCommentSuccess) {
                            final List<CommentEntity> comments =
                                readCommentsStatus.comments;

                            return ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                final CommentEntity comment = comments[index];

                                return BlocBuilder<UserBloc, UserState>(
                                  builder: (context, userState) {
                                    final userStatus = userState.profileStatus;

                                    if (userStatus is ProfileSuccess) {
                                      final uid = userStatus.user.uid;
                                      final UserEntity user = userStatus.user;

                                      return CommentItem(
                                        onLongPress: () {
                                          if (uid == comment.creatorUid) {
                                            _deleteDialogComment(
                                                context,
                                                CommentEntity(
                                                  commentId: comment.commentId,
                                                  postId: comment.postId,
                                                ));
                                          }
                                          return;
                                        },
                                        user: user,
                                        comment: comment,
                                        size: size,
                                        index: index,
                                        appFontSize: appFontSize,
                                        colorScheme: colorScheme,
                                        length: comments.length,
                                      );
                                    }
                                    return Container();
                                  },
                                );
                              },
                            );
                          }

                          if (readCommentsStatus is ReadCommentFailed) {
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
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    final user = userState.profileStatus;

                    if (user is ProfileSuccess) {
                      final profile = user.user;

                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 80,
                          color: colorScheme.background,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.large),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: size.width / 10,
                                  height: size.width / 10,
                                  child: CachedNetworkImage(
                                    imageUrl: profile.profileUrl! == ""
                                        ? IMAGES.defaultProfile
                                        : profile.profileUrl!,
                                    imageBuilder: (context, imageProvider) =>
                                        ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
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
                                SizedBox(
                                  width: size.width / 1.8,
                                  child: TextField(
                                    controller: commentController,
                                    style: robotoRegular,
                                    decoration: InputDecoration(
                                      hintText: "comment",
                                      hintStyle: robotoRegular,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (commentController.text == "") return;
                                    BlocProvider.of<CommentBloc>(context).add(
                                      CreateCommentEvent(
                                        comment: CommentEntity(
                                          totalReplays: 0,
                                          commentId: const Uuid().v1(),
                                          createAt: Timestamp.now(),
                                          likes: const [],
                                          username: profile.username,
                                          userProfileUrl: profile.profileUrl,
                                          description: commentController.text,
                                          creatorUid: profile.uid,
                                          postId: widget.post.postId,
                                        ),
                                      ),
                                    );

                                    commentController.clear();
                                  },
                                  child: Text(
                                    "Post",
                                    style: robotoMedium.copyWith(
                                      color: colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    return Container();
                  },
                )
              ],
            ),
          );
        }

        if (singlePost is SinglePostFailed) {
          return const Center(
            child: Text("something went wrong"),
          );
        }

        return Container();
      },
    );
  }
}
