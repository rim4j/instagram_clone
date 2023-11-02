import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/common/bloc/bottom_nav.dart';
import 'package:instagram_clone/common/widgets/bottom_nav.dart';
import 'package:instagram_clone/features/post/presentation/bloc/post_bloc.dart';
import 'package:instagram_clone/features/post/presentation/pages/create_post_page.dart';
import 'package:instagram_clone/features/user/presentation/pages/profile_page.dart';
import 'package:instagram_clone/features/bookmark/presentation/pages/bookmark_page.dart';
import 'package:instagram_clone/features/home/presentation/pages/home_page.dart';
import 'package:instagram_clone/features/home/presentation/pages/search_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  @override
  void initState() {
    BlocProvider.of<PostBloc>(context).add(GetPostsEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // Size size = MediaQuery.of(context).size;
    // AppFontSize appFontSize = AppFontSize(size: size);
    PageController pageController = PageController();

    List<Widget> pages = [
      HomePage(pageController: pageController),
      const BookmarkPage(),
      const CreatePostPage(),
      const SearchPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: pages,
            onPageChanged: (index) {
              BlocProvider.of<BottomNavCubit>(context)
                  .changeSelectedIndex(index);
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNav(controller: pageController),
          )
        ],
      ),
    );
  }
}
