import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/constants/images.dart';
import 'package:instagram_clone/config/routes/route_names.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/domain/usecases/get_single_user_usecase.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/auth_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/user_bloc.dart';
import 'package:instagram_clone/locator.dart';

class FollowersPage extends StatelessWidget {
  final UserEntity user;
  const FollowersPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScheme.background,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSecondary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: false,
        title: Text(
          "Followers",
          style:
              robotoBold.copyWith(fontSize: 18, color: colorScheme.onSecondary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.small, vertical: Dimens.small),
        child: Column(
          children: [
            Expanded(
                child: user.followers!.isEmpty
                    ? Center(
                        child: Text(
                          "No followers !",
                          style: robotoBold.copyWith(
                              fontSize: 16, color: colorScheme.onSecondary),
                        ),
                      )
                    : ListView.builder(
                        itemCount: user.followers!.length,
                        itemBuilder: (context, index) {
                          final uid = user.followers![index];
                          return BlocBuilder<UserBloc, UserState>(
                            builder: (context, userState) {
                              final authUid =
                                  userState.authStatus as Authenticated;
                              return InkWell(
                                onTap: () {
                                  if (authUid.uid == uid) {
                                    Navigator.pushNamed(
                                        context, RouteNames.profilePage,
                                        arguments: authUid.uid);
                                  } else {
                                    Navigator.pushNamed(context,
                                        RouteNames.singleUserProfilePage,
                                        arguments: uid);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(Dimens.small),
                                  child: StreamBuilder<List<UserEntity>>(
                                      stream: locator<GetSingleUserUseCase>()
                                          .call(params: uid),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData == false) {
                                          return CircularProgressIndicator(
                                            color: colorScheme.onSecondary,
                                          );
                                        }
                                        if (snapshot.data!.isEmpty) {
                                          return Container();
                                        }
                                        final singleUserData =
                                            snapshot.data!.first;
                                        return user.followers!.isEmpty
                                            ? Center(
                                                child: Text("no followers"),
                                              )
                                            : Row(
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: CachedNetworkImage(
                                                      imageUrl: singleUserData
                                                                  .profileUrl ==
                                                              ""
                                                          ? IMAGES
                                                              .defaultProfile
                                                          : singleUserData
                                                              .profileUrl!,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder:
                                                          (context, url) =>
                                                              SizedBox(
                                                        width: size.width / 3,
                                                        height: size.width / 3,
                                                        child: SpinKitPulse(
                                                          color: colorScheme
                                                              .primary,
                                                          size: 100,
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: Dimens.small,
                                                  ),
                                                  Text(singleUserData.username
                                                      .toString())
                                                ],
                                              );
                                      }),
                                ),
                              );
                            },
                          );
                        },
                      ))
          ],
        ),
      ),
    );
  }
}
