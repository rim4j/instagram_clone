import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/common/bloc/bottom_nav.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/constants/images.dart';
import 'package:instagram_clone/config/routes/route_names.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/bloc/post_bloc.dart';
import 'package:instagram_clone/features/post/presentation/bloc/status/posts_status.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/auth_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/users_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/user_bloc.dart';

class SearchPage extends StatefulWidget {
  final PageController pageController;
  const SearchPage({super.key, required this.pageController});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(GetUsersEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    AppFontSize appFontSize = AppFontSize(size: size);

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.background,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimens.small),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.onSecondaryContainer,
                  borderRadius: BorderRadius.circular(Dimens.medium),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: robotoMedium.copyWith(
                      fontSize: appFontSize.mediumFontSize),
                  cursorColor: colorScheme.onPrimary,
                  decoration: InputDecoration(
                    hintText: "search",
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: Dimens.small),
            searchController.text.isEmpty
                ? BlocBuilder<PostBloc, PostState>(
                    builder: (context, postState) {
                      final postStatus = postState.postsStatus;
                      if (postStatus is PostsLoading) {
                        return const CircularProgressIndicator();
                      }

                      if (postStatus is PostsCompleted) {
                        final PostsCompleted postsCompleted =
                            postState.postsStatus as PostsCompleted;

                        final List<PostEntity> posts = postsCompleted.posts;

                        return Expanded(
                          child: AnimationLimiter(
                            child: GridView.custom(
                              gridDelegate: SliverQuiltedGridDelegate(
                                mainAxisSpacing: 7,
                                crossAxisSpacing: 7,
                                crossAxisCount: 3,
                                repeatPattern:
                                    QuiltedGridRepeatPattern.inverted,
                                pattern: [
                                  const QuiltedGridTile(2, 2),
                                  const QuiltedGridTile(1, 1),
                                  const QuiltedGridTile(1, 1),
                                  const QuiltedGridTile(1, 1),
                                  const QuiltedGridTile(1, 1),
                                  const QuiltedGridTile(1, 1),
                                ],
                              ),
                              childrenDelegate: SliverChildBuilderDelegate(
                                childCount: posts.length,
                                (context, index) {
                                  final post = posts[index];
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    columnCount: 3,
                                    duration: const Duration(seconds: 1),
                                    child: FadeInAnimation(
                                      child: ScaleAnimation(
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
                          ),
                        );
                      }

                      return Container();
                    },
                  )
                : BlocBuilder<UserBloc, UserState>(
                    builder: (context, userState) {
                      final UsersStatus usersStatus = userState.usersStatus;
                      final authUserUid = userState.authStatus as Authenticated;

                      if (usersStatus is UsersLoading) {
                        return SpinKitPulse(
                          color: colorScheme.primary,
                          size: 100,
                        );
                      }
                      if (usersStatus is UsersLoaded) {
                        final List<UserEntity> users = usersStatus.users;
                        final List<UserEntity> filterUsers = users
                            .where((user) =>
                                user.username!.startsWith(
                                    searchController.text.toLowerCase()) ||
                                user.username!
                                    .toLowerCase()
                                    .startsWith(searchController.text) ||
                                user.username!
                                    .contains(searchController.text) ||
                                user.username!.toLowerCase().contains(
                                    searchController.text.toLowerCase()))
                            .toList();

                        return Expanded(
                          child: ListView.builder(
                            itemCount: filterUsers.length,
                            itemBuilder: (context, index) {
                              final user = filterUsers[index];
                              return InkWell(
                                onTap: () {
                                  if (authUserUid.uid == user.uid) {
                                    BlocProvider.of<BottomNavCubit>(context)
                                        .changeSelectedIndex(4);
                                    widget.pageController.jumpToPage(4);
                                  } else {
                                    Navigator.pushNamed(context,
                                        RouteNames.singleUserProfilePage,
                                        arguments: user.uid);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(Dimens.small),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CachedNetworkImage(
                                          imageUrl: user.profileUrl! == ""
                                              ? IMAGES.defaultProfile
                                              : user.profileUrl!,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
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
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: Dimens.small,
                                      ),
                                      Text("${user.username}")
                                    ],
                                  ),
                                ),
                              );
                            },
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
}
