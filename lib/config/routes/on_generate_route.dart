import 'package:flutter/material.dart';
import 'package:instagram_clone/common/params/post_details_params.dart';
import 'package:instagram_clone/common/widgets/main_wrapper.dart';
import 'package:instagram_clone/config/routes/route_names.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/pages/edit_post_page.dart';
import 'package:instagram_clone/features/user/presentation/pages/change_cover_image_page.dart';
import 'package:instagram_clone/features/user/presentation/pages/change_profile_image_page.dart';
import 'package:instagram_clone/features/user/presentation/pages/login_page.dart';
import 'package:instagram_clone/features/user/presentation/pages/register_page.dart';
import 'package:instagram_clone/features/post/presentation/pages/post_details_page.dart';
import 'package:instagram_clone/features/user/presentation/pages/edit_profile_page.dart';
import 'package:instagram_clone/features/user/presentation/pages/single_user_profile_page.dart';

class OnGenerateRoute {
  OnGenerateRoute._();
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RouteNames.loginPage:
        return routeBuilder(const LoginPage());

      case RouteNames.mainWrapper:
        return routeBuilder(const MainWrapper());

      case RouteNames.registerPage:
        return routeBuilder(const RegisterPage());

      case RouteNames.postDetailsPage:
        if (args is PostDetailsParams) {
          return routeBuilder(PostDetailsPage(
            postDetailsParams: PostDetailsParams(
                postEntity: args.postEntity,
                pageController: args.pageController),
          ));
        } else {
          return routeBuilder(const NoPageFound());
        }

      case RouteNames.editProfilePage:
        return routeBuilder(const EditProfilePage());

      case RouteNames.changeCoverProfilePage:
        if (args is String) {
          return routeBuilder(ChangeCoverImagePage(coverUrl: args));
        } else {
          return routeBuilder(const NoPageFound());
        }

      case RouteNames.editPostPage:
        if (args is PostEntity) {
          return routeBuilder(EditPostPage(post: args));
        } else {
          return routeBuilder(const NoPageFound());
        }

      case RouteNames.changeImageProfilePage:
        if (args is String) {
          return routeBuilder(ChangeProfileImagePage(profileUrl: args));
        } else {
          return routeBuilder(const NoPageFound());
        }

      case RouteNames.singleUserProfilePage:
        if (args is String) {
          return routeBuilder(SingleUserProfilePage(userUid: args));
        } else {
          return routeBuilder(const NoPageFound());
        }

      default:
        return routeBuilder(const NoPageFound());
    }
  }
}

MaterialPageRoute routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (_) => child);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: Text('screen not found!', style: robotoMedium),
      ),
      body: Center(
        child: Text(
          'screen not found!',
          style: robotoBold,
        ),
      ),
    );
  }
}
