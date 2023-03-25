// ignore_for_file: use_colored_box, use_decorated_box

import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';

class MPGScaffold extends StatelessWidget {
  const MPGScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              MPGAssetsPaths.of(context).mpgScaffold,
              fit: BoxFit.cover,
              height: height,
              width: width,
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: child,
            )
          ],
        ),
      ),
    );
  }
}
