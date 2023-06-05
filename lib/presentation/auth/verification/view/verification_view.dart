import 'package:auto_size_text/auto_size_text.dart';
import 'package:domain/use_cases/email_validation_uc.dart';
import 'package:domain/use_cases/email_verification_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/auth/verification/email/bloc/button_status_bloc.dart';
import 'package:mepaga_ai/presentation/auth/verification/email/view/email_verification_view.dart';
import 'package:mepaga_ai/presentation/auth/verification/otp/view/otp_verification_view.dart';
import 'package:mepaga_ai/presentation/auth/verification/view/bloc/verification_bloc.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:provider/provider.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({
    super.key,
  });

  static Widget create() => Consumer2<EmailVerificationUC, EmailValidationUC>(
        builder: (_, emailVerificationUC, emailValidationUC, __) =>
            MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => VerificationBloc(
                emailValidationUC: emailVerificationUC,
              ),
            ),
            BlocProvider(
              create: (context) => ButtonStatusBloc(
                emailValidationUC: emailValidationUC,
              ),
            ),
          ],
          child: const VerificationView(),
        ),
      );

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  @override
  Widget build(_) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return MPGScaffold(
      backgroundColor:
          ResponsiveLayout.isDesktop(context) ? const Color(0xFFF2F2F2) : null,
      child: Scrollbar(
        child: SingleChildScrollView(
          child: BlocBuilder<VerificationBloc, VerificationState>(
            builder: (context, state) {
              return Column(
                children: [
                  const MPGHeader(title: 'Verificação de email'),
                  if (state is InitialState || state is Error)
                    const EmailVerificationView(),
                  if (state is ValidEmail)
                    OTPVerificationView(
                      user: state.user,
                    ),
                  if (state is Loading)
                    Padding(
                      padding: EdgeInsets.only(
                        top: context.responsiveHeight(320),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/loading.gif',
                              height: 120,
                              width: 120,
                            ),
                            const SizedBox(height: 13),
                            AutoSizeText(
                              'Validando informações',
                              style: MPGTextStyles.of(context)
                                  .onboardingHintDescription
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Visibility(
                    visible: state is ValidEmail,
                    child: Column(
                      children: [
                        SizedBox(height: context.responsiveHeight(30)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: context.responsiveHeight(50),
                          ),
                          child: MPGButton(
                            // gradient: _isEmailValid && _isButtonTermsSelected
                            //     ? null
                            //     : LinearGradient(
                            //         colors: [
                            //           razzmatazz.withOpacity(0.4),
                            //           amber.withOpacity(0.4),
                            //         ],
                            //       ),
                            child: Text(
                              'Validar',
                              style:
                                  // _isEmailValid && _isButtonTermsSelected
                                  //     ? MPGTextStyles.of(context).mpgColoredButton
                                  MPGTextStyles.of(context).mpgColoredButton,
                            ),
                          ),
                        ),
                        SizedBox(height: context.responsiveHeight(30)),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
