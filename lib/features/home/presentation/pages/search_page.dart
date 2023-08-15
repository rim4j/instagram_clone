import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/common/constants/dimens.dart';
import 'package:instagram_clone/common/widgets/input_text.dart';
import 'package:instagram_clone/config/theme/app_styles.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    TextEditingController searchController = TextEditingController();
    AppFontSize appFontSize = AppFontSize(size: size);
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimens.small),
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.onSecondaryContainer,
                borderRadius: BorderRadius.circular(Dimens.medium),
              ),
              child: TextField(
                controller: searchController,
                style:
                    robotoMedium.copyWith(fontSize: appFontSize.mediumFontSize),
                cursorColor: colorScheme.onPrimary,
                decoration: InputDecoration(
                  hintText: "search",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: Dimens.small),
          Expanded(
            child: AnimationLimiter(
              child: GridView.custom(
                gridDelegate: SliverQuiltedGridDelegate(
                  mainAxisSpacing: 7,
                  crossAxisSpacing: 7,
                  crossAxisCount: 3,
                  repeatPattern: QuiltedGridRepeatPattern.inverted,
                  pattern: [
                    const QuiltedGridTile(2, 2),
                    const QuiltedGridTile(1, 1),
                    const QuiltedGridTile(1, 1),
                    const QuiltedGridTile(1, 1),
                    const QuiltedGridTile(1, 1),
                    const QuiltedGridTile(1, 1),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  childCount: 20,
                  (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      columnCount: 3,
                      duration: const Duration(seconds: 1),
                      child: FadeInAnimation(
                        child: ScaleAnimation(
                          //check last index list for padding from bottom
                          child: Container(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      // body: AnimationLimiter(
      //   child: GridView.custom(
      //     gridDelegate: SliverQuiltedGridDelegate(
      //       mainAxisSpacing: 7,
      //       crossAxisSpacing: 7,
      //       crossAxisCount: 3,
      //       repeatPattern: QuiltedGridRepeatPattern.inverted,
      //       pattern: [
      //         const QuiltedGridTile(2, 2),
      //         const QuiltedGridTile(1, 1),
      //         const QuiltedGridTile(1, 1),
      //         const QuiltedGridTile(1, 1),
      //         const QuiltedGridTile(1, 1),
      //         const QuiltedGridTile(1, 1),
      //       ],
      //     ),
      //     childrenDelegate: SliverChildBuilderDelegate(
      //       childCount: 20,
      //       (context, index) {
      //         return AnimationConfiguration.staggeredGrid(
      //           position: index,
      //           columnCount: 3,
      //           duration: const Duration(seconds: 1),
      //           child: FadeInAnimation(
      //             child: ScaleAnimation(
      //               child: Container(
      //                 color: Colors.grey,
      //               ),
      //             ),
      //           ),
      //         );
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
