import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/presentation/home/home_page.dart';
import 'package:mepaga_ai/presentation/onboarding/onboarding_page.dart';
import 'package:mepaga_ai/presentation/welcome/welcome_page.dart';

const _homePage = '/';
const _otpPage = 'otp';
const _onboardingPage = 'onboarding';

const _otpPath = _homePage + _otpPage;
const _onboardingPath = _homePage + _onboardingPage;

final routes = GoRouter(
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
        )
      ],
    ),
  ],
);

extension PageNavigationExtension on GoRouter {
  void pushOTPPage() => go(_otpPath);

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
