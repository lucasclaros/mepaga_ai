// ignore_for_file: use_colored_box, use_decorated_box

import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';

class MPGScaffold extends StatelessWidget {
  const MPGScaffold({
    super.key,
    required this.child,
    this.backgroundColor,
    this.backgroundImage,
    this.bottomNavigationBar,
  });

  final Widget child;
  final Color? backgroundColor;
  final String? backgroundImage;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final background = backgroundImage != null
        ? Image.asset(
            backgroundImage!,
            fit: BoxFit.cover,
            height: height,
            width: width,
          )
        : Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: MPGColors.of(context).scaffoldGradient,
            ),
          );

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          background,
          Scaffold(
            backgroundColor: backgroundColor ?? Colors.transparent,
            body: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: child,
            ),
            bottomNavigationBar: bottomNavigationBar,
          ),
        ],
      ),
    );
  }
}
