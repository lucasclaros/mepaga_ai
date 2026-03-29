import 'dart:math';

import 'package:domain/use_cases/platform_register_uc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/registration/platform/add_email_platform/bloc/add_email_platform_bloc.dart';

class AddEmailPlatformView extends StatefulWidget {
  const AddEmailPlatformView({
    super.key,
    required this.platform,
    required this.onSuccess,
  });

  final String platform;
  final Function() onSuccess;

  @override
  State<AddEmailPlatformView> createState() => _AddEmailPlatformViewState();
}

class _AddEmailPlatformViewState extends State<AddEmailPlatformView> {
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();
  bool _isEmailValid = false;
  String? _emailErrorMessage;

  String? _emailErrorMessageMapper(String email) {
    if (!_isEmailValid && email.isNotEmpty) {
      return 'Email Inválido. Tente Novamente';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEmailPlatformBloc(
        platformRegisterUC: context.read<PlatformRegisterUC>(),
      ),
      child: MPGScaffold(
        child: BlocConsumer<AddEmailPlatformBloc, AddEmailPlatformState>(
          listener: (context, state) {
            if (state is SendEmailPlatformOtpError) {
              setState(() {
                _emailErrorMessage = 'E-mail não encontrado';
              });
            }

            if (state is SendEmailPlatformOtpSuccess) {
              context.push(
                '/platform-otp-verification',
                extra: {
                  'platform': widget.platform,
                  'email': _emailController.text,
                  'onSuccess': widget.onSuccess,
                },
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const MPGHeader(title: 'Vincule e-mail válido'),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Column(
                      children: [
                        SizedBox(height: 50.h),
                        Text(
                          'Insira um e-mail válido vinculado a plataforma:',
                          style: GoogleFonts.barlow(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          widget.platform.toUpperCase(),
                          style: GoogleFonts.barlow(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFF7C00),
                          ),
                        ),
                        SizedBox(height: 65.h),
                        MPGTextField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          isPassword: false,
                          hintText: 'E-mail',
                          errorText: _emailErrorMessage,
                          onEditingComplete: () {
                            _emailFocusNode.unfocus();
                            setState(() {
                              _emailErrorMessage = _emailErrorMessageMapper(
                                _emailController.text,
                              );
                            });
                          },
                          onChanged: (email) {
                            setState(() {
                              if (email.isEmpty) {
                                _isEmailValid = false;
                                _emailErrorMessage = null;
                              } else {
                                _isEmailValid = EmailValidator.validate(email);
                              }
                            });
                          },
                        ),
                        SizedBox(height: min(200, 200.h)),
                        MPGButton(
                          onPressed: _isEmailValid
                              ? () {
                                  context.read<AddEmailPlatformBloc>().add(
                                        SendEmailPlatformOtp(
                                          email: _emailController.text,
                                          platform: widget.platform,
                                        ),
                                      );
                                }
                              : null,
                          gradient: _isEmailValid
                              ? null
                              : MPGColors.of(context)
                                  .mpgButtonColoredGradientDisabled,
                          isLoading: state is SendEmailPlatformOtpLoading,
                          child: Text(
                            'Continuar',
                            style: _isEmailValid
                                ? MPGTextStyles.of(context).mpgColoredButton
                                : MPGTextStyles.of(context)
                                    .mpgColoredButtonDisabled,
                          ),
                        ),
                        SizedBox(height: 80.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
