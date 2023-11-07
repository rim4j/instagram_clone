import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/constants/images.dart';
import 'package:instagram_clone/common/widgets/custom_button.dart';
import 'package:instagram_clone/config/routes/route_names.dart';
import 'package:instagram_clone/config/theme/app_colors.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/bloc/post_bloc.dart';
import 'package:instagram_clone/features/post/presentation/bloc/status/posts_status.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/auth_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/follow_unfollow_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/single_user_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/user_bloc.dart';

class SingleUserProfilePage extends StatefulWidget {
  final String userUid;
  const SingleUserProfilePage({
    super.key,
    required this.userUid,
  });

  @override
  State<SingleUserProfilePage> createState() => _SingleUserProfilePageState();
}

class _SingleUserProfilePageState extends State<SingleUserProfilePage> {
  bool isGrid = true;

  @override
  void initState() {
    BlocProvider.of<UserBloc>(context)
        .add(GetSingleUserProfileEvent(userUid: widget.userUid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    AppFontSize appFontSize = AppFontSize(size: size);
    final safePadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          final singleUserStatus = userState.singleUserStatus;

          if (singleUserStatus is SingleUserLoading) {
            return const CircularProgressIndicator();
          }

          if (singleUserStatus is SingleUserCompleted) {
            final UserEntity singleUser = singleUserStatus.singleUser;

            return Scaffold(
              backgroundColor: colorScheme.background,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        //cover picture
                        Container(
                          width: size.width,
                          height: size.height / 5,
                          foregroundDecoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: GradientColors.profileCover,
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: singleUser.coverUrl == ""
                                ? IMAGES.defaultCoverImage
                                : singleUser.coverUrl!,
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
                        //back icon
                        Positioned(
                          left: 10,
                          top: safePadding,
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                      width: size.width,
                      decoration: BoxDecoration(
                          color: colorScheme.background,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(Dimens.large),
                            topRight: Radius.circular(Dimens.large),
                          )),
                      child: Column(
                        children: [
                          //profile picture
                          Container(
                            transform:
                                Matrix4.translationValues(0.0, -50.0, 0.0),
                            width: size.width / 4,
                            height: size.width / 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  width: 5, color: colorScheme.background),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: singleUser.profileUrl! == ""
                                  ? IMAGES.defaultProfile
                                  : singleUser.profileUrl!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
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
                          Container(
                            transform:
                                Matrix4.translationValues(0.0, -40.0, 0.0),
                            child: Column(
                              children: [
                                Text(
                                  singleUser.username!,
                                  style: robotoBold.copyWith(fontSize: 20),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  singleUser.bio!,
                                  style: robotoRegular.copyWith(
                                      fontSize: 18,
                                      color: colorScheme.onPrimary),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.large),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: size.width / 5,
                                  child: Column(
                                    children: [
                                      Text(
                                        "${singleUser.followers!.length}",
                                        style: robotoBold.copyWith(
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(height: Dimens.small),
                                      Text(
                                        "Followers",
                                        style: robotoRegular.copyWith(
                                          fontSize: 18,
                                          color: colorScheme.onPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: size.width / 5,
                                  child: Column(
                                    children: [
                                      Text(
                                        "${singleUser.following!.length}",
                                        style: robotoBold.copyWith(
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(height: Dimens.small),
                                      Text(
                                        "Following",
                                        style: robotoRegular.copyWith(
                                          fontSize: 18,
                                          color: colorScheme.onPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: size.width / 5,
                                  child: Column(
                                    children: [
                                      Text(
                                        "${singleUser.totalPosts}",
                                        style: robotoBold.copyWith(
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(height: Dimens.small),
                                      Text(
                                        "Posts",
                                        style: robotoRegular.copyWith(
                                          fontSize: 18,
                                          color: colorScheme.onPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //follow
                          Padding(
                            padding: const EdgeInsets.all(Dimens.large),
                            child: BlocBuilder<UserBloc, UserState>(
                              builder: (context, userState) {
                                final currentUid =
                                    userState.authStatus as Authenticated;
                                final followUnFollowStatus =
                                    userState.followUnFollowStatus;

                                if (followUnFollowStatus
                                    is FollowUnFollowLoading) {
                                  return CustomButton(
                                    title: "Follow",
                                    loading: true,
                                    onTap: () {},
                                    appFontSize: appFontSize,
                                  );
                                }

                                return CustomButton(
                                  title: singleUser.followers!
                                          .contains(currentUid.uid)
                                      ? "UnFollow"
                                      : "Follow",
                                  onTap: () {
                                    BlocProvider.of<UserBloc>(context).add(
                                      GetFollowUnFollowEvent(
                                        user: UserEntity(
                                          uid: currentUid.uid,
                                          otherUid: singleUser.uid,
                                        ),
                                      ),
                                    );
                                  },
                                  appFontSize: appFontSize,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 50,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isGrid = true;
                              });
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.grid_view,
                                  color: isGrid == true
                                      ? colorScheme.secondary
                                      : colorScheme.onPrimary,
                                  size: 30,
                                ),
                                const SizedBox(height: 5),
                                isGrid
                                    ? Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: colorScheme.secondary,
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isGrid = false;
                              });
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.list,
                                  color: isGrid == false
                                      ? colorScheme.secondary
                                      : colorScheme.onPrimary,
                                  size: 30,
                                ),
                                const SizedBox(height: 5),
                                isGrid == false
                                    ? Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: colorScheme.secondary,
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<PostBloc, PostState>(
                      builder: (context, postState) {
                        final PostsStatus postsStatus = postState.postsStatus;
                        if (postsStatus is PostsLoading) {
                          return SpinKitPulse(
                            color: colorScheme.primary,
                            size: 100,
                          );
                        }
                        if (postsStatus is PostsCompleted) {
                          final PostsCompleted postsCompleted =
                              postState.postsStatus as PostsCompleted;

                          final List<PostEntity> userPosts = postsCompleted
                              .posts
                              .where((element) =>
                                  element.creatorUid == widget.userUid)
                              .toList();

                          if (userPosts.isEmpty) {
                            return Center(
                              child: Text(
                                "No posts!",
                                style: robotoMedium,
                              ),
                            );
                          }

                          return AnimationLimiter(
                            child: GridView.custom(
                              primary: false,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverQuiltedGridDelegate(
                                mainAxisSpacing: 7,
                                crossAxisSpacing: 7,
                                crossAxisCount: isGrid ? 3 : 1,
                                pattern: isGrid == true
                                    ? [
                                        const QuiltedGridTile(1, 1),
                                        const QuiltedGridTile(1, 1),
                                        const QuiltedGridTile(1, 1),
                                      ]
                                    : [
                                        const QuiltedGridTile(1, 1),
                                      ],
                              ),
                              childrenDelegate: SliverChildBuilderDelegate(
                                childCount: userPosts.length,
                                (context, index) {
                                  final post = userPosts[index];

                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    columnCount: 3,
                                    duration: const Duration(seconds: 1),
                                    child: FadeInAnimation(
                                      child: ScaleAnimation(
                                        //check last index list for padding from bottom
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                RouteNames.postDetailsPage,
                                                arguments: post);
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl: post.postImageUrl!,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                SizedBox(
                                              width: size.width / 3,
                                              height: size.width / 3,
                                              child: SpinKitPulse(
                                                color: colorScheme.primary,
                                                size: 100,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }

                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          if (singleUserStatus is SingleUserFailed) {
            return const Text("some error");
          }
          return Container();
        },
      ),
    );
  }
}
