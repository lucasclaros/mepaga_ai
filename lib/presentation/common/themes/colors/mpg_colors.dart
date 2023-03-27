import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/themes/app_theme_interface.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';

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
        stops: [0.1, 0.6, 0.7, 1],
        colors: [
          richBlack,
          russianViolet,
          russianViolet,
          russianViolet,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  @override
  Gradient get mpgButtonColoredGradient => const LinearGradient(
        colors: [
          razzmatazz,
          amber,
        ],
      );

  @override
  Color get activePageViewIndicator => white;

  @override
  Color get dividerColor => white;

  @override
  Color get inactivePageViewIndicator => grey05;
}
