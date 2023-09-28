import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/common/constants/animations.dart';
import 'package:instagram_clone/common/widgets/custom_button.dart';
import 'package:instagram_clone/config/routes/route_names.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/intro/presentation/bloc/check_connection_status.dart';
import 'package:instagram_clone/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/auth_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/user_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    BlocProvider.of<IntroBloc>(context).add(CheckConnectionEvent());
    BlocProvider.of<IntroBloc>(context).add(InitIsDarkModeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    AppFontSize appFontSize = AppFontSize(size: size);

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: Lottie.asset(AnimationsConst.instagram)),
          //do something for authenticated
          BlocListener<UserBloc, UserState>(
            listener: (context, userState) {
              if (userState.authStatus is Authenticated) {
                Future.delayed(const Duration(seconds: 4)).then((value) {
                  Navigator.pushReplacementNamed(
                      context, RouteNames.mainWrapper);
                });
              }
              if (userState.authStatus is Unauthenticated) {
                Future.delayed(const Duration(seconds: 4)).then((value) {
                  Navigator.pushReplacementNamed(context, RouteNames.loginPage);
                });
              }
            },
            child: BlocConsumer<IntroBloc, IntroState>(
              listener: (context, introState) {
                //do something for authenticated
                if (introState.checkConnectionStatus is CheckConnectionOn) {
                  BlocProvider.of<UserBloc>(context).add(AppStartedEvent());
                }
              },
              builder: (context, introState) {
                if (introState.checkConnectionStatus is CheckConnectionOff) {
                  CheckConnectionOff checkConnectionOff =
                      introState.checkConnectionStatus as CheckConnectionOff;

                  return Padding(
                    padding: const EdgeInsets.all(30),
                    child: CustomButton(
                      appFontSize: appFontSize,
                      title: checkConnectionOff.message,
                      onTap: () {
                        BlocProvider.of<IntroBloc>(context)
                            .add(CheckConnectionEvent());
                      },
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }
}
