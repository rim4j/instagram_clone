import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/config/routes/on_generate_route.dart';
import 'package:instagram_clone/config/theme/theme.dart';
import 'package:instagram_clone/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:instagram_clone/features/intro/presentation/pages/splash_page.dart';
import 'package:instagram_clone/locator.dart';

void main() {
  //init locator
  setup();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<IntroBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'instagram clone',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: "/",
      onGenerateRoute: OnGenerateRoute.route,
      routes: {"/": (context) => const SplashPage()},
    );
  }
}
