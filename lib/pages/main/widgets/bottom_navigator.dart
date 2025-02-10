import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:movie_app/services/global_service.dart';
import 'package:movie_app/utils/app_colors.dart';

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> animateDown = ValueNotifier(false);
    const double bottomNavigatorWidth = 220;

    GlobalService().homeScrollController.addListener(() {
      if (GlobalService().homeScrollController.position.userScrollDirection == ScrollDirection.reverse) {
        animateDown.value = true;
      } else if (GlobalService().homeScrollController.position.userScrollDirection == ScrollDirection.forward) {
        animateDown.value = false;
      }
    });

    Widget buildPageButton({
      required int pageIndex,
      required int activePage,
      required IconData icon,
    }) {
      return GestureDetector(
        onTap: () {
          GlobalService().mainPageController.animateToPage(
                pageIndex,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
              );

          GlobalService().activePage.value = pageIndex;
        },
        child: Icon(
          icon,
          color: activePage == pageIndex ? Colors.orange[800] : AppColors.blackCoral,
          size: 32,
        ),
      );
    }

    return ValueListenableBuilder(
      valueListenable: animateDown,
      builder: (context, animate, _) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 350),
          bottom: animate ? -90 : 10,
          left: (MediaQuery.of(context).size.width - bottomNavigatorWidth) / 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.lightDesertSand.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: Container(
                  width: bottomNavigatorWidth,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: GlobalService().activePage,
                    builder: (context, activePage, _) {
                      return Row(
                        spacing: 32,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildPageButton(
                            activePage: activePage,
                            pageIndex: 0,
                            icon: Feather.heart,
                          ),
                          buildPageButton(
                            activePage: activePage,
                            pageIndex: 1,
                            icon: Feather.film,
                          ),
                          buildPageButton(
                            activePage: activePage,
                            pageIndex: 2,
                            icon: Feather.user,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
