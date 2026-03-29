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
        stops: [0, 1],
        colors: [richBlack, richBlack],
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
  Gradient get mpgButtonColoredGradientDisabled => LinearGradient(
        colors: [
          razzmatazz.withValues(alpha: 0.4),
          amber.withValues(alpha: 0.4),
        ],
      );

  @override
  Gradient get mpgButtonWhitedGradient => const LinearGradient(
        stops: [0.5, 0.8, 1],
        colors: [
          white,
          Color(0xFFFFCC80),
          Color(0xFFFFCC80),
        ],
      );

  @override
  Color get activePageViewIndicator => brandPrimary;

  @override
  Color get dividerColor => surfaceBorder;

  @override
  Color get inactivePageViewIndicator => surfaceBorder;
}
