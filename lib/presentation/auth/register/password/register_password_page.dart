import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/auth/register/password/view/register_password_view.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';

class RegisterPasswordPage extends StatefulWidget {
  const RegisterPasswordPage({
    super.key,
    required this.userEmail,
  });

  final String userEmail;

  @override
  State<RegisterPasswordPage> createState() => _RegisterPasswordPageState();
}

class _RegisterPasswordPageState extends State<RegisterPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: RegisterPasswordView.create(widget.userEmail),
      desktop: const Row(),
      tablet: RegisterPasswordView.create(widget.userEmail),
    );
  }
}
