// ignore_for_file: lines_longer_than_80_chars, use_decorated_box

import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/common/routing.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:mepaga_ai/presentation/auth/register/email/widgets/modal_info.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:styled_text/styled_text.dart';

class RegisterEmailView extends StatefulWidget {
  const RegisterEmailView({super.key});

  static Widget create() => const RegisterEmailView();

  @override
  State<RegisterEmailView> createState() => RegisterEmailViewState();
}

class RegisterEmailViewState extends State<RegisterEmailView> {
  bool _isEmailValid = false;
  bool _isNameValid = false;
  String? _emailErrorMessage;
  String? _nameErrorMessage;
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailFocusNode = FocusNode();

  String? _emailErrorMessageMapper(String email) {
    if (!_isEmailValid && email.isNotEmpty) {
      return 'Email Inválido. Tente Novamente';
    }
    return null;
  }

  String? _nameErrorMessageMapper(String name) {
    if (!_isNameValid && name.isNotEmpty) {
      return 'Nome Inválido. Tente Novamente';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MPGScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const MPGHeader(title: 'Crie sua conta'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  StyledText(
                    text: 'Insira o seu e-mail de preferência.\n\n'
                        'Para facilitar sua vida, ele poderá ser usado para validar '
                        'sua conta em aplicativos de eventos. <doubt/>',
                    tags: {
                      'doubt': StyledTextWidgetTag(
                        const ModalInfo(),
                        size: Size.square(min(25.w, 25)),
                      ),
                    },
                    style: GoogleFonts.barlow(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 28.h),
                  MPGTextField(
                    controller: _nameController,
                    isPassword: false,
                    hintText: 'Nome',
                    prefixIcon: MPGAssetsPaths.of(context).userIcon,
                    errorText: _nameErrorMessage,
                    onEditingComplete: () {
                      _emailFocusNode.requestFocus();
                      setState(() {
                        _nameErrorMessage = _nameErrorMessageMapper(
                          _nameController.text,
                        );
                      });
                    },
                    textInputAction: TextInputAction.next,
                    onChanged: (name) {
                      setState(() {
                        if (name.isEmpty || name.length < 3) {
                          _isNameValid = false;
                        } else {
                          _isNameValid = true;
                        }
                      });
                    },
                  ),
                  SizedBox(height: 29.h),
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
                ],
              ),
            ),
            SizedBox(height: min(100, 80.h)),
            MPGButton(
              onPressed: _isEmailValid && _isNameValid
                  ? () {
                      UserMM().email = _emailController.text;
                      UserMM().name = _nameController.text;
                      GoRouter.of(context).pushRegisterPassPage();
                    }
                  : null,
              gradient: _isEmailValid && _isNameValid
                  ? null
                  : MPGColors.of(context).mpgButtonColoredGradientDisabled,
              child: Text(
                'Continuar',
                style: _isEmailValid && _isNameValid
                    ? MPGTextStyles.of(context).mpgColoredButton
                    : MPGTextStyles.of(context).mpgColoredButtonDisabled,
              ),
            ),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }
}
