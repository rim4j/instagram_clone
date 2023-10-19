import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/common/bloc/bottom_nav.dart';
import 'package:instagram_clone/config/routes/on_generate_route.dart';
import 'package:instagram_clone/config/theme/theme.dart';
import 'package:instagram_clone/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:instagram_clone/features/intro/presentation/bloc/change_theme_status.dart';
import 'package:instagram_clone/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:instagram_clone/features/intro/presentation/pages/splash_page.dart';
import 'package:instagram_clone/features/post/presentation/bloc/post_bloc.dart';
import 'package:instagram_clone/features/replay/presentation/bloc/replay_bloc.dart';
import 'package:instagram_clone/features/user/presentation/bloc/user_bloc.dart';
import 'package:instagram_clone/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //init locator
  setup();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<IntroBloc>()),
        BlocProvider(create: (_) => locator<UserBloc>()),
        BlocProvider(create: (_) => locator<PostBloc>()),
        BlocProvider(create: (_) => locator<CommentBloc>()),
        BlocProvider(create: (_) => locator<ReplayBloc>()),
        BlocProvider(create: (_) => BottomNavCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntroBloc, IntroState>(
      builder: (context, introState) {
        DarkMode darkMode = introState.changeThemeStatus as DarkMode;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'instagram clone',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: darkMode.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: "/",
          onGenerateRoute: OnGenerateRoute.route,
          routes: {"/": (context) => const SplashPage()},
        );
      },
    );
  }
}
