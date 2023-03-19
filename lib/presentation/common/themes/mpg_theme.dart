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
