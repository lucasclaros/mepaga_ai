import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        fontSize: 21.sp,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get mpgWhitedButton => GoogleFonts.barlow(
        color: darkPurple,
        fontSize: 21.sp,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get welcomeSubtitle => GoogleFonts.barlow(
        color: white,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
      );

  @override
  TextStyle get welcomeTitle => GoogleFonts.barlow(
        color: white,
        fontWeight: FontWeight.w800,
        fontSize: 40.sp,
      );

  @override
  TextStyle get onboardingHintDescription => GoogleFonts.barlow(
        color: textSecondary,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  @override
  TextStyle get onboardingHintTitle => GoogleFonts.barlow(
        color: textPrimary,
        fontSize: 20.sp,
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
        fontSize: 21.sp,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get policyColoredDescription => GoogleFonts.barlow(
        color: orangePantone,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get policyNormalDescriptionMobile => GoogleFonts.barlow(
        color: white,
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
      );

  @override
  TextStyle get verificationHeaderTitleMobile => GoogleFonts.barlow(
        color: white,
        fontSize: 32.sp,
        fontWeight: FontWeight.w500,
      );

  @override
  TextStyle get emailVerificationDescriptionMobile => GoogleFonts.barlow(
        color: white,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      );

  @override
  TextStyle get otpVerifcationUserEmail => GoogleFonts.barlow(
        color: white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get pinputDefaultTheme => GoogleFonts.barlow(
        color: white,
        fontSize: 42,
        fontWeight: FontWeight.w500,
      );

  @override
  TextStyle get otpPasteIndicator => GoogleFonts.barlow(
        color: white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      );

  @override
  TextStyle get alreadyHasAccountMessage => GoogleFonts.barlow(
        color: textSecondary,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
        decorationColor: textSecondary,
      );
}
