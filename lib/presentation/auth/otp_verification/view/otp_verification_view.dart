// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_size_text/auto_size_text.dart';
import 'package:domain/use_cases/cache_jwt_uc.dart';
import 'package:domain/use_cases/otp_verification_uc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/common/routing.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:mepaga_ai/presentation/auth/otp_verification/bloc/otp_verification_bloc.dart';
import 'package:mepaga_ai/presentation/auth/otp_verification/widgets/mpg_otp_textfield.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';

class OTPVerificationView extends StatefulWidget {
  const OTPVerificationView({
    super.key,
  });

  static Widget create() => BlocProvider<OtpVerificationBloc>(
        create: (context) {
          return OtpVerificationBloc(
            cacheJwtUC: context.read<CacheJwtUC>(),
            otpVerificationUC: context.read<OTPVerificationUC>(),
          );
        },
        child: const OTPVerificationView(),
      );

  @override
  State<OTPVerificationView> createState() => _OTPVerificationViewState();
}

class _OTPVerificationViewState extends State<OTPVerificationView> {
  final _otpController = TextEditingController();
  final _otpFocusNode = FocusNode();
  bool _isLoading = false;
  bool _isShowingFlushbar = false;

  @override
  void dispose() {
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpVerificationBloc, OtpVerificationState>(
      listener: (context, state) {
        setState(() {
          _isLoading = state is OtpVerificationLoading;
        });

        if (state is OtpVerificationError && !_isShowingFlushbar) {
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

        if (state is OtpVerificationSuccess) {
          GoRouter.of(context).pushStartPage(showFlushbar: true);
        }
      },
      builder: (context, state) {
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
                              style: MPGTextStyles.of(context)
                                  .otpVerifcationUserEmail,
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
                            SizedBox(
                              height: context.responsiveHeight(85),
                            ),
                            MPGOtpTextField(
                              textController: _otpController,
                              focusNode: _otpFocusNode,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: context.responsiveHeight(100),
                  child: MPGButton(
                    onPressed: () {
                      context.read<OtpVerificationBloc>().add(
                            OtpVerificationSend(
                              email: UserMM().email,
                              code: _otpController.text,
                            ),
                          );
                    },
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                        : Text(
                            'Continuar',
                            style: MPGTextStyles.of(context).mpgColoredButton,
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
