import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/data/cache/data_source/online_cds.dart';
import 'package:mepaga_ai/presentation/auth/login/view/login_view.dart';
import 'package:mepaga_ai/presentation/auth/otp_verification/view/otp_verification_view.dart';
import 'package:mepaga_ai/presentation/auth/register/email/view/register_email_view.dart';
import 'package:mepaga_ai/presentation/auth/register/password/view/register_password_view.dart';
import 'package:mepaga_ai/presentation/home/bottom_navbar.dart';
import 'package:mepaga_ai/presentation/onboarding/view/onboarding_view.dart';
import 'package:mepaga_ai/presentation/registration/add_email_platform/add_email_platform.dart';
import 'package:mepaga_ai/presentation/registration/otp_platform_verification/view/otp_platform_verification_view.dart';
import 'package:mepaga_ai/presentation/welcome/welcome_page.dart';
import 'package:provider/provider.dart';

const _homePage = '/home';
const _verificationPage = 'verification';
const _onboardingPage = 'onboarding';
const _registerEmailPage = 'register-email';
const _registerPassPage = 'register-pass';
const _loginPage = 'login';
const _logoutPage = 'logout';

const _registerEmailPath = '/$_onboardingPage/$_registerEmailPage';
const _registerPassPath = '$_registerEmailPath/$_registerPassPage';
const _signinVerificationPath = '$_registerPassPath/$_verificationPage';
const _platformVerificationPath = '$_homePage/$_verificationPage';
const _platformRegisterEmailPath = '$_homePage/$_registerEmailPage';
const _loginPath = '/$_onboardingPage/$_loginPage';
const _logoutPath = '/$_logoutPage';

class CustomNavigationHelper {
  factory CustomNavigationHelper() {
    return _instance;
  }

  CustomNavigationHelper._internal() {
    final routes = [
      GoRoute(
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
      GoRoute(
        path: _homePage,
        pageBuilder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>? ?? {};
          final showFlushbar = extraData['showFlushbar'] ?? false;
          return CustomSlideTransition(
            key: state.pageKey,
            child: BottomNavbar(showFlushbar: showFlushbar),
          );
        },
        routes: [
          GoRoute(
            path: _verificationPage,
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
            path: _registerEmailPage,
            pageBuilder: (context, state) {
              return CustomSlideTransition(
                key: state.pageKey,
                child: const AddEmailPlatform(),
              );
            },
          ),
        ],
      ),
    ];

    router = GoRouter(
      redirect: (context, state) async {
        final onlineCds = context.read<OnlineCDS>();
        final token = await onlineCds.getJWT();

        if (token != null) {
          return _homePage;
        }
        return null;
      },
      navigatorKey: parentNavigatorKey,
      initialLocation: '/',
      routes: routes,
    );
  }

  late GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }

  static final CustomNavigationHelper _instance =
      CustomNavigationHelper._internal();

  static CustomNavigationHelper get instance => _instance;
}

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
    String? email,
  }) =>
      go(
        _platformVerificationPath,
        extra: {
          'platform': platform,
          'email': email,
        },
      );

  void pushAddEmailPlatformPage() => go(_platformRegisterEmailPath);
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
                  CurveTween(curve: Curves.easeInOut),
                ),
              ),
              child: child,
            );
          },
        );
}
