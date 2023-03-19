import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/themes/app_theme_interface.dart';

class MPGColors implements IAppColors {
  static MPGColors of(
    BuildContext context, {
    bool listen = false,
  }) =>
      AppThemeInterface.of(
        context,
        listen: listen,
      ).colors;

  @override
  Gradient get scaffoldGradient => const LinearGradient(
        stops: [0.3, 1],
        colors: [
          Color(0xff010203),
          Color(0xff22004b),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
}
