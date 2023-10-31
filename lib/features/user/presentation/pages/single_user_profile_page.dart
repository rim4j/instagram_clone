import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/user/domain/entities/user_entity.dart';
import 'package:instagram_clone/features/user/presentation/bloc/status/single_user_status.dart';
import 'package:instagram_clone/features/user/presentation/bloc/user_bloc.dart';

class SingleUserProfilePage extends StatefulWidget {
  final String userUid;
  const SingleUserProfilePage({
    super.key,
    required this.userUid,
  });

  @override
  State<SingleUserProfilePage> createState() => _SingleUserProfilePageState();
}

class _SingleUserProfilePageState extends State<SingleUserProfilePage> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context)
        .add(GetSingleUserProfile(userUid: widget.userUid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          final singleUserStatus = userState.singleUserStatus;

          if (singleUserStatus is SingleUserLoading) {
            return const CircularProgressIndicator();
          }

          if (singleUserStatus is SingleUserCompleted) {
            final UserEntity singleUser = singleUserStatus.singleUser;
            print(singleUser.bio);

            return Text(singleUser.username!);
          }

          if (singleUserStatus is SingleUserFailed) {
            return Text("some error");
          }
          return Container();
        },
      ),
    );
  }
}
