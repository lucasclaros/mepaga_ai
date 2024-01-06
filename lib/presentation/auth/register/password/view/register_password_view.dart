// ignore_for_file: lines_longer_than_80_chars, use_decorated_box

import 'package:domain/use_cases/user_register_uc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/common/routing.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:mepaga_ai/presentation/auth/register/bloc/register_bloc.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_confirmation_check.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';

class RegisterPasswordView extends StatefulWidget {
  const RegisterPasswordView({
    super.key,
  });

  static Widget create() => BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(
          userRegisterUC: context.read<UserRegisterUC>(),
        ),
        child: const RegisterPasswordView(),
      );

  @override
  State<RegisterPasswordView> createState() => RegisterPasswordViewState();
}

class RegisterPasswordViewState extends State<RegisterPasswordView> {
  bool _isTermsSelected = false;
  bool _minimunCharPass = false;
  bool _specialCharPass = false;
  String? _errorMessage;
  final _passController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _confirmPassController = TextEditingController();
  final _confirmPassFocusNode = FocusNode();
  bool _isLoading = false;
  bool _isShowingFlushbar = false;

  bool checkMiniminChar(String pass) {
    if (pass.length >= 8) {
      return true;
    }
    return false;
  }

  bool checkSpecialChar(String pass) {
    if (_minimunCharPass && pass.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return true;
    }
    return false;
  }

  String? confirmPass(String confirmPass) {
    if (confirmPass.isNotEmpty && _passController.text == confirmPass) {
      return null;
    }
    return 'As senhas não coincidem';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterBlocState>(
      listener: (context, state) {
        setState(() {
          _isLoading = state is RegisterBlocLoading;
        });

        if (state is RegisterBlocError && !_isShowingFlushbar) {
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

        if (state is RegisterBlocSuccess) {
          GoRouter.of(context).pushEmailVerificationPage();
        }
      },
      builder: (context, state) {
        return MPGScaffold(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const MPGHeader(title: 'Defina sua senha'),
                SizedBox(height: 20.h),
                MPGConfirmationCheck(
                  content: Text(
                    '8 caracteres no mínimo ',
                    style: GoogleFonts.barlow(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  isSelected: _minimunCharPass,
                ),
                MPGConfirmationCheck(
                  content: Text(
                    r'Caractere especial (@, !, $, ...)',
                    style: GoogleFonts.barlow(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  isSelected: _specialCharPass,
                ),
                SizedBox(height: 20.h),
                Column(
                  children: [
                    MPGTextField(
                      labelText: 'Digite sua senha',
                      textInputAction: TextInputAction.next,
                      controller: _passController,
                      focusNode: _passFocusNode,
                      isPassword: true,
                      hintText: 'Senha',
                      onEditingComplete: _confirmPassFocusNode.requestFocus,
                      onChanged: (pass) {
                        setState(() {
                          _minimunCharPass = checkMiniminChar(pass);
                          _specialCharPass = checkSpecialChar(pass);
                          if (_confirmPassController.text.isNotEmpty) {
                            _errorMessage =
                                confirmPass(_confirmPassController.text);
                          }
                        });
                      },
                    ),
                    SizedBox(height: 40.h),
                    MPGTextField(
                      labelText: 'Confirme sua senha',
                      controller: _confirmPassController,
                      focusNode: _confirmPassFocusNode,
                      isPassword: true,
                      hintText: 'Senha',
                      errorText: _errorMessage,
                      onEditingComplete: _confirmPassFocusNode.unfocus,
                      onChanged: (pass) {
                        setState(() {
                          _errorMessage = confirmPass(pass);
                        });
                      },
                    ),
                    SizedBox(height: 45.h),
                    MPGConfirmationCheck(
                      onTap: () {
                        setState(() {
                          _isTermsSelected = !_isTermsSelected;
                        });
                      },
                      isSelected: _isTermsSelected,
                      content: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Li e estou de acordo com todos os ',
                              style: MPGTextStyles.of(context)
                                  .policyNormalDescriptionMobile,
                            ),
                            TextSpan(
                              text: 'Termos e Políticas',
                              style: MPGTextStyles.of(context)
                                  .policyColoredDescription,
                              // TODO(Lucas Claros): Adicionar link para o termos e políticas
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 45.h),
                    MPGButton(
                      onPressed: () {
                        if (_minimunCharPass &&
                            _specialCharPass &&
                            _isTermsSelected &&
                            _errorMessage == null) {
                          context.read<RegisterBloc>().add(
                                UserRegister(
                                  name: UserMM().name,
                                  email: UserMM().email,
                                  password: _passController.text,
                                ),
                              );
                        }
                      },
                      gradient: _minimunCharPass &&
                              _specialCharPass &&
                              _isTermsSelected &&
                              _errorMessage == null
                          ? null
                          : MPGColors.of(context)
                              .mpgButtonColoredGradientDisabled,
                      isLoading: _isLoading,
                      child: Text(
                        'Continuar',
                        style: _minimunCharPass &&
                                _specialCharPass &&
                                _isTermsSelected &&
                                _errorMessage == null
                            ? MPGTextStyles.of(context).mpgColoredButton
                            : MPGTextStyles.of(context)
                                .mpgColoredButtonDisabled,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 45.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
