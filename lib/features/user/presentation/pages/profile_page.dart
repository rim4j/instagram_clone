import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/common/bloc/bottom_nav.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/constants/images.dart';
import 'package:instagram_clone/config/routes/route_names.dart';
import 'package:instagram_clone/config/theme/app_colors.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/intro/presentation/bloc/change_theme_status.dart';
import 'package:instagram_clone/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/usecases/get_current_uid_usecase.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/profile_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/user_bloc.dart';
import 'package:instagram_clone/locator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  bool isGrid = true;

  @override
  void initState() {
    final uid = locator<GetCurrentUidUseCase>().call();

    uid.then((uid) {
      BlocProvider.of<UserBloc>(context).add(GetProfileEvent(uid: uid));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    final safePadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: colorScheme.background,
      key: _key,
      drawer: Drawer(
        backgroundColor: colorScheme.background,
        child: ListView(
          children: [
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  "Edit profile",
                  style: robotoMedium.copyWith(
                    fontSize: 18,
                  ),
                ),
              ),
              onTap: () {
                _key.currentState!.closeDrawer();
                Navigator.pushNamed(context, RouteNames.editProfilePage);
              },
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  "Github code",
                  style: robotoMedium.copyWith(
                    fontSize: 18,
                  ),
                ),
              ),
              onTap: () {
                _key.currentState!.closeDrawer();
              },
            ),
            BlocBuilder<IntroBloc, IntroState>(
              builder: (context, introState) {
                DarkMode darkMode = introState.changeThemeStatus as DarkMode;

                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          darkMode.isDarkMode ? "Dark" : "Light",
                          style: robotoMedium.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        Icon(darkMode.isDarkMode
                            ? Icons.dark_mode
                            : Icons.light_mode)
                      ],
                    ),
                  ),
                  onTap: () {
                    BlocProvider.of<IntroBloc>(context).add(IsDarkModeEvent());
                    // _key.currentState!.closeDrawer();
                  },
                );
              },
            ),
            SizedBox(height: size.height / 1.8),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  "Logout",
                  style: robotoMedium.copyWith(
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
              ),
              onTap: () {
                _key.currentState!.closeDrawer();
                BlocProvider.of<UserBloc>(context).add(LoggedOutEvent());
                BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(0);

                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.loginPage, (route) => false);
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          final ProfileStatus profileStatus = userState.profileStatus;

          if (profileStatus is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (profileStatus is ProfileSuccess) {
            final UserEntity profile = profileStatus.user;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height / 5,
                        foregroundDecoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: GradientColors.profileCover,
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: profile.coverUrl == ""
                              ? IMAGES.defaultCoverImage
                              : profile.coverUrl!,
                          imageBuilder: (context, imageProvider) => Container(
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
                      //drawer icon
                      Positioned(
                        right: 10,
                        top: safePadding,
                        child: IconButton(
                          onPressed: () => _key.currentState!.openDrawer(),
                          icon: Icon(
                            Icons.menu,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                    width: size.width,
                    decoration: BoxDecoration(
                        color: colorScheme.background,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(Dimens.large),
                          topRight: Radius.circular(Dimens.large),
                        )),
                    child: Column(
                      children: [
                        Container(
                          transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                          width: size.width / 4,
                          height: size.width / 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                width: 5, color: colorScheme.background),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: profile.profileUrl! == ""
                                ? "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"
                                : profile.profileUrl!,
                            // "https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8YXZhdGFyfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
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
                        Container(
                          transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                          child: Column(
                            children: [
                              Text(
                                profile.username!,
                                style: robotoBold.copyWith(fontSize: 20),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                profile.bio!,
                                style: robotoRegular.copyWith(
                                    fontSize: 18, color: colorScheme.onPrimary),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.large),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: size.width / 5,
                                child: Column(
                                  children: [
                                    Text(
                                      "${profile.followers!.length}",
                                      style: robotoBold.copyWith(
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: Dimens.small),
                                    Text(
                                      "Followers",
                                      style: robotoRegular.copyWith(
                                        fontSize: 18,
                                        color: colorScheme.onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width / 5,
                                child: Column(
                                  children: [
                                    Text(
                                      "${profile.following!.length}",
                                      style: robotoBold.copyWith(
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: Dimens.small),
                                    Text(
                                      "Following",
                                      style: robotoRegular.copyWith(
                                        fontSize: 18,
                                        color: colorScheme.onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width / 5,
                                child: Column(
                                  children: [
                                    Text(
                                      "${profile.totalPosts}",
                                      style: robotoBold.copyWith(
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: Dimens.small),
                                    Text(
                                      "Posts",
                                      style: robotoRegular.copyWith(
                                        fontSize: 18,
                                        color: colorScheme.onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 50,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isGrid = true;
                            });
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.grid_view,
                                color: isGrid == true
                                    ? colorScheme.secondary
                                    : colorScheme.onPrimary,
                                size: 30,
                              ),
                              const SizedBox(height: 5),
                              isGrid
                                  ? Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colorScheme.secondary,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isGrid = false;
                            });
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.list,
                                color: isGrid == false
                                    ? colorScheme.secondary
                                    : colorScheme.onPrimary,
                                size: 30,
                              ),
                              const SizedBox(height: 5),
                              isGrid == false
                                  ? Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colorScheme.secondary,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  AnimationLimiter(
                    child: GridView.custom(
                      primary: false,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverQuiltedGridDelegate(
                        mainAxisSpacing: 7,
                        crossAxisSpacing: 7,
                        crossAxisCount: isGrid ? 3 : 1,
                        pattern: isGrid == true
                            ? [
                                const QuiltedGridTile(1, 1),
                                const QuiltedGridTile(1, 1),
                                const QuiltedGridTile(1, 1),
                              ]
                            : [
                                const QuiltedGridTile(1, 1),
                              ],
                      ),
                      childrenDelegate: SliverChildBuilderDelegate(
                        childCount: 20,
                        (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            columnCount: 3,
                            duration: const Duration(seconds: 1),
                            child: FadeInAnimation(
                              child: ScaleAnimation(
                                //check last index list for padding from bottom
                                child: Container(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (profileStatus is ProfileFailed) {
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
