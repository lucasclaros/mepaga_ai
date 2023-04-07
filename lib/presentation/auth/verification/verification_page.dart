import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/auth/verification/common/verification_header.dart';
import 'package:mepaga_ai/presentation/auth/verification/view/verification_view.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_checkbox.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key, required this.userEmail});

  final String userEmail;

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final padding = MediaQuery.of(context).viewPadding;
    // Height (without SafeArea)
    final deviceH = height - padding.top - padding.bottom;

    return ResponsiveLayout(
      mobile: MPGScaffold(
        backgroundColor:
            ResponsiveLayout.isDesktop(context) ? Color(0xFFF2F2F2) : null,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: deviceH,
              maxWidth: width,
            ),
            child: Column(
              children: <Widget>[
                const VerificationHeader(),
                // OTPVerificationView(userEmail: widget.userEmail),
                Column(
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
                          FractionallySizedBox(
                            widthFactor:
                                ResponsiveLayout.isDesktop(context) ? 0.75 : 1,
                            child: MPGTextField(
                              // focusNode: _emailFocusNode,
                              // controller: _emailController,
                              isPassword: false,
                              // hintText:
                              //     _emailFocusNode.hasFocus ? null : 'Email',
                              onChanged: (text) {
                                setState(() {
                                  // _isEmailValid =
                                  //     EmailValidator.validate(text);
                                });
                              },
                              onTap: () => setState(() {}),
                            ),
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
                                buttonColor: ResponsiveLayout.isDesktop(context)
                                    ? Colors.black
                                    : null,
                                checkColor: ResponsiveLayout.isDesktop(context)
                                    ? Colors.white
                                    : null,
                                onTap: (buttonStatus) {
                                  setState(() {
                                    // _isButtonTermsSelected = buttonStatus;
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
                                      style: ResponsiveLayout.isDesktop(context)
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
                  ],
                ),
                const Spacer(),
                MPGButton(
                  gradient: false
                      ? null
                      : LinearGradient(
                          colors: [
                            razzmatazz.withOpacity(0.4),
                            amber.withOpacity(0.4),
                          ],
                        ),
                  child: Text(
                    'Continuar',
                    style: false
                        ? MPGTextStyles.of(context).mpgColoredButton
                        : MPGTextStyles.of(context).mpgColoredButtonDisabled,
                  ),
                ),
                SizedBox(
                  height: context.responsiveHeight(73),
                ),
              ],
            ),
          ),
        ),
      ),
      desktop: Row(),
      tablet: VerificationView(context: context, userEmail: widget.userEmail),
    );
  }
}
