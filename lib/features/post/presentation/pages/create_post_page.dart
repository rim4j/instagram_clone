import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/widgets/custom_button.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/post/presentation/bloc/post_bloc.dart';
import 'package:instagram_clone/features/storage/domain/usecase/upload_post_image_usecase.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/usecases/get_current_uid_usecase.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/profile_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/user_bloc.dart';
import 'package:instagram_clone/locator.dart';
import 'package:uuid/uuid.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final picker = ImagePicker();
  TextEditingController descriptionController = TextEditingController();
  bool _uploading = false;
  @override
  void initState() {
    final uid = locator<GetCurrentUidUseCase>().call();

    uid.then((uid) {
      BlocProvider.of<UserBloc>(context).add(GetProfileEvent(uid: uid));
    });

    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    AppFontSize appFontSize = AppFontSize(size: size);
    final PageController handlePage = locator<PageController>();

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

    _createSubmitPost({required String image, required UserEntity user}) {
      BlocProvider.of<PostBloc>(context).add(CreatePostEvent(
          post: PostEntity(
        description: descriptionController.text,
        createAt: Timestamp.now(),
        creatorUid: user.uid,
        likes: const [],
        postId: const Uuid().v1(),
        postImageUrl: image,
        totalComments: 0,
        totalLikes: 0,
        userProfileUrl: user.profileUrl,
        username: user.username,
      )));
      setState(() {
        _uploading = false;
        selectedImage = null;
        descriptionController.clear();
      });
      handlePage.jumpToPage(0);
    }

    Future _submitPost({required UserEntity user}) async {
      setState(() {
        _uploading = true;
      });
      locator<UploadPostImageUseCase>()
          .call(params: selectedImage)
          .then((value) {
        _createSubmitPost(image: value, user: user);
      });
    }

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                                borderRadius:
                                    BorderRadius.circular(Dimens.large),
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
                            BlocBuilder<UserBloc, UserState>(
                              builder: (context, userState) {
                                final ProfileStatus profileStatus =
                                    userState.profileStatus;

                                if (profileStatus is ProfileSuccess) {
                                  final UserEntity profile = profileStatus.user;

                                  return Column(
                                    children: [
                                      CustomButton(
                                        title: "post",
                                        appFontSize: appFontSize,
                                        loading: _uploading,
                                        onTap: () {
                                          _submitPost(user: profile);
                                        },
                                      ),
                                      const SizedBox(height: Dimens.xLarge),
                                    ],
                                  );
                                }

                                if (profileStatus is ProfileLoading) {
                                  return Column(
                                    children: [
                                      CustomButton(
                                        title: "post",
                                        loading: true,
                                        appFontSize: appFontSize,
                                        onTap: () async {},
                                      ),
                                      const SizedBox(height: Dimens.xLarge),
                                    ],
                                  );
                                }
                                return Container();
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
                              borderRadius:
                                  BorderRadius.circular(size.width / 2),
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
