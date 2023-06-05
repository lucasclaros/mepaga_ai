import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/auth/verification/email/view/email_verification_view.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/onboarding/view/onboarding_view.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: const OnboardingView(),
      desktop: Row(
        children: const [
          Expanded(
            flex: 6,
            child: OnboardingView(),
          ),
          Expanded(
            flex: 4,
            child: EmailVerificationView(),
          ),
        ],
      ),
      tablet: const OnboardingView(),
    );
  }
}
