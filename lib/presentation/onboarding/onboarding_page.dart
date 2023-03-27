// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/onboarding/widgets/onboarding_hint_card.dart';
import 'package:responsive_styles/responsive_styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentHint = 0;
  late List<OnboardingHintCard> hints;
  late PageController pageController;

  bool animatedButton = true;

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: _currentHint);

    hints = [
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
        title: 'E quanto a burocracia?',
        description:
            'Buscamos a simplicidade e eficiência para a sua venda.\n\n'
            'Faça o passo a passo nas telas seguintes e, em caso de dúvidas se sinta à vontade para nos contactar em qualquer etapa do procedimento.',
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

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final doneButtonCondition = _currentHint == hints.length - 1;

    return MPGScaffold(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (value) => setState(() {
                    _currentHint = value;
                  }),
                  padEnds: false,
                  children: [
                    ...hints,
                  ],
                ),
              ),
              Divider(
                color: MPGColors.of(context).dividerColor,
                endIndent: context.responsiveWidth(40),
                indent: context.responsiveWidth(40),
              ),
              SizedBox(
                height: context.responsiveHeight(30),
              ),
              AnimatedSmoothIndicator(
                activeIndex: _currentHint,
                count: hints.length,
                effect: WormEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  activeDotColor: MPGColors.of(context).activePageViewIndicator,
                  dotColor: MPGColors.of(context).inactivePageViewIndicator,
                ),
                onDotClicked: (index) => setState(() {
                  pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 450),
                    curve: Curves.easeInOut,
                  );
                  _currentHint = index;
                }),
              ),
              SizedBox(
                height: context.responsiveHeight(30),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: context.responsiveHeight(60),
                ),
                child: FractionallySizedBox(
                  widthFactor: responsive.value({
                    Breakpoints.xs: 0.8,
                    Breakpoints.lg: 0.25,
                  }),
                  child: MPGButton(
                    onPressed: doneButtonCondition
                        ? null
                        : () => pageController.nextPage(
                              duration: const Duration(
                                milliseconds: 450,
                              ),
                              curve: Curves.easeInOut,
                            ),
                    gradient: doneButtonCondition
                        ? null
                        : MPGColors.of(context).mpgButtonWhitedGradient,
                    child: Text(
                      doneButtonCondition ? 'Vender' : 'Próximo',
                      style: doneButtonCondition
                          ? MPGTextStyles.of(context).mpgColoredButton
                          : MPGTextStyles.of(context).mpgWhitedButton,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
