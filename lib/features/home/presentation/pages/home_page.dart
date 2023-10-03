import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/constants/images.dart';
import 'package:instagram_clone/config/routes/route_names.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/bloc/post_bloc.dart';
import 'package:instagram_clone/features/post/presentation/bloc/status/posts_status.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    AppFontSize appFontSize = AppFontSize(size: size);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  IMAGES.logoInstagram,
                  width: size.width / 14,
                ),
                const SizedBox(width: Dimens.small),
                Text(
                  "Instagram",
                  style: robotoMedium.copyWith(
                    fontSize: appFontSize.veryLargeFontSize,
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.paperPlane,
                color: colorScheme.onSecondary,
              ),
            )
          ],
        ),
      ),
      backgroundColor: colorScheme.background,
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, postState) {
          final postStatus = postState.postsStatus;

          if (postStatus is PostsLoading) {
            return const Center(
              child: SpinKitRipple(
                color: Colors.white,
                size: 100,
              ),
            );
          }
          if (postStatus is PostsCompleted) {
            final List<PostEntity> posts = postStatus.posts;

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final PostEntity post = posts[index];
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    0,
                    0,
                    posts.length - 1 == index ? size.height / 10 : 0,
                  ),
                  child: PostItem(
                    post: post,
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.postDetailsPage,
                      arguments: post,
                    ),
                    size: size,
                    appFontSize: appFontSize,
                    colorScheme: colorScheme,
                  ),
                );
              },
            );
          }
          if (postStatus is PostsFailed) {
            return const Center(
              child: Text("something went wrong"),
            );
          }

          return Container();
        },
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.size,
    required this.appFontSize,
    required this.colorScheme,
    required this.onTap,
    required this.post,
  });

  final Size size;
  final AppFontSize appFontSize;
  final ColorScheme colorScheme;
  final VoidCallback onTap;
  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: Dimens.small),
                //avatar
                SizedBox(
                  width: 50,
                  height: 50,
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
                    fontSize: appFontSize.mediumFontSize,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: Dimens.medium),
        //picture post

        Stack(
          children: [
            GestureDetector(
              onTap: onTap,
              child: SizedBox(
                width: size.width,
                height: size.width,
                child: CachedNetworkImage(
                  imageUrl: post.postImageUrl!,
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                      borderRadius: BorderRadius.circular(Dimens.xxLarge),
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
                                  borderRadius:
                                      BorderRadius.circular(Dimens.large),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    print("like");
                                  },
                                  child: Row(
                                    children: [
                                      const SizedBox(width: Dimens.medium),
                                      const Icon(FontAwesomeIcons.heart),
                                      const SizedBox(width: Dimens.small),
                                      Text("${post.likes!.length}"),
                                      const SizedBox(width: Dimens.medium),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //comment

                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteNames.postDetailsPage);
                              },
                              child: Row(
                                children: [
                                  const Icon(FontAwesomeIcons.comment),
                                  const SizedBox(width: Dimens.small),
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

        const SizedBox(height: Dimens.medium),
      ],
    );
  }
}
