// ignore_for_file: lines_longer_than_80_chars, use_decorated_box

import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:styled_text/styled_text.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  static Widget create() => const RegisterView();

  @override
  State<RegisterView> createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  bool _isEmailValid = false;
  String? _errorMessage;
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  String? _errorMessageMapper(String email) {
    if (!_isEmailValid && email.isNotEmpty) {
      return 'Email Inválido. Tente Novamente';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height - kToolbarHeight;

    return MPGScaffold(
      child: SizedBox(
        height: max(height, 812),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MPGHeader(title: 'Crie sua conta'),
              SizedBox(height: context.responsiveHeight(75)),
              SizedBox(
                width: context.responsiveWidth(300),
                child: StyledText(
                  text: 'Insira o seu e-mail de preferência.\n\n'
                      'Para facilitar sua vida, ele poderá ser usado para validar '
                      'sua conta em aplicativos de eventos. <doubt/>',
                  tags: {
                    'doubt': StyledTextWidgetTag(
                      size: Size.square(context.responsiveWidth(25)),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet<dynamic>(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => Container(
                              decoration: const BoxDecoration(
                                color: Color(0xff7401FF),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: NotificationListener<
                                  OverscrollIndicatorNotification>(
                                onNotification: (
                                  OverscrollIndicatorNotification overscroll,
                                ) {
                                  overscroll.disallowIndicator();
                                  return true;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        'Por que meu e-mail pode ser importante aqui?\n',
                                        style: GoogleFonts.barlow(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        'Se você já é usuário de outros aplicativos de eventos, provavelmente já está acostumado a inserir seu e-mail para validar sua conta. Aqui, é a mesma coisa! Insira o seu e-mail de preferência para criar sua conta na nossa plataforma.\n\n'
                                        'E se você já usou esse mesmo e-mail em outras plataformas, ainda melhor! Assim, você não precisará passar pelo processo de validação novamente, agilizando seu cadastro.\n',
                                        style: GoogleFonts.barlow(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20,
                                        ),
                                        child: MPGButton(
                                          child: Text(
                                            'Entendi',
                                            style: MPGTextStyles.of(context)
                                                .mpgColoredButton,
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          MPGAssetsPaths.of(context).doubtButton,
                        ),
                      ),
                    ),
                  },
                  style: GoogleFonts.barlow(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: context.responsiveHeight(40)),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: MPGTextField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  isPassword: false,
                  hintText: 'E-mail',
                  errorText: _errorMessage,
                  onEditingComplete: () {
                    _emailFocusNode.unfocus();
                    setState(() {
                      _errorMessage = _errorMessageMapper(
                        _emailController.text,
                      );
                    });
                  },
                  onChanged: (email) {
                    if (email.isEmpty) {
                      setState(() {
                        _isEmailValid = false;
                        _errorMessage = null;
                      });
                    } else {
                      setState(() {
                        _isEmailValid = EmailValidator.validate(email);
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: context.responsiveHeight(160)),
              MPGButton(
                onPressed: () {},
                gradient: _isEmailValid
                    ? null
                    : MPGColors.of(context).mpgButtonColoredGradientDisabled,
                child: Text(
                  'Continuar',
                  style: _isEmailValid
                      ? MPGTextStyles.of(context).mpgColoredButton
                      : MPGTextStyles.of(context).mpgColoredButtonDisabled,
                ),
              ),
              SizedBox(height: context.responsiveHeight(40)),
            ],
          ),
        ),
      ),
    );
  }
}
