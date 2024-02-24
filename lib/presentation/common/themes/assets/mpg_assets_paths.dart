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

  @override
  String get doubtButton => getAssetPath('doubt_button.svg');

  @override
  String get userIcon => getAssetPath('user_icon.svg');

  @override
  String get emptyTickets => getAssetPath('empty_tickets.svg');

  @override
  String get forwardIcon => getAssetPath('forward_icon.svg');

  @override
  String get addTicketIcon => getAssetPath('add_tickets.svg');

  @override
  String get homeNavIcon => getAssetPath('home_icon.svg');

  @override
  String get profileNavIcon => getAssetPath('profile_icon.svg');

  @override
  String get addTicketSelectedIcon => getAssetPath('add_tickets_selected.svg');

  @override
  String get logoByma => getAssetPath('logo_byma.svg');

  @override
  String get logoPix => getAssetPath('logo_pix.svg');

  @override
  String get faceWithSunglasses => getAssetPath('face_with_sunglasses.svg');

  @override
  String get partyEmoji => getAssetPath('party_popper.svg');

  @override
  String get partyingFace => getAssetPath('partying_face.svg');

  @override
  String get ballonEmoji => getAssetPath('balloon.svg');

  @override
  String get beerEmoji => getAssetPath('beer_mug.svg');

  @override
  String get ticketPlaceholder => getAssetPath('ticket_placeholder.png');

  @override
  String get walletIcon => getAssetPath('wallet.svg');

  @override
  String get copyClipboardIcon => getAssetPath('copy_clipboard_icon.svg');

  @override
  String get qrTest => getAssetPath('qr_test.png');
}
