// ignore_for_file: use_decorated_box, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';

class ModalInfo extends StatelessWidget {
  const ModalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMPGBottomSheet(
          context: context,
          title: 'Por que meu e-mail pode ser importante aqui?',
          description:
              'Se você já é usuário de outros aplicativos de eventos, provavelmente já está acostumado a inserir seu e-mail para validar sua conta. Aqui, é a mesma coisa! Insira o seu e-mail de preferência para criar sua conta na nossa plataforma.\n\n'
              'E se você já usou esse mesmo e-mail em outras plataformas, ainda melhor! Assim, você não precisará passar pelo processo de validação novamente, agilizando seu cadastro.\n',
          buttonText: 'Entendi',
        );
      },
      child: SvgPicture.asset(
        MPGAssetsPaths.of(context).doubtButton,
      ),
    );
  }
}
