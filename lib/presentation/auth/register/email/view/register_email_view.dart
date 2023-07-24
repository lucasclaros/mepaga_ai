// ignore_for_file: lines_longer_than_80_chars, use_decorated_box

import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/common/routing.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:mepaga_ai/presentation/auth/register/email/widgets/modal_info.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:styled_text/styled_text.dart';

class RegisterEmailView extends StatefulWidget {
  const RegisterEmailView({super.key});

  static Widget create() => const RegisterEmailView();

  @override
  State<RegisterEmailView> createState() => RegisterEmailViewState();
}

class RegisterEmailViewState extends State<RegisterEmailView> {
  bool _isEmailValid = false;
  String? _errorMessage;
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  String? _errorMessageMapper(String email) {
    if (!_isEmailValid && email.isNotEmpty) {
      return 'Email Inválido. Tente Novamente';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - kToolbarHeight;

    return MPGScaffold(
      child: SizedBox(
        height: max(height, 812),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MPGHeader(title: 'Crie sua conta'),
              SizedBox(height: context.responsiveHeight(75)),
              SizedBox(
                width: context.responsiveWidth(300),
                child: StyledText(
                  text: 'Insira o seu e-mail de preferência.\n\n'
                      'Para facilitar sua vida, ele poderá ser usado para validar '
                      'sua conta em aplicativos de eventos. <doubt/>',
                  tags: {
                    'doubt': StyledTextWidgetTag(
                      const ModalInfo(),
                      size: Size.square(min(context.responsiveWidth(25), 25)),
                    ),
                  },
                  style: GoogleFonts.barlow(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: context.responsiveHeight(40)),
              MPGTextField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                isPassword: false,
                hintText: 'E-mail',
                errorText: _errorMessage,
                onEditingComplete: () {
                  _emailFocusNode.unfocus();
                  setState(() {
                    _errorMessage = _errorMessageMapper(
                      _emailController.text,
                    );
                  });
                },
                onChanged: (email) {
                  setState(() {
                    if (email.isEmpty) {
                      _isEmailValid = false;
                      _errorMessage = null;
                    } else {
                      _isEmailValid = EmailValidator.validate(email);
                    }
                  });
                },
              ),
              SizedBox(height: context.responsiveHeight(160)),
              MPGButton(
                onPressed: _isEmailValid
                    ? () {
                        UserMM().email = _emailController.text;
                        GoRouter.of(context)
                            .pushRegisterPassPage(_emailController.text);
                      }
                    : null,
                gradient: _isEmailValid
                    ? null
                    : MPGColors.of(context).mpgButtonColoredGradientDisabled,
                child: Text(
                  'Continuar',
                  style: _isEmailValid
                      ? MPGTextStyles.of(context).mpgColoredButton
                      : MPGTextStyles.of(context).mpgColoredButtonDisabled,
                ),
              ),
              SizedBox(height: context.responsiveHeight(40)),
            ],
          ),
        ),
      ),
    );
  }
}
