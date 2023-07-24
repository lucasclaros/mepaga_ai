// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:mepaga_ai/presentation/auth/otp_verification/widgets/mpg_otp_textfield.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class OTPVerificationView extends StatefulWidget {
  const OTPVerificationView({
    super.key,
  });

  static Widget create() => const OTPVerificationView();

  @override
  State<OTPVerificationView> createState() => _OTPVerificationViewState();
}

class _OTPVerificationViewState extends State<OTPVerificationView> {
  final _otpController = TextEditingController();
  final _otpFocusNode = FocusNode();

  @override
  void dispose() {
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MPGScaffold(
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const MPGHeader(title: 'Verificação de Email'),
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
                          'Insira abaixo o código enviado para:\n',
                          style: MPGTextStyles.of(context)
                              .onboardingHintDescription,
                          textAlign: TextAlign.center,
                        ),
                        AutoSizeText(
                          UserMM().email,
                          style:
                              MPGTextStyles.of(context).otpVerifcationUserEmail,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: context.responsiveHeight(28),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Não recebeu o email? ',
                                style: ResponsiveLayout.isDesktop(context)
                                    ? MPGTextStyles.of(context)
                                        .policyNormalDescriptionWeb
                                    : MPGTextStyles.of(context)
                                        .policyNormalDescriptionMobile,
                              ),
                              TextSpan(
                                text: 'Reenviar código',
                                style: MPGTextStyles.of(context)
                                    .policyColoredDescription,
                                // TODO(Lucas Claros): Adicionar link para reenviar código
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: context.responsiveHeight(85),
                        ),
                        const MPGOtpTextField(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: context.responsiveHeight(100),
              child: MPGButton(
                onPressed: () {},
                child: Text(
                  'Continuar',
                  style: MPGTextStyles.of(context).mpgColoredButton,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
