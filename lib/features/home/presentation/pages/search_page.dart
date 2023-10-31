import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/config/routes/route_names.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/bloc/post_bloc.dart';
import 'package:instagram_clone/features/post/presentation/bloc/status/posts_status.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    TextEditingController searchController = TextEditingController();
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
            BlocBuilder<PostBloc, PostState>(
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
                          repeatPattern: QuiltedGridRepeatPattern.inverted,
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
                                      Navigator.pushNamed(
                                          context, RouteNames.postDetailsPage,
                                          arguments: post);
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: post.postImageUrl!,
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
            ),
          ],
        ),
      ),
    );
  }
}
