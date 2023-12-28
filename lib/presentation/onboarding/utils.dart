// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/onboarding/widgets/onboarding_hint_card.dart';

List<OnboardingHintCard> getHints(BuildContext context) {
  return [
    OnboardingHintCard(
      image: MPGAssetsPaths.of(context).securityLogo,
      title: 'É seguro mesmo?',
      description:
          'Ninguém merece ter sua venda atrapalhada por um golpista.\n\n'
          'Quer acabar com isso e não ter mais dor de cabeça com esse tipo de situação?\n\n'
          'Aqui sua transferência é realizada por nós sem qualquer tipo de problema.',
    ),
    OnboardingHintCard(
      image: MPGAssetsPaths.of(context).simplicityLogo,
      title: 'E quanto à burocracia?',
      description: 'Buscamos a simplicidade e eficiência para a sua venda.\n\n'
          'Faça o passo a passo nas telas seguintes e, em caso de dúvidas sinta-se à vontade para nos contactar em qualquer etapa do procedimento.',
    ),
    OnboardingHintCard(
      image: MPGAssetsPaths.of(context).flexibilityLogo,
      title: 'Flexibilidade e praticidade',
      description:
          'Quer desistir da venda e resgatar seu ingresso? É possível!\n\n'
          'Sem cadastros complicados.\n\n'
          'Apenas compartilhe o link disponibilizado para venda e o resto pode deixar que fazemos por você!',
    ),
  ];
}
