import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/data/cache/data_source/online_cds.dart';
import 'package:mepaga_ai/presentation/auth/login/view/login_view.dart';
import 'package:mepaga_ai/presentation/auth/otp_verification/view/otp_verification_view.dart';
import 'package:mepaga_ai/presentation/auth/register/email/view/register_email_view.dart';
import 'package:mepaga_ai/presentation/auth/register/password/view/register_password_view.dart';
import 'package:mepaga_ai/presentation/home/bottom_navbar.dart';
import 'package:mepaga_ai/presentation/onboarding/view/onboarding_view.dart';
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
const _verificationPath = '$_registerPassPath/$_verificationPage';
const _loginPath = '/$_onboardingPage/$_loginPage';
const _logoutPath = '/$_logoutPage';

final routes = GoRouter(
  redirect: (context, state) async {
    final onlineCds = context.read<OnlineCDS>();
    final token = await onlineCds.getJWT();

    if (token != null) {
      return _homePage;
    }
    return null;
  },
  routes: [
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
    ),
  ],
);

extension PageNavigationExtension on GoRouter {
  void pushEmailVerificationPage() => go(_verificationPath);

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
