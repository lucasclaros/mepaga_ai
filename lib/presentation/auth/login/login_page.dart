import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/auth/login/view/login_view.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: LoginView.create(),
      desktop: const Row(),
      tablet: LoginView.create(),
    );
  }
}
