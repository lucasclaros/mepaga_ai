// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_size_text/auto_size_text.dart';
import 'package:domain/use_cases/cache_jwt_uc.dart';
import 'package:domain/use_cases/otp_verification_uc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:mepaga_ai/presentation/auth/otp_verification/bloc/otp_verification_bloc.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_otp_textfield.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';

class OTPVerificationView extends StatefulWidget {
  const OTPVerificationView({
    super.key,
  });

  @override
  State<OTPVerificationView> createState() => _OTPVerificationViewState();
}

class _OTPVerificationViewState extends State<OTPVerificationView> {
  final _otpController = TextEditingController();
  final _otpFocusNode = FocusNode();
  bool _isLoading = false;
  bool _isShowingFlushbar = false;
  String? errorMessage;

  @override
  void dispose() {
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OtpVerificationBloc>(
      create: (context) => OtpVerificationBloc(
        cacheJwtUC: context.read<CacheJwtUC>(),
        otpVerificationUC: context.read<OTPVerificationUC>(),
      ),
      child: BlocConsumer<OtpVerificationBloc, OtpVerificationState>(
        listener: (context, state) {
          setState(() {
            _isLoading = state is OtpVerificationLoading;
          });

          if (state is OtpVerificationError && !_isShowingFlushbar) {
            if (state is OtpVerificationInvalidOtp ||
                state is OtpVerificationOTPExpired) {
              setState(() {
                errorMessage = state.message;
              });
            } else {
              setState(() {
                _isShowingFlushbar = true;
              });

              showFlushbar(
                context: context,
                title: 'Ops... Ocorreu um erro!',
                message: state.message,
                fontColor: Colors.white,
                backgroundColor: Colors.red,
                thenFunction: () {
                  setState(() {
                    _isShowingFlushbar = false;
                  });
                },
              );
            }
          }

          if (state is OtpVerificationSuccess) {
            context.go('/', extra: true);
          }
        },
        builder: (context, state) {
          return MPGScaffold(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      const MPGHeader(title: 'Verificação de Email'),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 35.w,
                          vertical: 20.h,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 50.h),
                            AutoSizeText(
                              'Insira abaixo o código enviado para:\n',
                              style: MPGTextStyles.of(context)
                                  .onboardingHintDescription,
                              textAlign: TextAlign.center,
                            ),
                            AutoSizeText(
                              UserMM().email,
                              style: MPGTextStyles.of(context)
                                  .otpVerifcationUserEmail,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 28.h),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Não recebeu o email? ',
                                    style: MPGTextStyles.of(context)
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
                            SizedBox(height: 85.h),
                            MPGOtpTextField(
                              textController: _otpController,
                              focusNode: _otpFocusNode,
                              onValidate: () {
                                context.read<OtpVerificationBloc>().add(
                                      OtpVerificationSend(
                                        email: UserMM().email,
                                        code: _otpController.text,
                                      ),
                                    );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100.h),
                  MPGButton(
                    onPressed: () {
                      context.read<OtpVerificationBloc>().add(
                            OtpVerificationSend(
                              email: UserMM().email,
                              code: _otpController.text,
                            ),
                          );
                    },
                    isLoading: _isLoading,
                    child: Text(
                      'Validar',
                      style: MPGTextStyles.of(context).mpgColoredButton,
                    ),
                  ),
                  SizedBox(height: 45.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
