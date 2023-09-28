import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/widgets/custom_button.dart';
import 'package:instagram_clone/config/routes/route_names.dart';
import 'package:instagram_clone/config/theme/app_colors.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/profile_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/update_profile_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/user_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    websiteController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    final safePadding = MediaQuery.of(context).padding.top;
    AppFontSize appFontSize = AppFontSize(size: size);

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SingleChildScrollView(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            ProfileStatus profileStatus = userState.profileStatus;

            if (profileStatus is ProfileSuccess) {
              ProfileSuccess profileSuccess = profileStatus;
              final UserEntity profile = profileStatus.user;

              nameController.text = profile.name!;
              usernameController.text = profile.username!;
              websiteController.text = profile.website!;
              bioController.text = profile.bio!;

              return Column(
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
                              ? "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"
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
                      //select cover image icon
                      Positioned(
                        right: 10,
                        top: safePadding,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: colorScheme.onPrimary,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteNames.changeCoverProfilePage,
                                arguments: profile.coverUrl);
                          },
                        ),
                      ),
                      //select cover image icon
                      Positioned(
                        left: 10,
                        top: safePadding,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: colorScheme.onPrimary,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.changeImageProfilePage,
                                arguments: profile.profileUrl);
                          },
                          child: Stack(
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -50.0, 0.0),
                                width: size.width / 4,
                                height: size.width / 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 5, color: colorScheme.background),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: profileSuccess.user.profileUrl! ==
                                          ""
                                      ? "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"
                                      : profileSuccess.user.profileUrl!,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
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
                              //select image profile
                              Positioned(
                                right: 0,
                                top: 8,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: colorScheme.onPrimary,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context,
                                        RouteNames.changeImageProfilePage,
                                        arguments: profile.profileUrl);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //edit profile fields
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Dimens.large),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "name",
                            style: robotoRegular.copyWith(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: Dimens.small),
                        TextField(
                          controller: nameController,
                          style: robotoRegular,
                          decoration: InputDecoration(
                            hintText: "name",
                            hintStyle: robotoRegular,
                          ),
                        ),
                        const SizedBox(height: Dimens.large),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "username",
                            style: robotoRegular.copyWith(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: Dimens.small),
                        TextField(
                          controller: usernameController,
                          style: robotoRegular,
                          decoration: InputDecoration(
                            hintText: "username",
                            hintStyle: robotoRegular,
                          ),
                        ),
                        const SizedBox(height: Dimens.large),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "website",
                            style: robotoRegular.copyWith(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: Dimens.small),
                        TextField(
                          controller: websiteController,
                          style: robotoRegular,
                          decoration: InputDecoration(
                            hintText: "website",
                            hintStyle: robotoRegular,
                          ),
                        ),
                        const SizedBox(height: Dimens.large),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "bio",
                            style: robotoRegular.copyWith(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: Dimens.small),
                        TextField(
                          controller: bioController,
                          style: robotoRegular,
                          decoration: InputDecoration(
                            hintText: "bio",
                            hintStyle: robotoRegular,
                          ),
                        ),
                        const SizedBox(height: Dimens.large),
                        //submit edit profile
                        BlocBuilder<UserBloc, UserState>(
                          builder: (context, userState) {
                            UpdateProfileStatus updateProfileStatus =
                                userState.updateProfileStatus;

                            return CustomButton(
                              title: "Edit",
                              loading:
                                  updateProfileStatus is UpdateProfileLoading
                                      ? true
                                      : false,
                              onTap: () {
                                BlocProvider.of<UserBloc>(context)
                                    .add(UpdateProfileEvent(
                                  user: UserEntity(
                                    name: nameController.text,
                                    username: usernameController.text,
                                    website: websiteController.text,
                                    bio: bioController.text,
                                  ),
                                ));
                              },
                              appFontSize: appFontSize,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            if (profileStatus is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (profileStatus is ProfileFailed) {
              return const Center(
                child: Text("something went wrong"),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
