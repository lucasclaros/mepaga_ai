import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/auth/register/view/register_view.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: RegisterView.create(),
      desktop: Row(),
      tablet: RegisterView.create(),
    );
  }
}
