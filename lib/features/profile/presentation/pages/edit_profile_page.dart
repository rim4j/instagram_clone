import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/widgets/custom_button.dart';
import 'package:instagram_clone/config/theme/app_colors.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final picker = ImagePicker();

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  File? selectedImageProfile;
  File? selectedImageCover;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    final safePadding = MediaQuery.of(context).padding.top;
    AppFontSize appFontSize = AppFontSize(size: size);

    Future pickProfileImage() async {
      final pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 20);

      if (pickedFile == null) return;

      setState(() {
        selectedImageProfile = File(pickedFile.path);
      });
    }

    Future pickCoverImage() async {
      final pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 20);

      if (pickedFile == null) return;

      setState(() {
        selectedImageCover = File(pickedFile.path);
      });
    }

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SingleChildScrollView(
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
                  child: selectedImageCover != null
                      ? Image.file(
                          selectedImageCover!.absolute,
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          imageUrl:
                              "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80",
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
                      pickCoverImage();
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
                      //select image profile
                      pickProfileImage();
                    },
                    child: Stack(
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
                          child: selectedImageProfile != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    selectedImageProfile!.absolute,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : CachedNetworkImage(
                                  imageUrl:
                                      "https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8YXZhdGFyfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
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
                              pickProfileImage();
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
              padding: const EdgeInsets.symmetric(horizontal: Dimens.large),
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
                    controller: usernameController,
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
                    controller: usernameController,
                    style: robotoRegular,
                    decoration: InputDecoration(
                      hintText: "bio",
                      hintStyle: robotoRegular,
                    ),
                  ),
                  const SizedBox(height: Dimens.large),
                  CustomButton(
                      title: "Edit", onTap: () {}, appFontSize: appFontSize)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
