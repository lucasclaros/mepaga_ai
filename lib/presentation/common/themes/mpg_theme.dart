import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/themes/app_theme_interface.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class MPGAppTheme implements AppThemeInterface {
  @override
  MPGAssetsPaths get assets => MPGAssetsPaths();

  @override
  MPGColors get colors => MPGColors();

  @override
  MPGTextStyles get textStyles => MPGTextStyles();
}

const white = Colors.white;
const richBlack = Color(0xFF010203);
const russianViolet = Color(0xFF22004B);
const razzmatazz = Color(0xFFEB3472);
const amber = Color(0xFFFF7D00);
const darkPurple = Color(0xFF200E32);
Color grey05 = Colors.grey.withOpacity(0.5);
