import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/common/bloc/bottom_nav.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/constants/images.dart';
import 'package:instagram_clone/common/widgets/bottom_nav.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/auth/presentation/pages/account_page.dart';
import 'package:instagram_clone/features/home/presentation/pages/home_page.dart';
import 'package:instagram_clone/features/home/presentation/pages/search_page.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    AppFontSize appFontSize = AppFontSize(size: size);
    PageController pageController = PageController();

    List<Widget> pages = [
      const HomePage(),
      Container(
        color: Colors.blue,
        child: const Center(
          child: Text("bookmark"),
        ),
      ),
      Container(
        color: Colors.red,
        child: const Center(
          child: Text("create post"),
        ),
      ),
      const SearchPage(),
      const AccountPage(),
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
