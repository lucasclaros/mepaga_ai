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

  @override
  String get backButton => getAssetPath('back_button.svg');

  @override
  String get checkButton => getAssetPath('check_button.svg');

  @override
  String get emailIcon => getAssetPath('email_icon.svg');

  @override
  String get passwordEyeNotVisible => getAssetPath('pass_eye_not_visible.svg');

  @override
  String get passwordEyeVisible => getAssetPath('pass_eye_visible.svg');

  @override
  String get passwordIconLocked => getAssetPath('pass_locked.svg');

  @override
  String get passwordIconUnlocked => getAssetPath('pass_unlocked.svg');
}
