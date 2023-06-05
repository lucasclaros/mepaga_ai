import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static Widget create() => const LoginView();

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return MPGScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const MPGHeader(
              title: 'Bem-vindo!',
            ),
            SizedBox(
              height: context.responsiveHeight(90),
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: MPGTextField(
                labelText: 'Digite seu email',
                hintText: 'Email',
                isPassword: false,
                controller: _emailController,
                focusNode: _emailFocusNode,
              ),
            ),
            SizedBox(
              height: context.responsiveHeight(43),
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: MPGTextField(
                labelText: 'Digite sua senha',
                hintText: 'Senha',
                isPassword: true,
                controller: _passwordController,
                focusNode: _passwordFocusNode,
              ),
            ),
            SizedBox(
              height: context.responsiveHeight(190),
            ),
            MPGButton(
              gradient: MPGColors.of(context).mpgButtonColoredGradientDisabled,
              child: Text(
                'Login',
                style: false
                    ? MPGTextStyles.of(context).mpgColoredButton
                    : MPGTextStyles.of(context).mpgColoredButtonDisabled,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
