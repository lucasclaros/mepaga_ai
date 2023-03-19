import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/themes/app_theme_interface.dart';

class MPGColors implements IAppColors {
  static MPGColors of(
    BuildContext context, {
    bool listen = false,
  }) =>
      AppThemeInterface.of(
        context,
        listen: listen,
      ).colors;
}
