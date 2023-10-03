import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/constants/images.dart';
import 'package:instagram_clone/config/routes/route_names.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/bloc/post_bloc.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/usecases/get_current_uid_usecase.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/profile_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/user_bloc.dart';
import 'package:instagram_clone/locator.dart';
import 'package:readmore/readmore.dart';

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
  @override
  void initState() {
    final uid = locator<GetCurrentUidUseCase>().call();

    uid.then((uid) {
      BlocProvider.of<UserBloc>(context).add(GetProfileEvent(uid: uid));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    AppFontSize appFontSize = AppFontSize(size: size);
    TextEditingController commentController = TextEditingController();
    bool isReply = false;

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

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        title: Row(
          children: [
            const SizedBox(width: Dimens.small),
            //avatar
            SizedBox(
              width: size.width * 0.1,
              height: size.width * 0.1,
              child: CachedNetworkImage(
                imageUrl: widget.post.userProfileUrl! == ""
                    ? IMAGES.defaultProfile
                    : widget.post.userProfileUrl!,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
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
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(width: Dimens.small),
            //name profile
            Text(
              widget.post.username!,
              style: robotoMedium.copyWith(
                fontSize: appFontSize.largeFontSize,
                color: colorScheme.onSecondary,
              ),
            ),
            SizedBox(width: size.width / 2.5),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, userState) {
                final profileStatus = userState.profileStatus;
                if (profileStatus is ProfileLoading) {
                  return Container();
                }

                if (profileStatus is ProfileSuccess) {
                  final UserEntity profile = profileStatus.user;

                  if (profile.username == widget.post.username) {
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
                            arguments: widget.post,
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
                          imageBuilder: (context, imageProvider) => Container(
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
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            width: size.width / 1.3,
                            height: 70,
                            decoration: BoxDecoration(
                              color: colorScheme.background.withOpacity(0.5),
                              borderRadius:
                                  BorderRadius.circular(Dimens.xxLarge),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    //likes

                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: colorScheme.background,
                                          borderRadius: BorderRadius.circular(
                                              Dimens.large),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            print("like");
                                          },
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                  width: Dimens.medium),
                                              const Icon(
                                                  FontAwesomeIcons.heart),
                                              const SizedBox(
                                                  width: Dimens.small),
                                              Text(
                                                  "${widget.post.likes!.length}"),
                                              const SizedBox(
                                                  width: Dimens.medium),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    //comment

                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        children: [
                                          const Icon(FontAwesomeIcons.comment),
                                          const SizedBox(width: Dimens.small),
                                          Text("${widget.post.totalComments}"),
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
                      widget.post.description!,
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

                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        Dimens.medium,
                        Dimens.medium,
                        Dimens.medium,
                        //check for last index on comment list
                        //commentList.length-1
                        index == 9 ? size.height / 10 : Dimens.small,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: Dimens.small),
                              //avatar
                              Container(
                                width: size.width * 0.1,
                                height: size.width * 0.1,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: Dimens.small),
                              //name profile
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "david morel",
                                    style: robotoMedium.copyWith(
                                      fontSize: appFontSize.mediumFontSize,
                                      color: colorScheme.onSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "this is comment",
                                    style: robotoMedium.copyWith(
                                      fontSize: appFontSize.smallFontSize,
                                      color: colorScheme.onSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "31/jul/2022",
                                        style: robotoMedium.copyWith(
                                          fontSize:
                                              appFontSize.verySmallFontSize,
                                          color: colorScheme.onSecondary,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isReply = !isReply;
                                          });
                                        },
                                        child: Text(
                                          "Replay",
                                          style: robotoMedium.copyWith(
                                            fontSize:
                                                appFontSize.verySmallFontSize,
                                            color: colorScheme.onSecondary,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "View Replays",
                                        style: robotoMedium.copyWith(
                                          fontSize:
                                              appFontSize.verySmallFontSize,
                                          color: colorScheme.onSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Dimens.small),
                            child: Icon(FontAwesomeIcons.heart),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              color: colorScheme.background,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.large),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.1,
                      height: size.width * 0.1,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
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
                    const Text("Post"),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
