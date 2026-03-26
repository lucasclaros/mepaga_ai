import 'package:domain/use_cases/validate_byma_email_uc.dart';
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
import 'package:mepaga_ai/presentation/logistics/buyer/add-email/bloc/add_buyer_email_bloc.dart';

class AddBuyerEmailPage extends StatefulWidget {
  const AddBuyerEmailPage({
    super.key,
    required this.ticketId,
    required this.platform,
    required this.onEmailAdded,
  });

  final String ticketId;
  final String platform;
  final Function(String) onEmailAdded;

  @override
  State<AddBuyerEmailPage> createState() => _AddBuyerEmailPageState();
}

class _AddBuyerEmailPageState extends State<AddBuyerEmailPage> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  String? _emailErrorMessage;
  bool _isEmailValid = false;
  bool _isLoading = false;

  String? _emailErrorMessageMapper(String email) {
    if (!_isEmailValid && email.isNotEmpty) {
      return 'Email Inválido. Tente Novamente';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddBuyerEmailBloc(
        validateBymaEmailUC: context.read<ValidateBymaEmailUC>(),
      ),
      child: MPGScaffold(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const MPGHeader(title: 'Quase lá!'),
                SizedBox(height: 60.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45.w),
                  child: Column(
                    children: [
                      RichText(
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Indique o seu e-mail ',
                              style: GoogleFonts.barlow(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                            TextSpan(
                              text: widget.platform.toUpperCase(),
                              style: GoogleFonts.barlow(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFFF5800),
                              ),
                            ),
                            TextSpan(
                              text: ' para onde o ingresso será transferido',
                              style: GoogleFonts.barlow(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 60.h),
                      MPGTextField(
                        controller: _textController,
                        focusNode: _focusNode,
                        isPassword: false,
                        hintText: 'E-mail',
                        errorText: _emailErrorMessage,
                        onEditingComplete: () {
                          _focusNode.unfocus();
                          setState(() {
                            _emailErrorMessage = _emailErrorMessageMapper(
                              _textController.text,
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
                      SizedBox(height: 250.h),
                      BlocConsumer<AddBuyerEmailBloc, AddBuyerEmailState>(
                        listener: (context, state) {
                          setState(() {
                            _isLoading = state is CheckBuyerEmailLoading;
                          });

                          if (state is CheckBuyerEmailSuccessNoAccount) {
                            setState(() {
                              _emailErrorMessage = 'Email não encontrado';
                            });
                          }

                          if (state is CheckBuyerEmailSuccess) {
                            widget.onEmailAdded(_textController.text);
                            context.pop();
                          }
                        },
                        builder: (context, state) {
                          return MPGButton(
                            gradient: _isEmailValid
                                ? MPGColors.of(context).mpgButtonColoredGradient
                                : MPGColors.of(context)
                                    .mpgButtonColoredGradientDisabled,
                            onPressed: _isEmailValid
                                ? () {
                                    context.read<AddBuyerEmailBloc>().add(
                                          CheckBuyerEmail(
                                            email: _textController.text,
                                            platform: widget.platform,
                                          ),
                                        );
                                  }
                                : null,
                            isLoading: _isLoading,
                            child: Text(
                              'Continuar',
                              style: _isEmailValid
                                  ? MPGTextStyles.of(context).mpgColoredButton
                                  : MPGTextStyles.of(context)
                                      .mpgColoredButtonDisabled,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 60.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
