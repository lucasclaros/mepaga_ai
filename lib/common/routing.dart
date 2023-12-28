import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/data/cache/data_source/online_cds.dart';
import 'package:mepaga_ai/presentation/auth/login/login_page.dart';
import 'package:mepaga_ai/presentation/auth/otp_verification/otp_verification_page.dart';
import 'package:mepaga_ai/presentation/auth/register/email/register_email_page.dart';
import 'package:mepaga_ai/presentation/auth/register/password/register_password_page.dart';
import 'package:mepaga_ai/presentation/home/home_page.dart';
import 'package:mepaga_ai/presentation/onboarding/view/onboarding_view.dart';
import 'package:mepaga_ai/presentation/welcome/welcome_page.dart';
import 'package:provider/provider.dart';

const _homePage = '/';
const _verificationPage = 'verification';
const _onboardingPage = 'onboarding';
const _registerEmailPage = 'register-email';
const _registerPassPage = 'register-pass';
const _loginPage = 'login';
const _startPage = 'start';

const _onboardingPath = _homePage + _onboardingPage;
const _registerEmailPath = _onboardingPath + _homePage + _registerEmailPage;
const _registerPassPath = _registerEmailPath + _homePage + _registerPassPage;
const _verificationPath = _registerPassPath + _homePage + _verificationPage;
const _loginPath = _onboardingPath + _homePage + _loginPage;
const _startPath = _homePage + _startPage;

final routes = GoRouter(
  redirect: (context, state) async {
    final onlineCds = context.read<OnlineCDS>();
    final token = await onlineCds.getJWT();

    if (token != null) {
      return _startPath;
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
              child: const OnboardingView(),
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
                      pageBuilder: (context, state) => CustomSlideTransition(
                        key: state.pageKey,
                        child: const OTPVerificationPage(),
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
                  child: const LoginPage(),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: _startPage,
          pageBuilder: (context, state) {
            final extraData = state.extra as Map<String, dynamic>? ?? {};
            final showFlushbar = extraData['showFlushbar'] ?? false;
            return CustomSlideTransition(
              key: state.pageKey,
              child: HomePage.create(showFlushbar: showFlushbar),
            );
          },
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

  void pushStartPage({bool showFlushbar = false}) => go(
        _startPath,
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
