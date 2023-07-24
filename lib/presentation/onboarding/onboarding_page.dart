import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/onboarding/view/onboarding_view.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile: OnboardingView(),
      desktop: SizedBox.shrink(),
      tablet: OnboardingView(),
    );
  }
}
