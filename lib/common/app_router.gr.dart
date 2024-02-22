// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddEmailPlatformRoute.name: (routeData) {
      final args = routeData.argsAs<AddEmailPlatformRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddEmailPlatformView(
          key: args.key,
          platform: args.platform,
          onSuccess: args.onSuccess,
        ),
      );
    },
    BottomNavbarRoute.name: (routeData) {
      final args = routeData.argsAs<BottomNavbarRouteArgs>(
          orElse: () => const BottomNavbarRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BottomNavbarWrapper(
          key: args.key,
          showFlushbar: args.showFlushbar,
        ),
      );
    },
    EmptyRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomePage(
          key: args.key,
          showFlushbar: args.showFlushbar,
        ),
      );
    },
    HomeTab.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeTabPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginView(),
      );
    },
    OTPPlatformVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<OTPPlatformVerificationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OTPPlatformVerificationView(
          key: args.key,
          platform: args.platform,
          onSuccess: args.onSuccess,
          email: args.email,
        ),
      );
    },
    OTPVerificationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OTPVerificationView(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingView(),
      );
    },
    PaymentRegistrationRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentRegistrationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PaymentRegistrationPage(
          key: args.key,
          onSuccess: args.onSuccess,
        ),
      );
    },
    PlatformRegistrationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PlatformRegistrationView(),
      );
    },
    PlatformTab.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PlatofrmTabPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
    ProfileTab.name: (routeData) {
      final args = routeData.argsAs<ProfileTabArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProfileTabPage(
          onPop: args.onPop,
          key: args.key,
        ),
      );
    },
    RegisterEmailRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterEmailView(),
      );
    },
    RegisterPasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterPasswordView(),
      );
    },
    TicketSellerRoute.name: (routeData) {
      final args = routeData.argsAs<TicketSellerRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TicketSellerPage(
          key: args.key,
          ticketId: args.ticketId,
          isBuy: args.isBuy,
        ),
      );
    },
    TransferOrientationRoute.name: (routeData) {
      final args = routeData.argsAs<TransferOrientationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TransferOrientationPage(
          key: args.key,
          platform: args.platform,
        ),
      );
    },
    WelcomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WelcomePage(),
      );
    },
  };
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

  static const PageInfo<AddEmailPlatformRouteArgs> page =
      PageInfo<AddEmailPlatformRouteArgs>(name);
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
          args: BottomNavbarRouteArgs(
            key: key,
            showFlushbar: showFlushbar,
          ),
          initialChildren: children,
        );

  static const String name = 'BottomNavbarRoute';

  static const PageInfo<BottomNavbarRouteArgs> page =
      PageInfo<BottomNavbarRouteArgs>(name);
}

class BottomNavbarRouteArgs {
  const BottomNavbarRouteArgs({
    this.key,
    this.showFlushbar = false,
  });

  final Key? key;

  final bool showFlushbar;

  @override
  String toString() {
    return 'BottomNavbarRouteArgs{key: $key, showFlushbar: $showFlushbar}';
  }
}

/// generated route for
/// [EmptyRouterPage]
class EmptyRouterRoute extends PageRouteInfo<void> {
  const EmptyRouterRoute({List<PageRouteInfo>? children})
      : super(
          EmptyRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
          args: HomeRouteArgs(
            key: key,
            showFlushbar: showFlushbar,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<HomeRouteArgs> page = PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    this.showFlushbar = false,
  });

  final Key? key;

  final bool showFlushbar;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, showFlushbar: $showFlushbar}';
  }
}

/// generated route for
/// [HomeTabPage]
class HomeTab extends PageRouteInfo<void> {
  const HomeTab({List<PageRouteInfo>? children})
      : super(
          HomeTab.name,
          initialChildren: children,
        );

  static const String name = 'HomeTab';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginView]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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

  static const PageInfo<OTPPlatformVerificationRouteArgs> page =
      PageInfo<OTPPlatformVerificationRouteArgs>(name);
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
}

/// generated route for
/// [OTPVerificationView]
class OTPVerificationRoute extends PageRouteInfo<void> {
  const OTPVerificationRoute({List<PageRouteInfo>? children})
      : super(
          OTPVerificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'OTPVerificationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnboardingView]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PaymentRegistrationPage]
class PaymentRegistrationRoute
    extends PageRouteInfo<PaymentRegistrationRouteArgs> {
  PaymentRegistrationRoute({
    Key? key,
    required void Function() onSuccess,
    List<PageRouteInfo>? children,
  }) : super(
          PaymentRegistrationRoute.name,
          args: PaymentRegistrationRouteArgs(
            key: key,
            onSuccess: onSuccess,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentRegistrationRoute';

  static const PageInfo<PaymentRegistrationRouteArgs> page =
      PageInfo<PaymentRegistrationRouteArgs>(name);
}

class PaymentRegistrationRouteArgs {
  const PaymentRegistrationRouteArgs({
    this.key,
    required this.onSuccess,
  });

  final Key? key;

  final void Function() onSuccess;

  @override
  String toString() {
    return 'PaymentRegistrationRouteArgs{key: $key, onSuccess: $onSuccess}';
  }
}

/// generated route for
/// [PlatformRegistrationView]
class PlatformRegistrationRoute extends PageRouteInfo<void> {
  const PlatformRegistrationRoute({List<PageRouteInfo>? children})
      : super(
          PlatformRegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'PlatformRegistrationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PlatofrmTabPage]
class PlatformTab extends PageRouteInfo<void> {
  const PlatformTab({List<PageRouteInfo>? children})
      : super(
          PlatformTab.name,
          initialChildren: children,
        );

  static const String name = 'PlatformTab';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileTabPage]
class ProfileTab extends PageRouteInfo<ProfileTabArgs> {
  ProfileTab({
    required void Function() onPop,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileTab.name,
          args: ProfileTabArgs(
            onPop: onPop,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileTab';

  static const PageInfo<ProfileTabArgs> page = PageInfo<ProfileTabArgs>(name);
}

class ProfileTabArgs {
  const ProfileTabArgs({
    required this.onPop,
    this.key,
  });

  final void Function() onPop;

  final Key? key;

  @override
  String toString() {
    return 'ProfileTabArgs{onPop: $onPop, key: $key}';
  }
}

/// generated route for
/// [RegisterEmailView]
class RegisterEmailRoute extends PageRouteInfo<void> {
  const RegisterEmailRoute({List<PageRouteInfo>? children})
      : super(
          RegisterEmailRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterEmailRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterPasswordView]
class RegisterPasswordRoute extends PageRouteInfo<void> {
  const RegisterPasswordRoute({List<PageRouteInfo>? children})
      : super(
          RegisterPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterPasswordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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

  static const PageInfo<TicketSellerRouteArgs> page =
      PageInfo<TicketSellerRouteArgs>(name);
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
          args: TransferOrientationRouteArgs(
            key: key,
            platform: platform,
          ),
          initialChildren: children,
        );

  static const String name = 'TransferOrientationRoute';

  static const PageInfo<TransferOrientationRouteArgs> page =
      PageInfo<TransferOrientationRouteArgs>(name);
}

class TransferOrientationRouteArgs {
  const TransferOrientationRouteArgs({
    this.key,
    required this.platform,
  });

  final Key? key;

  final String platform;

  @override
  String toString() {
    return 'TransferOrientationRouteArgs{key: $key, platform: $platform}';
  }
}

/// generated route for
/// [WelcomePage]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
