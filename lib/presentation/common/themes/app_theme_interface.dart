import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:provider/provider.dart';

abstract class IAppColors {
  Gradient get scaffoldGradient;

  Gradient get mpgButtonColoredGradient;

  Gradient get mpgButtonColoredGradientDisabled;

  Gradient get mpgButtonWhitedGradient;

  Color get dividerColor;

  Color get activePageViewIndicator;

  Color get inactivePageViewIndicator;
}

abstract class IAppTextStyles {
  TextStyle get mpgColoredButton;

  TextStyle get mpgColoredButtonDisabled;

  TextStyle get welcomeTitle;

  TextStyle get welcomeSubtitle;

  TextStyle get mpgWhitedButton;

  TextStyle get onboardingHintTitle;

  TextStyle get onboardingHintDescription;

  TextStyle get emailVerificationTitle;

  TextStyle get emailVerificationDescription;

  TextStyle get policyNormalDescriptionWeb;

  TextStyle get policyNormalDescriptionMobile;

  TextStyle get policyColoredDescription;

  TextStyle get verificationHeaderTitleWeb;

  TextStyle get verificationHeaderTitleMobile;

  TextStyle get emailVerificationDescriptionWeb;

  TextStyle get emailVerificationDescriptionMobile;

  TextStyle get otpVerifcationUserEmail;

  TextStyle get pinputDefaultTheme;

  TextStyle get otpPasteIndicator;

  TextStyle get alreadyHasAccountMessage;
}

abstract class IAppAssetsPaths {
  String get welcomeBackground;

  String get mpgScaffold;

  String get securityLogo;

  String get simplicityLogo;

  String get flexibilityLogo;

  String get backButton;

  String get checkButton;

  String get emailIcon;

  String get passwordIconLocked;

  String get passwordIconUnlocked;

  String get passwordEyeVisible;

  String get passwordEyeNotVisible;

  String get doubtButton;

  String get userIcon;
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
