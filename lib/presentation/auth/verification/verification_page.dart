import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/auth/verification/view/verification_view.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: VerificationView.create(),
      desktop: Row(),
      tablet: VerificationView.create(),
    );
  }
}
