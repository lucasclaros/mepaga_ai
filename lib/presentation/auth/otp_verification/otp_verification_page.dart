import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/auth/otp_verification/view/otp_verification_view.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({super.key});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: OTPVerificationView.create(),
      desktop: const Row(),
      tablet: OTPVerificationView.create(),
    );
  }
}
