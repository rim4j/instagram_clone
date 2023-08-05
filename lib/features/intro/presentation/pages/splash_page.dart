import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/common/constants/animations.dart';
import 'package:instagram_clone/common/widgets/custom_button.dart';
import 'package:instagram_clone/features/intro/presentation/bloc/check_connection_status.dart';
import 'package:instagram_clone/features/intro/presentation/bloc/intro_bloc.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: Lottie.asset(AnimationsConst.instagram)),
          BlocConsumer<IntroBloc, IntroState>(
            listener: (context, introState) {
              //do something for authenticated
            },
            builder: (context, introState) {
              if (introState.checkConnectionStatus is CheckConnectionOff) {
                CheckConnectionOff checkConnectionOff =
                    introState.checkConnectionStatus as CheckConnectionOff;
                return Padding(
                  padding: const EdgeInsets.all(30),
                  child: CustomButton(
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
          )
        ],
      ),
    );
  }
}
