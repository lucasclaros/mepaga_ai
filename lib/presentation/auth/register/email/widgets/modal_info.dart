// ignore_for_file: use_decorated_box, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class ModalInfo extends StatelessWidget {
  const ModalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            child: NotificationListener<OverscrollIndicatorNotification>(
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
                  crossAxisAlignment: WrapCrossAlignment.center,
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
                          style: MPGTextStyles.of(context).mpgColoredButton,
                        ),
                        onPressed: () => Navigator.pop(context),
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
    );
  }
}
