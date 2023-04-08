import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/auth/verification/otp/widgets/mpg_otp_textfield.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class OTPVerificationView extends StatefulWidget {
  const OTPVerificationView({
    super.key,
    required this.userEmail,
  });

  final String userEmail;

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
    return Column(
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
                'Insira abaixo o código enviado para:\n',
                style: MPGTextStyles.of(context).onboardingHintDescription,
                textAlign: TextAlign.center,
              ),
              AutoSizeText(
                widget.userEmail,
                style: MPGTextStyles.of(context).otpVerifcationUserEmail,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: context.responsiveHeight(85),
              ),
              FractionallySizedBox(
                widthFactor: ResponsiveLayout.isDesktop(context) ? 0.75 : 1,
                child: const MPGOtpTextField(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
