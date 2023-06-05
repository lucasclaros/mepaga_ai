import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/auth/register/email/view/register_email_view.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';

class RegisterEmailPage extends StatefulWidget {
  const RegisterEmailPage({super.key});

  @override
  State<RegisterEmailPage> createState() => _RegisterEmailPageState();
}

class _RegisterEmailPageState extends State<RegisterEmailPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: RegisterEmailView.create(),
      desktop: Row(),
      tablet: RegisterEmailView.create(),
    );
  }
}
