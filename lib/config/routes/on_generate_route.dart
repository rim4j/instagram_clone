import 'package:flutter/material.dart';
import 'package:instagram_clone/common/widgets/main_wrapper.dart';
import 'package:instagram_clone/config/routes/route_names.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/auth/presentation/pages/login_page.dart';
import 'package:instagram_clone/features/auth/presentation/pages/register_page.dart';
import 'package:instagram_clone/features/home/presentation/pages/post_details_page.dart';

class OnGenerateRoute {
  OnGenerateRoute._();
  static Route<dynamic> route(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case RouteNames.loginPage:
        return routeBuilder(const LoginPage());

      case RouteNames.mainWrapper:
        return routeBuilder(const MainWrapper());

      case RouteNames.registerPage:
        return routeBuilder(const RegisterPage());
      case RouteNames.postDetailsPage:
        return routeBuilder(const PostDetailsPage());

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
