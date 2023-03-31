import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/auth/verification/email_verification_page.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/onboarding/onboarding_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ResponsiveLayout(
          mobile: const OnboardingPage(),
          tablet: const OnboardingPage(),
          desktop: Row(
            children: const [
              Expanded(
                flex: 6,
                child: OnboardingPage(),
              ),
              Expanded(
                flex: 4,
                child: EmailVerificationPage(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
