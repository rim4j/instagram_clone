import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/constants/images.dart';
import 'package:instagram_clone/config/routes/route_names.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/home/presentation/widgets/post_item.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/bloc/post_bloc.dart';
import 'package:instagram_clone/features/post/presentation/bloc/status/posts_status.dart';

class HomePage extends StatelessWidget {
  final PageController pageController;
  const HomePage({
    super.key,
    required this.pageController,
  });

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

            if (posts.isEmpty) {
              return Center(
                child: Text(
                  "no posts!",
                  style: robotoMedium.copyWith(
                    color: colorScheme.onPrimary,
                    fontSize: appFontSize.largeFontSize,
                  ),
                ),
              );
            }

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
