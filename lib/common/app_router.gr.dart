// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AddBuyerEmailPage]
class AddBuyerEmailRoute extends PageRouteInfo<AddBuyerEmailRouteArgs> {
  AddBuyerEmailRoute({
    Key? key,
    required String ticketId,
    required String platform,
    required dynamic Function(String) onEmailAdded,
    List<PageRouteInfo>? children,
  }) : super(
          AddBuyerEmailRoute.name,
          args: AddBuyerEmailRouteArgs(
            key: key,
            ticketId: ticketId,
            platform: platform,
            onEmailAdded: onEmailAdded,
          ),
          initialChildren: children,
        );

  static const String name = 'AddBuyerEmailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddBuyerEmailRouteArgs>();
      return AddBuyerEmailPage(
        key: args.key,
        ticketId: args.ticketId,
        platform: args.platform,
        onEmailAdded: args.onEmailAdded,
      );
    },
  );
}

class AddBuyerEmailRouteArgs {
  const AddBuyerEmailRouteArgs({
    this.key,
    required this.ticketId,
    required this.platform,
    required this.onEmailAdded,
  });

  final Key? key;

  final String ticketId;

  final String platform;

  final dynamic Function(String) onEmailAdded;

  @override
  String toString() {
    return 'AddBuyerEmailRouteArgs{key: $key, ticketId: $ticketId, platform: $platform, onEmailAdded: $onEmailAdded}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddBuyerEmailRouteArgs) return false;
    return key == other.key &&
        ticketId == other.ticketId &&
        platform == other.platform;
  }

  @override
  int get hashCode => key.hashCode ^ ticketId.hashCode ^ platform.hashCode;
}

/// generated route for
/// [AddEmailPlatformView]
class AddEmailPlatformRoute extends PageRouteInfo<AddEmailPlatformRouteArgs> {
  AddEmailPlatformRoute({
    Key? key,
    required String platform,
    required dynamic Function() onSuccess,
    List<PageRouteInfo>? children,
  }) : super(
          AddEmailPlatformRoute.name,
          args: AddEmailPlatformRouteArgs(
            key: key,
            platform: platform,
            onSuccess: onSuccess,
          ),
          initialChildren: children,
        );

  static const String name = 'AddEmailPlatformRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddEmailPlatformRouteArgs>();
      return AddEmailPlatformView(
        key: args.key,
        platform: args.platform,
        onSuccess: args.onSuccess,
      );
    },
  );
}

class AddEmailPlatformRouteArgs {
  const AddEmailPlatformRouteArgs({
    this.key,
    required this.platform,
    required this.onSuccess,
  });

  final Key? key;

  final String platform;

  final dynamic Function() onSuccess;

  @override
  String toString() {
    return 'AddEmailPlatformRouteArgs{key: $key, platform: $platform, onSuccess: $onSuccess}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddEmailPlatformRouteArgs) return false;
    return key == other.key && platform == other.platform;
  }

  @override
  int get hashCode => key.hashCode ^ platform.hashCode;
}

/// generated route for
/// [BottomNavbarWrapper]
class BottomNavbarRoute extends PageRouteInfo<BottomNavbarRouteArgs> {
  BottomNavbarRoute({
    Key? key,
    bool showFlushbar = false,
    List<PageRouteInfo>? children,
  }) : super(
          BottomNavbarRoute.name,
          args: BottomNavbarRouteArgs(key: key, showFlushbar: showFlushbar),
          initialChildren: children,
        );

  static const String name = 'BottomNavbarRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BottomNavbarRouteArgs>(
        orElse: () => const BottomNavbarRouteArgs(),
      );
      return BottomNavbarWrapper(
        key: args.key,
        showFlushbar: args.showFlushbar,
      );
    },
  );
}

class BottomNavbarRouteArgs {
  const BottomNavbarRouteArgs({this.key, this.showFlushbar = false});

  final Key? key;

  final bool showFlushbar;

  @override
  String toString() {
    return 'BottomNavbarRouteArgs{key: $key, showFlushbar: $showFlushbar}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BottomNavbarRouteArgs) return false;
    return key == other.key && showFlushbar == other.showFlushbar;
  }

  @override
  int get hashCode => key.hashCode ^ showFlushbar.hashCode;
}

/// generated route for
/// [BuyerPage]
class BuyerRoute extends PageRouteInfo<BuyerRouteArgs> {
  BuyerRoute({
    Key? key,
    required String ticketId,
    List<PageRouteInfo>? children,
  }) : super(
          BuyerRoute.name,
          args: BuyerRouteArgs(key: key, ticketId: ticketId),
          rawPathParams: {'ticketId': ticketId},
          initialChildren: children,
        );

  static const String name = 'BuyerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<BuyerRouteArgs>(
        orElse: () =>
            BuyerRouteArgs(ticketId: pathParams.getString('ticketId')),
      );
      return BuyerPage(key: args.key, ticketId: args.ticketId);
    },
  );
}

class BuyerRouteArgs {
  const BuyerRouteArgs({this.key, required this.ticketId});

  final Key? key;

  final String ticketId;

  @override
  String toString() {
    return 'BuyerRouteArgs{key: $key, ticketId: $ticketId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BuyerRouteArgs) return false;
    return key == other.key && ticketId == other.ticketId;
  }

  @override
  int get hashCode => key.hashCode ^ ticketId.hashCode;
}

/// generated route for
/// [EmptyRouterPage]
class EmptyRouterRoute extends PageRouteInfo<void> {
  const EmptyRouterRoute({List<PageRouteInfo>? children})
      : super(EmptyRouterRoute.name, initialChildren: children);

  static const String name = 'EmptyRouterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EmptyRouterPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    Key? key,
    bool showFlushbar = false,
    List<PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(key: key, showFlushbar: showFlushbar),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>(
        orElse: () => const HomeRouteArgs(),
      );
      return HomePage(key: args.key, showFlushbar: args.showFlushbar);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key, this.showFlushbar = false});

  final Key? key;

  final bool showFlushbar;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, showFlushbar: $showFlushbar}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HomeRouteArgs) return false;
    return key == other.key && showFlushbar == other.showFlushbar;
  }

  @override
  int get hashCode => key.hashCode ^ showFlushbar.hashCode;
}

/// generated route for
/// [HomeTabPage]
class HomeTab extends PageRouteInfo<void> {
  const HomeTab({List<PageRouteInfo>? children})
      : super(HomeTab.name, initialChildren: children);

  static const String name = 'HomeTab';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeTabPage();
    },
  );
}

/// generated route for
/// [LoginView]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginView();
    },
  );
}

/// generated route for
/// [OTPPlatformVerificationView]
class OTPPlatformVerificationRoute
    extends PageRouteInfo<OTPPlatformVerificationRouteArgs> {
  OTPPlatformVerificationRoute({
    Key? key,
    required String platform,
    required dynamic Function() onSuccess,
    String? email,
    List<PageRouteInfo>? children,
  }) : super(
          OTPPlatformVerificationRoute.name,
          args: OTPPlatformVerificationRouteArgs(
            key: key,
            platform: platform,
            onSuccess: onSuccess,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'OTPPlatformVerificationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OTPPlatformVerificationRouteArgs>();
      return OTPPlatformVerificationView(
        key: args.key,
        platform: args.platform,
        onSuccess: args.onSuccess,
        email: args.email,
      );
    },
  );
}

class OTPPlatformVerificationRouteArgs {
  const OTPPlatformVerificationRouteArgs({
    this.key,
    required this.platform,
    required this.onSuccess,
    this.email,
  });

  final Key? key;

  final String platform;

  final dynamic Function() onSuccess;

  final String? email;

  @override
  String toString() {
    return 'OTPPlatformVerificationRouteArgs{key: $key, platform: $platform, onSuccess: $onSuccess, email: $email}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OTPPlatformVerificationRouteArgs) return false;
    return key == other.key &&
        platform == other.platform &&
        email == other.email;
  }

  @override
  int get hashCode => key.hashCode ^ platform.hashCode ^ email.hashCode;
}

/// generated route for
/// [OTPVerificationView]
class OTPVerificationRoute extends PageRouteInfo<void> {
  const OTPVerificationRoute({List<PageRouteInfo>? children})
      : super(OTPVerificationRoute.name, initialChildren: children);

  static const String name = 'OTPVerificationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OTPVerificationView();
    },
  );
}

/// generated route for
/// [OnboardingView]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardingView();
    },
  );
}

/// generated route for
/// [PaymentPage]
class PaymentRoute extends PageRouteInfo<PaymentRouteArgs> {
  PaymentRoute({
    Key? key,
    required PaymentCharge paymentCharge,
    required String platform,
    List<PageRouteInfo>? children,
  }) : super(
          PaymentRoute.name,
          args: PaymentRouteArgs(
            key: key,
            paymentCharge: paymentCharge,
            platform: platform,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PaymentRouteArgs>();
      return PaymentPage(
        key: args.key,
        paymentCharge: args.paymentCharge,
        platform: args.platform,
      );
    },
  );
}

class PaymentRouteArgs {
  const PaymentRouteArgs({
    this.key,
    required this.paymentCharge,
    required this.platform,
  });

  final Key? key;

  final PaymentCharge paymentCharge;

  final String platform;

  @override
  String toString() {
    return 'PaymentRouteArgs{key: $key, paymentCharge: $paymentCharge, platform: $platform}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PaymentRouteArgs) return false;
    return key == other.key &&
        paymentCharge == other.paymentCharge &&
        platform == other.platform;
  }

  @override
  int get hashCode => key.hashCode ^ paymentCharge.hashCode ^ platform.hashCode;
}

/// generated route for
/// [PaymentRegistrationPage]
class PaymentRegistrationRoute
    extends PageRouteInfo<PaymentRegistrationRouteArgs> {
  PaymentRegistrationRoute({
    Key? key,
    required VoidCallback onSuccess,
    List<PageRouteInfo>? children,
  }) : super(
          PaymentRegistrationRoute.name,
          args: PaymentRegistrationRouteArgs(key: key, onSuccess: onSuccess),
          initialChildren: children,
        );

  static const String name = 'PaymentRegistrationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PaymentRegistrationRouteArgs>();
      return PaymentRegistrationPage(key: args.key, onSuccess: args.onSuccess);
    },
  );
}

class PaymentRegistrationRouteArgs {
  const PaymentRegistrationRouteArgs({this.key, required this.onSuccess});

  final Key? key;

  final VoidCallback onSuccess;

  @override
  String toString() {
    return 'PaymentRegistrationRouteArgs{key: $key, onSuccess: $onSuccess}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PaymentRegistrationRouteArgs) return false;
    return key == other.key && onSuccess == other.onSuccess;
  }

  @override
  int get hashCode => key.hashCode ^ onSuccess.hashCode;
}

/// generated route for
/// [PlatformRegistrationView]
class PlatformRegistrationRoute extends PageRouteInfo<void> {
  const PlatformRegistrationRoute({List<PageRouteInfo>? children})
      : super(PlatformRegistrationRoute.name, initialChildren: children);

  static const String name = 'PlatformRegistrationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PlatformRegistrationView();
    },
  );
}

/// generated route for
/// [PlatofrmTabPage]
class PlatformTab extends PageRouteInfo<void> {
  const PlatformTab({List<PageRouteInfo>? children})
      : super(PlatformTab.name, initialChildren: children);

  static const String name = 'PlatformTab';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PlatofrmTabPage();
    },
  );
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}

/// generated route for
/// [ProfileTabPage]
class ProfileTab extends PageRouteInfo<ProfileTabArgs> {
  ProfileTab({
    required VoidCallback onPop,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileTab.name,
          args: ProfileTabArgs(onPop: onPop, key: key),
          initialChildren: children,
        );

  static const String name = 'ProfileTab';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileTabArgs>();
      return ProfileTabPage(onPop: args.onPop, key: args.key);
    },
  );
}

class ProfileTabArgs {
  const ProfileTabArgs({required this.onPop, this.key});

  final VoidCallback onPop;

  final Key? key;

  @override
  String toString() {
    return 'ProfileTabArgs{onPop: $onPop, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProfileTabArgs) return false;
    return onPop == other.onPop && key == other.key;
  }

  @override
  int get hashCode => onPop.hashCode ^ key.hashCode;
}

/// generated route for
/// [RegisterEmailView]
class RegisterEmailRoute extends PageRouteInfo<void> {
  const RegisterEmailRoute({List<PageRouteInfo>? children})
      : super(RegisterEmailRoute.name, initialChildren: children);

  static const String name = 'RegisterEmailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterEmailView();
    },
  );
}

/// generated route for
/// [RegisterPasswordView]
class RegisterPasswordRoute extends PageRouteInfo<void> {
  const RegisterPasswordRoute({List<PageRouteInfo>? children})
      : super(RegisterPasswordRoute.name, initialChildren: children);

  static const String name = 'RegisterPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterPasswordView();
    },
  );
}

/// generated route for
/// [TicketSellerPage]
class TicketSellerRoute extends PageRouteInfo<TicketSellerRouteArgs> {
  TicketSellerRoute({
    Key? key,
    required String ticketId,
    bool isBuy = false,
    List<PageRouteInfo>? children,
  }) : super(
          TicketSellerRoute.name,
          args: TicketSellerRouteArgs(
            key: key,
            ticketId: ticketId,
            isBuy: isBuy,
          ),
          initialChildren: children,
        );

  static const String name = 'TicketSellerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TicketSellerRouteArgs>();
      return TicketSellerPage(
        key: args.key,
        ticketId: args.ticketId,
        isBuy: args.isBuy,
      );
    },
  );
}

class TicketSellerRouteArgs {
  const TicketSellerRouteArgs({
    this.key,
    required this.ticketId,
    this.isBuy = false,
  });

  final Key? key;

  final String ticketId;

  final bool isBuy;

  @override
  String toString() {
    return 'TicketSellerRouteArgs{key: $key, ticketId: $ticketId, isBuy: $isBuy}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TicketSellerRouteArgs) return false;
    return key == other.key &&
        ticketId == other.ticketId &&
        isBuy == other.isBuy;
  }

  @override
  int get hashCode => key.hashCode ^ ticketId.hashCode ^ isBuy.hashCode;
}

/// generated route for
/// [TransferOrientationPage]
class TransferOrientationRoute
    extends PageRouteInfo<TransferOrientationRouteArgs> {
  TransferOrientationRoute({
    Key? key,
    required String platform,
    List<PageRouteInfo>? children,
  }) : super(
          TransferOrientationRoute.name,
          args: TransferOrientationRouteArgs(key: key, platform: platform),
          initialChildren: children,
        );

  static const String name = 'TransferOrientationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TransferOrientationRouteArgs>();
      return TransferOrientationPage(key: args.key, platform: args.platform);
    },
  );
}

class TransferOrientationRouteArgs {
  const TransferOrientationRouteArgs({this.key, required this.platform});

  final Key? key;

  final String platform;

  @override
  String toString() {
    return 'TransferOrientationRouteArgs{key: $key, platform: $platform}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TransferOrientationRouteArgs) return false;
    return key == other.key && platform == other.platform;
  }

  @override
  int get hashCode => key.hashCode ^ platform.hashCode;
}

/// generated route for
/// [WelcomePage]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(WelcomeRoute.name, initialChildren: children);

  static const String name = 'WelcomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WelcomePage();
    },
  );
}
