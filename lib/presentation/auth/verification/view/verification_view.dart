import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/auth/verification/common/verification_header.dart';
import 'package:mepaga_ai/presentation/auth/verification/email/view/email_verification_view.dart';
import 'package:mepaga_ai/presentation/auth/verification/otp/view/otp_verification_view.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_checkbox.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:responsive_styles/responsive_styles.dart';

class VerificationView extends StatefulWidget {
  const VerificationView(
      {super.key, required this.userEmail, required this.context});

  final String userEmail;
  final BuildContext context;

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  @override
  Widget build(_) {
    final width = MediaQuery.of(widget.context).size.width;
    final height = MediaQuery.of(widget.context).size.height;
    final padding = MediaQuery.of(widget.context).viewPadding;
    // Height (without SafeArea)
    final deviceH = height - padding.top - padding.bottom;

    return MPGScaffold(
      backgroundColor:
          ResponsiveLayout.isDesktop(widget.context) ? Color(0xFFF2F2F2) : null,
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: height,
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
                      horizontal: widget.context.responsiveWidth(35),
                      vertical: widget.context.responsiveHeight(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: widget.context.responsiveHeight(75),
                        ),
                        AutoSizeText(
                          'Insira o e-mail associado à sua conta Byma.\n\n'
                          'Um código de confirmação será enviado para validação.',
                          style: ResponsiveLayout.isDesktop(widget.context)
                              ? GoogleFonts.barlow(
                                  color: Colors.black,
                                  fontSize: 18,
                                )
                              : MPGTextStyles.of(widget.context)
                                  .onboardingHintDescription,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: widget.context.responsiveHeight(85),
                        ),
                        FractionallySizedBox(
                          widthFactor:
                              ResponsiveLayout.isDesktop(widget.context)
                                  ? 0.75
                                  : 1,
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
                      horizontal: widget.context.responsiveWidth(
                        ResponsiveLayout.isDesktop(widget.context) ? 40 : 10,
                      ),
                      vertical: widget.context.responsiveWidth(
                        ResponsiveLayout.isDesktop(widget.context) ? 16 : 40,
                      ),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(widget.context).size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: MPGCheckbox(
                              buttonColor:
                                  ResponsiveLayout.isDesktop(widget.context)
                                      ? Colors.black
                                      : null,
                              checkColor:
                                  ResponsiveLayout.isDesktop(widget.context)
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
                                    text: 'Li e estou de acordo com todos os ',
                                    style: ResponsiveLayout.isDesktop(
                                            widget.context)
                                        ? GoogleFonts.barlow(
                                            color: Colors.black,
                                            fontSize: 18,
                                          )
                                        : MPGTextStyles.of(widget.context)
                                            .policyNormalDescription,
                                  ),
                                  TextSpan(
                                    text: 'Termos e Políticas',
                                    style: MPGTextStyles.of(widget.context)
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
                      ? MPGTextStyles.of(widget.context).mpgColoredButton
                      : MPGTextStyles.of(widget.context)
                          .mpgColoredButtonDisabled,
                ),
              ),
              SizedBox(
                height: widget.context.responsiveHeight(73),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
