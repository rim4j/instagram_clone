import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/utils/custom_snackbar.dart';
import 'package:instagram_clone/common/widgets/custom_button.dart';
import 'package:instagram_clone/config/routes/route_names.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/bloc/post_bloc.dart';
import 'package:instagram_clone/features/storage/domain/usecase/upload_post_image_usecase.dart';
import 'package:instagram_clone/locator.dart';

class EditPostPage extends StatefulWidget {
  final PostEntity post;
  const EditPostPage({
    super.key,
    required this.post,
  });

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final picker = ImagePicker();
  TextEditingController descriptionController = TextEditingController();
  File? selectedImage;
  bool _uploading = false;
  @override
  void initState() {
    descriptionController.text = widget.post.description!;
    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

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

  _updateSubmitPost({required String image}) {
    BlocProvider.of<PostBloc>(context).add(
      UpdatePostEvent(
        post: PostEntity(
          description: descriptionController.text,
          postId: widget.post.postId,
          postImageUrl: image,
        ),
      ),
    );
    setState(() {
      _uploading = false;
    });
    Navigator.pushNamedAndRemoveUntil(
        context, RouteNames.mainWrapper, (route) => false);

    CustomSnackBars.showSnackSuccess(
        context, "post has been updated successfully");
  }

  Future _submitPost() async {
    setState(() {
      _uploading = true;
    });
    if (selectedImage == null) {
      BlocProvider.of<PostBloc>(context).add(
        UpdatePostEvent(
          post: PostEntity(
            description: descriptionController.text,
            postId: widget.post.postId,
          ),
        ),
      );
      setState(() {
        _uploading = false;
      });
      Navigator.pushNamedAndRemoveUntil(
          context, RouteNames.mainWrapper, (route) => false);

      CustomSnackBars.showSnackSuccess(
          context, "post has been updated successfully");
    } else {
      locator<UploadPostImageUseCase>()
          .call(params: selectedImage)
          .then((value) {
        _updateSubmitPost(image: value);
      });
    }
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSecondary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            const SizedBox(width: Dimens.small),
            //avatar
            Text(
              "Edit post",
              style: robotoMedium.copyWith(
                fontSize: 18,
                color: colorScheme.onSecondary,
              ),
            ),

            const SizedBox(width: Dimens.small),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
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
                      child: selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(Dimens.large),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                                height: size.width,
                                width: size.width,
                              ),
                            )
                          : SizedBox(
                              height: size.width,
                              width: size.width,
                              child: CachedNetworkImage(
                                imageUrl: widget.post.postImageUrl!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
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
                      title: "Edit",
                      appFontSize: appFontSize,
                      loading: _uploading,
                      onTap: () {
                        _submitPost();
                        // Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
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
