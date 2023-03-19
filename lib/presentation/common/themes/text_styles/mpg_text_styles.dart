import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/themes/app_theme_interface.dart';

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
  TextStyle get mpgButton => GoogleFonts.barlow(
        color: Colors.white,
        fontSize: 21,
        fontWeight: FontWeight.w700,
      );
}
