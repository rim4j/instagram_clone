import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: AnimationLimiter(
          child: GridView.custom(
            gridDelegate: SliverQuiltedGridDelegate(
                mainAxisSpacing: 7,
                crossAxisSpacing: 7,
                crossAxisCount: 3,
                pattern: [
                  const QuiltedGridTile(1, 1),
                  const QuiltedGridTile(1, 1),
                  const QuiltedGridTile(1, 1),
                ]),
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
    );
  }
}
