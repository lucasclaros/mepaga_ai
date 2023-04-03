import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/presentation/auth/verification/view/email_verification_view.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/onboarding/onboarding_page.dart';
import 'package:mepaga_ai/presentation/welcome/welcome_page.dart';

const _homePage = '/';
const _verificationPage = 'verification';
const _onboardingPage = 'onboarding';

const _onboardingPath = _homePage + _onboardingPage;
const _verificationPath = _onboardingPath + _homePage + _verificationPage;

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
              path: _verificationPage,
              pageBuilder: (context, state) {
                return CustomSlideTransition(
                  key: state.pageKey,
                  child: const EmailVerificationView(),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: _verificationPage,
          builder: (context, state) => Container(),
        )
      ],
    ),
  ],
);

extension PageNavigationExtension on GoRouter {
  void pushEmailVerificationPage() => go(_verificationPath);

  void pushOnboardingPage() => go(_onboardingPath);
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
