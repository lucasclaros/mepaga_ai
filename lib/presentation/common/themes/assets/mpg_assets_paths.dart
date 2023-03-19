import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/themes/app_theme_interface.dart';

class MPGAssetsPaths implements IAppAssetsPaths {
  final _assetsFolderPath = 'assets';

  static MPGAssetsPaths of(
    BuildContext context, {
    bool listen = false,
  }) =>
      AppThemeInterface.of(
        context,
        listen: listen,
      ).assets;
}
