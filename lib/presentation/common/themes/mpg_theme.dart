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

const black = Colors.black;
const white = Colors.white;
Color white04 = white.withValues(alpha: 0.4);

// Base
const richBlack    = Color(0xFF121212); // scaffoldBackground (Material dark standard)
const surfaceColor = Color(0xFF1E1E1E); // cards, containers
const surfaceLight = Color(0xFF2A2A2A); // hover states, filled fields
const surfaceBorder = Color(0xFF333333); // subtle borders
const dividerDark  = Color(0xFF2A2A2A); // dividers
const darkPurple   = Color(0xFF1E1E1E); // alias for surfaceColor

// Brand
const brandPrimary   = Color(0xFFFF6B00); // laranja — botões, nav ativo
const brandSecondary = Color(0xFFFFAA00); // dourado — gradiente fim
const razzmatazz     = brandPrimary;      // alias legado
const amber          = brandSecondary;    // alias legado
const orangePantone  = brandPrimary;      // alias legado

// Text
const textPrimary   = Color(0xFFF5F5F5); // branco suavizado
const textSecondary = Color(0xFF8A8A8A); // cinza hints/labels
Color grey05        = const Color(0xFF666666); // nav unselected

// Semantic
const errorColor   = Color(0xFFFF4D4D);
const successColor = Color(0xFF00C853);

// Nav
const russianViolet = richBlack; // alias legado (era o fundo roxo)
