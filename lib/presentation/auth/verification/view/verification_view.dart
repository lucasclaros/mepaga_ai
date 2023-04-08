import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/auth/verification/common/verification_header.dart';
import 'package:mepaga_ai/presentation/auth/verification/email/view/email_verification_view.dart';
import 'package:mepaga_ai/presentation/auth/verification/otp/view/otp_verification_view.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({
    super.key,
  });

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  bool _isButtonTermsSelected = false;
  bool _isEmailValid = false;

  @override
  Widget build(_) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return MPGScaffold(
      backgroundColor:
          ResponsiveLayout.isDesktop(context) ? const Color(0xFFF2F2F2) : null,
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const VerificationHeader(),
              StreamBuilder<bool>(
                stream: Stream.value(false),
                builder: (context, snapshot) {
                  return snapshot.data!
                      ? const OTPVerificationView(
                          userEmail: 'lucas.silva.c@hotmail.com',
                        )
                      : const EmailVerificationView();
                },
              ),
              StreamBuilder<bool>(
                stream: Stream.value(false),
                builder: (context, snapshot) {
                  return snapshot != null && snapshot.data!
                      ? Column(
                          children: [
                            SizedBox(height: context.responsiveHeight(70)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: context.responsiveHeight(50),
                              ),
                              child: MPGButton(
                                gradient:
                                    _isEmailValid && _isButtonTermsSelected
                                        ? null
                                        : LinearGradient(
                                            colors: [
                                              razzmatazz.withOpacity(0.4),
                                              amber.withOpacity(0.4),
                                            ],
                                          ),
                                child: Text(
                                  'Validar',
                                  style: _isEmailValid && _isButtonTermsSelected
                                      ? MPGTextStyles.of(context)
                                          .mpgColoredButton
                                      : MPGTextStyles.of(context)
                                          .mpgColoredButtonDisabled,
                                ),
                              ),
                            ),
                            SizedBox(height: context.responsiveHeight(30)),
                          ],
                        )
                      : const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
