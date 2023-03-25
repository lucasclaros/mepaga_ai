import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/themes/app_theme_interface.dart';

class MPGAssetsPaths implements IAppAssetsPaths {
  final _assetsFolderPath = 'assets/';

  String getAssetPath(String asset) => '$_assetsFolderPath$asset';

  static MPGAssetsPaths of(
    BuildContext context, {
    bool listen = false,
  }) =>
      AppThemeInterface.of(
        context,
        listen: listen,
      ).assets;

  @override
  String get welcomeBackground => getAssetPath('party.jpg');

  @override
  String get flexibilityLogo => getAssetPath('flexibility.svg');

  @override
  String get securityLogo => getAssetPath('security.svg');

  @override
  String get simplicityLogo => getAssetPath('simplicity.svg');

  @override
  String get mpgScaffold => getAssetPath('background.jpg');
}
