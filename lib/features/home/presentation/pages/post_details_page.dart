import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/constants/strings.dart';
import 'package:instagram_clone/config/routes/route_names.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:readmore/readmore.dart';

class PostDetailsPage extends StatelessWidget {
  const PostDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    AppFontSize appFontSize = AppFontSize(size: size);
    TextEditingController commentController = TextEditingController();

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        title: Row(
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
                fontSize: appFontSize.largeFontSize,
                color: colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {},
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
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
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
                              borderRadius:
                                  BorderRadius.circular(Dimens.xxLarge),
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
                                          borderRadius: BorderRadius.circular(
                                              Dimens.large),
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
                                        Navigator.pushNamed(context,
                                            RouteNames.postDetailsPage);
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
                //description
                Padding(
                  padding: EdgeInsets.all(Dimens.small),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ReadMoreText(
                      Strings.lorem,
                      trimLines: 2,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      style: robotoMedium.copyWith(
                        fontSize: appFontSize.mediumFontSize,
                        height: size.height * 0.002,
                      ),
                      moreStyle: robotoBold.copyWith(
                        fontSize: appFontSize.mediumFontSize,
                      ),
                      lessStyle: robotoBold.copyWith(
                        fontSize: appFontSize.mediumFontSize,
                      ),
                    ),
                  ),
                ),

                // comments
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        Dimens.medium,
                        Dimens.medium,
                        Dimens.medium,
                        //check for last index on comment list
                        //commentList.length-1
                        index == 9 ? size.height / 10 : Dimens.small,
                      ),
                      child: Row(
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "david morel",
                                    style: robotoMedium.copyWith(
                                      fontSize: appFontSize.mediumFontSize,
                                      color: colorScheme.onSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "this is comment",
                                    style: robotoMedium.copyWith(
                                      fontSize: appFontSize.smallFontSize,
                                      color: colorScheme.onSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "31/jul/2022",
                                        style: robotoMedium.copyWith(
                                          fontSize:
                                              appFontSize.verySmallFontSize,
                                          color: colorScheme.onSecondary,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Replay",
                                        style: robotoMedium.copyWith(
                                          fontSize:
                                              appFontSize.verySmallFontSize,
                                          color: colorScheme.onSecondary,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "View Replays",
                                        style: robotoMedium.copyWith(
                                          fontSize:
                                              appFontSize.verySmallFontSize,
                                          color: colorScheme.onSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Dimens.small),
                            child: Icon(FontAwesomeIcons.heart),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 80,
              color: colorScheme.background,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.large),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.1,
                      height: size.width * 0.1,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: size.width / 1.8,
                      child: TextField(
                        controller: commentController,
                      ),
                    ),
                    const Text("Post"),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
