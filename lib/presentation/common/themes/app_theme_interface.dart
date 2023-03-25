import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:provider/provider.dart';

abstract class IAppColors {
  Gradient get scaffoldGradient;

  Gradient get mpgButtonGradient;

  Color get dividerColor;

  Color get activePageViewIndicator;

  Color get inactivePageViewIndicator;
}

abstract class IAppTextStyles {
  TextStyle get mpgColoredButton;

  TextStyle get welcomeTitle;

  TextStyle get welcomeSubtitle;

  TextStyle get mpgWhitedButton;

  TextStyle get onboardingHintTitle;

  TextStyle get onboardingHintDescription;
}

abstract class IAppAssetsPaths {
  String get welcomeBackground;

  String get mpgScaffold;

  String get securityLogo;

  String get simplicityLogo;

  String get flexibilityLogo;
}

abstract class AppThemeInterface {
  static AppThemeInterface of(
    BuildContext context, {
    bool listen = false,
  }) =>
      Provider.of<AppThemeInterface>(
        context,
        listen: listen,
      );

  MPGColors get colors;

  MPGTextStyles get textStyles;

  MPGAssetsPaths get assets;
}
