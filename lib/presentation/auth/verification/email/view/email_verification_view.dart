// ignore_for_file: flutter_style_todos, lines_longer_than_80_chars

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/auth/verification/email/bloc/button_status_bloc.dart';
import 'package:mepaga_ai/presentation/auth/verification/view/bloc/verification_bloc.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_checkbox.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({
    super.key,
  });

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  late ButtonStatusBloc _buttonBloc;
  late VerificationBloc _verificationBloc;

  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();
  bool _isButtonTermsSelected = false;

  String? _errorMessageMapper(VerificationState state) {
    if (state is InvalidEmail) {
      return 'Email Inválido';
    } else if (state is Error) {
      return 'Ocorreu um erro. Tente Novamente.';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    _buttonBloc = BlocProvider.of<ButtonStatusBloc>(context);
    _verificationBloc = BlocProvider.of<VerificationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => setState(_emailFocusNode.unfocus),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
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
                      if (ResponsiveLayout.isDesktop(context))
                        const MPGHeader(
                          title: 'Verificação de email',
                        ),
                      SizedBox(
                        height: context.responsiveHeight(75),
                      ),
                      AutoSizeText(
                        'Insira o e-mail associado à sua conta Byma.\n\n'
                        'Um código de confirmação será enviado para validação.',
                        style: ResponsiveLayout.isDesktop(context)
                            ? MPGTextStyles.of(context)
                                .emailVerificationDescriptionWeb
                            : MPGTextStyles.of(context)
                                .emailVerificationDescriptionMobile,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: context.responsiveHeight(85),
                      ),
                      BlocBuilder<VerificationBloc, VerificationState>(
                        builder: (context, state) {
                          return MPGTextField(
                            width: min(context.responsiveWidth(300), 400),
                            focusNode: _emailFocusNode,
                            controller: _emailController,
                            isPassword: false,
                            hintText: _emailFocusNode.hasFocus ? null : 'Email',
                            onChanged: (text) => _buttonBloc.add(
                              ButtonStateRequest(email: text),
                            ),
                            onTap: () => setState(() {}),
                            errorText: _errorMessageMapper(state),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveWidth(
                      ResponsiveLayout.isDesktop(context) ? 40 : 20,
                    ),
                    vertical: 25,
                  ),
                  width: width,
                  child: Row(
                    children: [
                      if (!ResponsiveLayout.isDesktop(context))
                        Spacer(
                          flex: ResponsiveLayout.isMobile(context) ? 1 : 2,
                        ),
                      MPGCheckbox(
                        buttonColor: ResponsiveLayout.isDesktop(context)
                            ? Colors.black
                            : null,
                        checkColor: ResponsiveLayout.isDesktop(context)
                            ? Colors.white
                            : null,
                        onTap: (buttonStatus) {
                          setState(() {
                            _isButtonTermsSelected = buttonStatus;
                          });
                        },
                      ),
                      if (!ResponsiveLayout.isDesktop(context))
                        Container(width: 25),
                      Expanded(
                        flex: 6,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Li e estou de acordo com todos os ',
                                style: ResponsiveLayout.isDesktop(context)
                                    ? MPGTextStyles.of(context)
                                        .policyNormalDescriptionWeb
                                    : MPGTextStyles.of(context)
                                        .policyNormalDescriptionMobile,
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
                      if (!ResponsiveLayout.isDesktop(context)) const Spacer(),
                    ],
                  ),
                ),
                BlocBuilder<ButtonStatusBloc, ButtonStatusState>(
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: context.responsiveHeight(50),
                      ),
                      child: MPGButton(
                        onPressed:
                            state is ActiveButton && _isButtonTermsSelected
                                ? () {
                                    _verificationBloc.add(
                                      EmailVerificationRequest(
                                        userEmail: _emailController.text,
                                      ),
                                    );
                                  }
                                : null,
                        gradient:
                            state is ActiveButton && _isButtonTermsSelected
                                ? null
                                : MPGColors.of(context)
                                    .mpgButtonColoredGradientDisabled,
                        child: Text(
                          'Continuar',
                          style: state is ActiveButton && _isButtonTermsSelected
                              ? MPGTextStyles.of(context).mpgColoredButton
                              : MPGTextStyles.of(context)
                                  .mpgColoredButtonDisabled,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
