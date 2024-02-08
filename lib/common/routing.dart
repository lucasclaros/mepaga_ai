import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/data/cache/data_source/online_cds.dart';
import 'package:mepaga_ai/presentation/auth/login/view/login_view.dart';
import 'package:mepaga_ai/presentation/auth/otp_verification/view/otp_verification_view.dart';
import 'package:mepaga_ai/presentation/auth/register/email/view/register_email_view.dart';
import 'package:mepaga_ai/presentation/auth/register/password/view/register_password_view.dart';
import 'package:mepaga_ai/presentation/home/bottom_navbar.dart';
import 'package:mepaga_ai/presentation/home/screens/home/home_page.dart';
import 'package:mepaga_ai/presentation/home/screens/profile/profile_page.dart';
import 'package:mepaga_ai/presentation/onboarding/view/onboarding_view.dart';
import 'package:mepaga_ai/presentation/registration/platform/add_email_platform/add_email_platform.dart';
import 'package:mepaga_ai/presentation/registration/platform/otp_platform_verification/view/otp_platform_verification_view.dart';
import 'package:mepaga_ai/presentation/registration/platform/platform_registration_view.dart';
import 'package:mepaga_ai/presentation/registration/tickets/transfer_orientation_page.dart';
import 'package:mepaga_ai/presentation/welcome/welcome_page.dart';
import 'package:provider/provider.dart';

// PATHS SHELLROUTE
const _homePage = '/home';
const _ticketPage = '/tickets';
const _profilePage = '/profile';
const _platformVerificationPage = '/verification-platform-email';
const _platformEmailOtpVerificationPage = '/verification-platform-email-otp';

const _verificationPage = 'verification';
const _onboardingPage = 'onboarding';
const _registerEmailPage = 'register-email';
const _registerPassPage = 'register-pass';
const _loginPage = 'login';
const _logoutPage = 'logout';
const _transferTicketPage = 'transfer-ticket';

const _registerEmailPath = '/$_onboardingPage/$_registerEmailPage';
const _registerPassPath = '$_registerEmailPath/$_registerPassPage';
const _signinVerificationPath = '$_registerPassPath/$_verificationPage';
const _platformRegisterEmailPath = '$_homePage/$_registerEmailPage';
const _loginPath = '/$_onboardingPage/$_loginPage';
const _logoutPath = '/$_logoutPage';
const _transferTicketPath = '$_ticketPage/$_transferTicketPage';

final GlobalKey<NavigatorState> parentNavigatorKey =
    GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> homeTabNavigatorKey =
    GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> ticketTabNavigatorKey =
    GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> profileTabNavigatorKey =
    GlobalKey<NavigatorState>();

final routes = [
  StatefulShellRoute.indexedStack(
    parentNavigatorKey: parentNavigatorKey,
    pageBuilder: (
      _,
      GoRouterState state,
      StatefulNavigationShell navigationShell,
    ) {
      final extraData = state.extra as Map<String, dynamic>? ?? {};
      final showFlushbar = extraData['showFlushbar'] ?? false;

      return CustomSlideTransition(
        child: BottomNavbar(
          showFlushbar: showFlushbar,
          child: navigationShell,
        ),
      );
    },
    branches: [
      StatefulShellBranch(
        navigatorKey: homeTabNavigatorKey,
        routes: [
          GoRoute(
            path: _homePage,
            pageBuilder: (_, state) {
              final extraData = state.extra as Map<String, dynamic>? ?? {};
              final showFlushbar = extraData['showFlushbar'] ?? false;

              return CustomSlideTransition(
                child: HomePage.create(
                  showFlushbar: showFlushbar,
                  triggerBottomSheet: (_) {},
                ),
              );
            },
            routes: [
              GoRoute(
                path: _verificationPage,
                pageBuilder: (_, state) {
                  final extraData = state.extra as Map<String, dynamic>? ?? {};
                  final platform = extraData['platform'] as String;
                  final email = extraData['email'] as String?;

                  return CustomSlideTransition(
                    key: state.pageKey,
                    child: OTPPlatformVerificationView.create(
                      platform: platform,
                      email: email,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: ticketTabNavigatorKey,
        routes: [
          GoRoute(
            path: _ticketPage,
            pageBuilder: (_, state) {
              return CustomSlideTransition(
                child: PlatformRegistrationView.create(),
              );
            },
            routes: [
              GoRoute(
                path: _transferTicketPage,
                pageBuilder: (_, state) {
                  final extraData = state.extra as Map<String, dynamic>? ?? {};
                  final platform = extraData['platform'] as String;

                  return CustomSlideTransition(
                    child: TransferOrientationPage(platform: platform),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: profileTabNavigatorKey,
        routes: [
          GoRoute(
            path: _profilePage,
            pageBuilder: (context, GoRouterState state) {
              return CustomSlideTransition(
                child: ProfilePage.create(),
              );
            },
          ),
        ],
      ),
    ],
  ),
  GoRoute(
    parentNavigatorKey: parentNavigatorKey,
    path: _platformVerificationPage,
    pageBuilder: (context, state) {
      final extraData = state.extra as Map<String, dynamic>? ?? {};
      final platform = extraData['platform'] as String;
      final onSuccess = extraData['onSuccess'] as Function(String email);

      return CustomSlideTransition(
        key: state.pageKey,
        child: AddEmailPlatform.create(
          platform: platform,
          onSuccess: onSuccess,
        ),
      );
    },
  ),
  GoRoute(
    parentNavigatorKey: parentNavigatorKey,
    path: _platformEmailOtpVerificationPage,
    pageBuilder: (context, state) {
      final extraData = state.extra as Map<String, dynamic>? ?? {};
      final platform = extraData['platform'] as String;
      final email = extraData['email'] as String?;

      return CustomSlideTransition(
        key: state.pageKey,
        child: OTPPlatformVerificationView.create(
          platform: platform,
          email: email,
        ),
      );
    },
  ),
  GoRoute(
    parentNavigatorKey: parentNavigatorKey,
    path: '/',
    builder: (context, state) => const WelcomePage(),
    routes: [
      GoRoute(
        path: _onboardingPage,
        pageBuilder: (context, state) {
          return CustomSlideTransition(
            key: state.pageKey,
            child: const OnboardingView(),
          );
        },
        routes: [
          GoRoute(
            path: _registerEmailPage,
            pageBuilder: (context, state) {
              return CustomSlideTransition(
                key: state.pageKey,
                child: const RegisterEmailView(),
              );
            },
            routes: [
              GoRoute(
                path: _registerPassPage,
                pageBuilder: (context, state) {
                  return CustomSlideTransition(
                    key: state.pageKey,
                    child: RegisterPasswordView.create(),
                  );
                },
                routes: [
                  GoRoute(
                    path: _verificationPage,
                    pageBuilder: (context, state) => CustomSlideTransition(
                      key: state.pageKey,
                      child: OTPVerificationView.create(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: _loginPage,
            pageBuilder: (context, state) {
              return CustomSlideTransition(
                key: state.pageKey,
                child: LoginView.create(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: _logoutPage,
        pageBuilder: (context, state) {
          return CustomSlideTransition(
            key: state.pageKey,
            child: LoginView.create(),
          );
        },
      ),
    ],
  ),
];

final router = GoRouter(
  redirect: (context, state) async {
    if (state.fullPath == '/') {
      final onlineCds = context.read<OnlineCDS>();
      final token = await onlineCds.getJWT();

      if (token != null) {
        return _homePage;
      }
    }
    return null;
  },
  navigatorKey: parentNavigatorKey,
  routes: routes,
);

extension PageNavigationExtension on GoRouter {
  void pushEmailVerificationPage() => go(_signinVerificationPath);

  void pushOnboardingPage() => go('/$_onboardingPage');

  void pushRegisterEmailPage() => go(_registerEmailPath);

  void pushRegisterPassPage() => go(_registerPassPath);

  void pushLoginPage() => go(_loginPath);

  void pushLogoutPage() => go(_logoutPath);

  void pushMPGHomePage({bool showFlushbar = false}) => go(
        _homePage,
        extra: {
          'showFlushbar': showFlushbar,
        },
      );

  void pushHomePage() => go(_homePage);

  void pushPlatformVerificationPage({
    required String platform,
    required Function(String email) onSuccess,
  }) =>
      push(
        _platformVerificationPage,
        extra: {
          'platform': platform,
          'onSuccess': onSuccess,
        },
      );

  void pushAddEmailPlatformPage() => push(_platformRegisterEmailPath);

  void pushPlatformEmailOtpVerificationPage({
    required String platform,
    String? email,
  }) =>
      push(
        _platformEmailOtpVerificationPage,
        extra: {'platform': platform, 'email': email},
      );

  void pushTransferOrientationPage({required String platform}) => push(
        _transferTicketPath,
        extra: {
          'platform': platform,
        },
      );
}

class CustomSlideTransition extends CustomTransitionPage<void> {
  CustomSlideTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 650),
          reverseTransitionDuration: const Duration(milliseconds: 650),
          transitionsBuilder: (_, animation, __, ___) {
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1.5, 0),
                  end: Offset.zero,
                ).chain(
                  CurveTween(
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
              child: child,
            );
          },
        );
}
