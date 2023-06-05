// ignore_for_file: lines_longer_than_80_chars, use_decorated_box

import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_checkbox.dart';
import 'package:mepaga_ai/presentation/common/mpg_confirmation_check.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class RegisterPasswordView extends StatefulWidget {
  const RegisterPasswordView({
    super.key,
    required this.userEmail,
  });

  final String userEmail;

  static Widget create(String userEmail) => RegisterPasswordView(
        userEmail: userEmail,
      );

  @override
  State<RegisterPasswordView> createState() => RegisterPasswordViewState();
}

class RegisterPasswordViewState extends State<RegisterPasswordView> {
  bool _isTermsSelected = false;
  bool _minimunCharPass = false;
  bool _specialCharPass = false;
  String? _errorMessage;
  final _passController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _confirmPassController = TextEditingController();
  final _confirmPassFocusNode = FocusNode();

  bool checkMiniminChar(String pass) {
    if (pass.length >= 8) {
      return true;
    }
    return false;
  }

  bool checkSpecialChar(String pass) {
    if (_minimunCharPass && pass.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return true;
    }
    return false;
  }

  String? confirmPass(String confirmPass) {
    if (confirmPass.isNotEmpty && _passController.text == confirmPass) {
      return null;
    }
    return 'As senhas não coincidem';
  }

  @override
  Widget build(BuildContext context) {
    return MPGScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const MPGHeader(title: 'Defina sua senha'),
            SizedBox(height: context.responsiveHeight(20)),
            MPGConfirmationCheck(
              content: Text(
                '8 caracteres no mínimo ',
                style: GoogleFonts.barlow(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              isSelected: _minimunCharPass,
            ),
            MPGConfirmationCheck(
              content: Text(
                r'Caractere especial (@, !, $, ...)',
                style: GoogleFonts.barlow(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              isSelected: _specialCharPass,
            ),
            SizedBox(height: context.responsiveHeight(25)),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: MPGTextField(
                labelText: 'Digite sua senha',
                textInputAction: TextInputAction.next,
                controller: _passController,
                focusNode: _passFocusNode,
                isPassword: true,
                hintText: 'Senha',
                onChanged: (pass) {
                  setState(() {
                    _minimunCharPass = checkMiniminChar(pass);
                    _specialCharPass = checkSpecialChar(pass);
                    if (_confirmPassController.text.isNotEmpty) {
                      _errorMessage = confirmPass(_confirmPassController.text);
                    }
                  });
                },
              ),
            ),
            SizedBox(height: context.responsiveHeight(30)),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: MPGTextField(
                labelText: 'Confirme sua senha',
                controller: _confirmPassController,
                focusNode: _confirmPassFocusNode,
                isPassword: true,
                hintText: 'Senha',
                errorText: _errorMessage,
                onChanged: (pass) {
                  setState(() {
                    _errorMessage = confirmPass(pass);
                  });
                },
              ),
            ),
            SizedBox(height: context.responsiveHeight(30)),
            MPGConfirmationCheck(
              onTap: () {
                setState(() {
                  _isTermsSelected = !_isTermsSelected;
                });
              },
              isSelected: _isTermsSelected,
              content: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Li e estou de acordo com todos os ',
                      style: MPGTextStyles.of(context)
                          .policyNormalDescriptionMobile,
                    ),
                    TextSpan(
                      text: 'Termos e Políticas',
                      style: MPGTextStyles.of(context).policyColoredDescription,
                      // TODO(Lucas Claros): Adicionar link para o termos e políticas
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: context.responsiveHeight(40)),
            MPGButton(
              onPressed: () {},
              gradient: _minimunCharPass &&
                      _specialCharPass &&
                      _isTermsSelected &&
                      _errorMessage == null
                  ? null
                  : MPGColors.of(context).mpgButtonColoredGradientDisabled,
              child: Text(
                'Continuar',
                style: _minimunCharPass &&
                        _specialCharPass &&
                        _isTermsSelected &&
                        _errorMessage == null
                    ? MPGTextStyles.of(context).mpgColoredButton
                    : MPGTextStyles.of(context).mpgColoredButtonDisabled,
              ),
            ),
            SizedBox(height: context.responsiveHeight(40)),
          ],
        ),
      ),
    );
  }
}
