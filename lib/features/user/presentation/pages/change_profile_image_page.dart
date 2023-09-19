import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/widgets/custom_button.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/bloc/update_profile_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/user_bloc.dart';

class ChangeProfileImagePage extends StatefulWidget {
  final String profileUrl;
  const ChangeProfileImagePage({super.key, required this.profileUrl});

  @override
  State<ChangeProfileImagePage> createState() => _ChangeProfileImagePageState();
}

class _ChangeProfileImagePageState extends State<ChangeProfileImagePage> {
  final picker = ImagePicker();

  File? selectedImage;

  Future pickGalleryImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 20);

    if (pickedFile == null) return;

    setState(() {
      selectedImage = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;

    AppFontSize appFontSize = AppFontSize(size: size);
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimens.large),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                pickGalleryImage();
              },
              child: SizedBox(
                width: size.width,
                height: size.width,
                child: selectedImage == null
                    ? CachedNetworkImage(
                        imageUrl: widget.profileUrl,
                        imageBuilder: (context, imageProvider) => ClipRRect(
                          borderRadius: BorderRadius.circular(Dimens.large),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
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
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(Dimens.large),
                        child: Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                          height: size.width,
                          width: size.width,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: Dimens.large),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, userState) {
                return CustomButton(
                    title: "Update",
                    loading:
                        userState.updateProfileStatus is UpdateProfileLoading
                            ? true
                            : false,
                    onTap: () {
                      BlocProvider.of<UserBloc>(context).add(
                          UpdateProfileImageEvent(
                              user: UserEntity(imageFile: selectedImage)));
                    },
                    appFontSize: appFontSize);
              },
            )
          ],
        ),
      ),
    );
  }
}
