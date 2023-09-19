import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/widgets/custom_button.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final picker = ImagePicker();

  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    AppFontSize appFontSize = AppFontSize(size: size);
    TextEditingController descriptionController = TextEditingController();

    Future pickGalleryImage() async {
      final pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 20);

      if (pickedFile == null) return;

      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }

    Future pickCameraImage() async {
      final pickedFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 20);

      if (pickedFile == null) return;

      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectedImage != null
                ? Padding(
                    padding: const EdgeInsets.all(Dimens.medium),
                    child: Column(
                      children: [
                        GestureDetector(
                          onLongPress: () {
                            setState(() {
                              selectedImage = null;
                            });
                          },
                          onTap: () {
                            _showModalBottomSheet(
                              context,
                              size,
                              colorScheme,
                              pickCameraImage,
                              pickGalleryImage,
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimens.large),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                              height: size.width,
                              width: size.width,
                            ),
                          ),
                        ),
                        const SizedBox(height: Dimens.large),
                        TextField(
                          controller: descriptionController,
                          style: robotoRegular,
                          decoration: InputDecoration(
                            hintText: "description",
                            hintStyle: robotoRegular,
                          ),
                        ),
                        const SizedBox(height: Dimens.large),
                        CustomButton(
                          title: "post",
                          appFontSize: appFontSize,
                          onTap: () {
                            print("create post");
                          },
                        )
                      ],
                    ),
                  )
                : Center(
                    child: GestureDetector(
                      onTap: () {
                        _showModalBottomSheet(
                          context,
                          size,
                          colorScheme,
                          pickCameraImage,
                          pickGalleryImage,
                        );
                      },
                      child: Container(
                        width: size.width / 2,
                        height: size.width / 2,
                        decoration: BoxDecoration(
                          color: colorScheme.onSecondaryContainer,
                          borderRadius: BorderRadius.circular(size.width / 2),
                        ),
                        child: Icon(
                          FontAwesomeIcons.upload,
                          size: 50,
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showModalBottomSheet(
    BuildContext context,
    Size size,
    ColorScheme colorScheme,
    pickCameraImage,
    pickGalleryImage,
  ) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: ((context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: size.height / 4,
            decoration: BoxDecoration(
              color: colorScheme.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimens.large - 2),
                topRight: Radius.circular(Dimens.large - 2),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: Dimens.small),
                Container(
                  width: Dimens.xLarge,
                  height: Dimens.small,
                  decoration: BoxDecoration(
                    color: colorScheme.onSecondaryContainer,
                    borderRadius: BorderRadius.circular(Dimens.xLarge),
                  ),
                ),
                const SizedBox(height: Dimens.large),
                GestureDetector(
                  onTap: () {
                    print("selected image from camera");
                    pickCameraImage();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: size.width,
                    height: 50,
                    color: colorScheme.background,
                    child: Padding(
                      padding: const EdgeInsets.all(Dimens.small),
                      child: Row(
                        children: [
                          const Icon(Icons.camera),
                          const SizedBox(width: Dimens.medium),
                          Text(
                            "Camera",
                            style: robotoMedium.copyWith(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: Dimens.medium),
                GestureDetector(
                  onTap: () {
                    pickGalleryImage();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: size.width,
                    height: 50,
                    color: colorScheme.background,
                    child: Padding(
                      padding: const EdgeInsets.all(Dimens.small),
                      child: Row(
                        children: [
                          const Icon(Icons.image),
                          const SizedBox(width: Dimens.medium),
                          Text(
                            "Gallery",
                            style: robotoMedium.copyWith(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
