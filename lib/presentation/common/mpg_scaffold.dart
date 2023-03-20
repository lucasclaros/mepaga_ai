// ignore_for_file: use_colored_box, use_decorated_box

import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';

class MPGScaffold extends StatelessWidget {
  const MPGScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: MPGColors.of(context).scaffoldGradient,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: child,
        ),
      ),
    );
  }
}
