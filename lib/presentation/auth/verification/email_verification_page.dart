// ignore_for_file: flutter_style_todos, lines_longer_than_80_chars

import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_checkbox.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();
  bool _isButtonTermsSelected = false;
  bool _isEmailValid = false;

  @override
  Widget build(BuildContext context) {
    return MPGScaffold(
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => GoRouter.of(context).pop(),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      top: context.responsiveHeight(16),
                      left: context.responsiveWidth(24),
                    ),
                    child: SvgPicture.asset(
                      MPGAssetsPaths.of(context).backButton,
                      width: 24,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveWidth(35),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: context.responsiveHeight(41),
                      ),
                      AutoSizeText(
                        'Verificação de email',
                        style: MPGTextStyles.of(context).emailVerificationTitle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: context.responsiveHeight(75),
                      ),
                      AutoSizeText(
                        'Insira o e-mail associado à sua conta Byma.\n\n'
                        'Um código de confirmação será enviado para validação.',
                        style: MPGTextStyles.of(context)
                            .emailVerificationDescription,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: context.responsiveHeight(85),
                      ),
                      MPGTextField(
                        focusNode: _emailFocusNode,
                        controller: _emailController,
                        isPassword: false,
                        hintText: 'Email',
                        onChanged: (text) {
                          setState(() {
                            _isEmailValid = EmailValidator.validate(text);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: context.responsiveHeight(34),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveWidth(52),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: MPGCheckbox(
                          onTap: (buttonStatus) {
                            setState(() {
                              _isButtonTermsSelected = buttonStatus;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        flex: 4,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Li e estou de acordo com todos os ',
                                style: MPGTextStyles.of(context)
                                    .policyNormalDescription,
                              ),
                              TextSpan(
                                text: 'Termos e Políticas',
                                style: MPGTextStyles.of(context)
                                    .policyColoredDescription,
                                // TODO(Lucas Claros): Adicionar link para o termos e políticas
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: context.responsiveHeight(120),
                ),
                MPGButton(
                  gradient: _isEmailValid && _isButtonTermsSelected
                      ? null
                      : LinearGradient(
                          colors: [
                            razzmatazz.withOpacity(0.4),
                            amber.withOpacity(0.4),
                          ],
                        ),
                  child: Text(
                    'Continuar',
                    style: _isEmailValid && _isButtonTermsSelected
                        ? MPGTextStyles.of(context).mpgColoredButton
                        : MPGTextStyles.of(context).mpgColoredButtonDisabled,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
