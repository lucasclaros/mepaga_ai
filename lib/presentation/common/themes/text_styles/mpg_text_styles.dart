import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/themes/app_theme_interface.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';

class MPGTextStyles implements IAppTextStyles {
  static MPGTextStyles of(
    BuildContext context, {
    bool listen = false,
  }) =>
      AppThemeInterface.of(
        context,
        listen: listen,
      ).textStyles;

  @override
  TextStyle get mpgColoredButton => GoogleFonts.barlow(
        color: white,
        fontSize: 21,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get mpgWhitedButton => GoogleFonts.barlow(
        color: darkPurple,
        fontSize: 21,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get welcomeSubtitle => GoogleFonts.barlow(
        color: white,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      );

  @override
  TextStyle get welcomeTitle => GoogleFonts.barlow(
        color: white,
        fontWeight: FontWeight.w800,
        fontSize: 40,
      );

  @override
  TextStyle get onboardingHintDescription => GoogleFonts.barlow(
        color: white,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      );

  @override
  TextStyle get onboardingHintTitle => GoogleFonts.barlow(
        color: white,
        fontSize: 25,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get emailVerificationDescription => GoogleFonts.barlow(
        color: white,
        fontSize: 24,
      );

  @override
  TextStyle get emailVerificationTitle => GoogleFonts.barlow(
        color: white,
        fontSize: 32,
        fontWeight: FontWeight.w500,
      );

  @override
  TextStyle get mpgColoredButtonDisabled => GoogleFonts.barlow(
        color: white04,
        fontSize: 21,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get policyColoredDescription => GoogleFonts.barlow(
        color: orangePantone,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get policyNormalDescription => GoogleFonts.barlow(
        color: white,
        fontSize: 18,
      );
}
