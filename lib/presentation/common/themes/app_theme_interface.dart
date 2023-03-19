import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:provider/provider.dart';

abstract class IAppColors {
  Gradient get scaffoldGradient;

  Gradient get mpgButtonGradient;
}

abstract class IAppTextStyles {
  TextStyle get mpgButton;
}

abstract class IAppAssetsPaths {}

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
