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
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
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
    return GestureDetector(
      onTap: () => setState(_emailFocusNode.unfocus),
      child: MPGScaffold(
        backgroundColor:
            ResponsiveLayout.isDesktop(context) ? Color(0xFFECEFF1) : null,
        child: Stack(
          children: [
            Center(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.responsiveWidth(35),
                          vertical: context.responsiveHeight(20),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: context.responsiveHeight(41),
                            ),
                            AutoSizeText(
                              'Verificação de email',
                              style: ResponsiveLayout.isDesktop(context)
                                  ? GoogleFonts.barlow(
                                      color: Colors.black,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w500,
                                    )
                                  : MPGTextStyles.of(context)
                                      .emailVerificationTitle,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: context.responsiveHeight(75),
                            ),
                            AutoSizeText(
                              'Insira o e-mail associado à sua conta Byma.\n\n'
                              'Um código de confirmação será enviado para validação.',
                              style: ResponsiveLayout.isDesktop(context)
                                  ? GoogleFonts.barlow(
                                      color: Colors.black,
                                      fontSize: 18,
                                    )
                                  : MPGTextStyles.of(context)
                                      .onboardingHintDescription,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: context.responsiveHeight(85),
                            ),
                            MPGTextField(
                              focusNode: _emailFocusNode,
                              controller: _emailController,
                              isPassword: false,
                              hintText:
                                  _emailFocusNode.hasFocus ? null : 'Email',
                              onChanged: (text) {
                                setState(() {
                                  _isEmailValid = EmailValidator.validate(text);
                                });
                              },
                              onTap: () => setState(() {}),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.responsiveWidth(
                            ResponsiveLayout.isDesktop(context) ? 40 : 10,
                          ),
                          vertical: context.responsiveWidth(
                            ResponsiveLayout.isDesktop(context) ? 16 : 40,
                          ),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Expanded(
                                child: MPGCheckbox(
                                  buttonColor:
                                      ResponsiveLayout.isDesktop(context)
                                          ? Colors.black
                                          : null,
                                  checkColor:
                                      ResponsiveLayout.isDesktop(context)
                                          ? Colors.white
                                          : null,
                                  onTap: (buttonStatus) {
                                    setState(() {
                                      _isButtonTermsSelected = buttonStatus;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            'Li e estou de acordo com todos os ',
                                        style:
                                            ResponsiveLayout.isDesktop(context)
                                                ? GoogleFonts.barlow(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                  )
                                                : MPGTextStyles.of(context)
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
                              : MPGTextStyles.of(context)
                                  .mpgColoredButtonDisabled,
                        ),
                      ),
                      SizedBox(height: context.responsiveHeight(40)),
                    ],
                  ),
                ),
              ),
            ),
            if (!ResponsiveLayout.isDesktop(context))
              Positioned(
                top: 0,
                child: GestureDetector(
                  onTap: () => GoRouter.of(context).pop(),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(
                      vertical: context.responsiveHeight(16),
                      horizontal: context.responsiveWidth(18),
                    ),
                    child: SvgPicture.asset(
                      MPGAssetsPaths.of(context).backButton,
                      width: 24,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
