import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/constants/images.dart';
import 'package:instagram_clone/config/routes/route_names.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    AppFontSize appFontSize = AppFontSize(size: size);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  IMAGES.logoInstagram,
                  width: size.width / 14,
                ),
                const SizedBox(width: Dimens.small),
                Text(
                  "Instagram",
                  style: robotoMedium.copyWith(
                    fontSize: appFontSize.veryLargeFontSize,
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.paperPlane,
                color: colorScheme.onSecondary,
              ),
            )
          ],
        ),
      ),
      backgroundColor: colorScheme.background,
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return PostItem(
            onTap: () =>
                Navigator.pushNamed(context, RouteNames.postDetailsPage),
            size: size,
            appFontSize: appFontSize,
            colorScheme: colorScheme,
          );
        },
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.size,
    required this.appFontSize,
    required this.colorScheme,
    required this.onTap,
  });

  final Size size;
  final AppFontSize appFontSize;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: Dimens.small),
                //avatar
                Container(
                  width: size.width * 0.1,
                  height: size.width * 0.1,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: Dimens.small),
                //name profile
                Text(
                  "david morel",
                  style: robotoMedium.copyWith(
                    fontSize: appFontSize.mediumFontSize,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.ellipsisVertical),
            )
          ],
        ),
        const SizedBox(height: Dimens.medium),
        //picture post

        Stack(
          children: [
            GestureDetector(
              onTap: onTap,
              child: SizedBox(
                width: size.width,
                height: size.width,
                child: CachedNetworkImage(
                  imageUrl:
                      "https://i0.wp.com/www.flutterbeads.com/wp-content/uploads/2022/01/add-image-in-flutter-hero.png",
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),

            //likes comment and share

            Positioned(
              left: Dimens.medium,
              right: Dimens.medium,
              bottom: Dimens.medium,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: size.width / 1.3,
                    height: 70,
                    decoration: BoxDecoration(
                      color: colorScheme.background.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(Dimens.xxLarge),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            //likes

                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: colorScheme.background,
                                  borderRadius:
                                      BorderRadius.circular(Dimens.large),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    print("like");
                                  },
                                  child: const Row(
                                    children: [
                                      SizedBox(width: Dimens.medium),
                                      Icon(FontAwesomeIcons.heart),
                                      SizedBox(width: Dimens.small),
                                      Text("5.2 k"),
                                      SizedBox(width: Dimens.medium),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //comment

                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteNames.postDetailsPage);
                              },
                              child: const Row(
                                children: [
                                  Icon(FontAwesomeIcons.comment),
                                  SizedBox(width: Dimens.small),
                                  Text("140"),
                                ],
                              ),
                            ),
                            const SizedBox(width: Dimens.medium),
                            //share
                            GestureDetector(
                              onTap: () {
                                print("share post");
                              },
                              child: const Icon(
                                FontAwesomeIcons.paperPlane,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            print("added to the bookmark");
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimens.large,
                            ),
                            child: Icon(
                              FontAwesomeIcons.bookmark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: Dimens.medium),
      ],
    );
  }
}
