import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/presentation/auth/login/login_page.dart';
import 'package:mepaga_ai/presentation/auth/otp_verification/otp_verification_page.dart';
import 'package:mepaga_ai/presentation/auth/register/email/register_email_page.dart';
import 'package:mepaga_ai/presentation/auth/register/password/register_password_page.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/onboarding/onboarding_page.dart';
import 'package:mepaga_ai/presentation/welcome/welcome_page.dart';

const _homePage = '/';
const _verificationPage = 'verification';
const _onboardingPage = 'onboarding';
const _registerEmailPage = 'register-email';
const _registerPassPage = 'register-pass';
const _loginPage = 'login';

const _onboardingPath = _homePage + _onboardingPage;
const _registerEmailPath = _onboardingPath + _homePage + _registerEmailPage;
const _registerPassPath = _registerEmailPath + _homePage + _registerPassPage;
const _verificationPath = _registerPassPath + _homePage + _verificationPage;
const _loginPath = _onboardingPath + _homePage + _loginPage;

final routes = GoRouter(
  redirect: (context, state) {
    if (ResponsiveLayout.isDesktop(context)) {
      if (state.location == (_homePage + _verificationPage) ||
          state.location == _verificationPath) {
        return _onboardingPath;
      }
    }
    return null;
  },
  routes: [
    GoRoute(
      path: _homePage,
      builder: (context, state) => const WelcomePage(),
      routes: [
        GoRoute(
          path: _onboardingPage,
          pageBuilder: (context, state) {
            return CustomSlideTransition(
              key: state.pageKey,
              child: const OnboardingPage(),
            );
          },
          routes: [
            GoRoute(
              path: _registerEmailPage,
              pageBuilder: (context, state) {
                return CustomSlideTransition(
                  key: state.pageKey,
                  child: const RegisterEmailPage(),
                );
              },
              routes: [
                GoRoute(
                  path: _registerPassPage,
                  pageBuilder: (context, state) {
                    final extraData =
                        state.extra as Map<String, dynamic>? ?? {};
                    final userEmail = extraData['email'] ?? '';

                    return CustomSlideTransition(
                      key: state.pageKey,
                      child: RegisterPasswordPage(
                        userEmail: userEmail,
                      ),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: _verificationPage,
                      builder: (context, state) => const OTPVerificationPage(),
                    )
                  ],
                ),
              ],
            ),
            GoRoute(
              path: _loginPage,
              pageBuilder: (context, state) {
                return CustomSlideTransition(
                  key: state.pageKey,
                  child: const LoginPage(),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

extension PageNavigationExtension on GoRouter {
  void pushEmailVerificationPage() => go(_verificationPath);

  void pushOnboardingPage() => go(_onboardingPath);

  void pushRegisterEmailPage() => go(_registerEmailPath);

  void pushRegisterPassPage(String email) => go(
        _registerPassPath,
        extra: {'email': email},
      );

  void pushLoginPage() => go(_loginPath);
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
