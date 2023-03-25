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
        title: 'Segurança na transferência de ingressos',
        description:
            ' O MePagaAí chegou para garantir que você não seja mais enganado por golpistas. '
            'A plataforma faz o intermédio da negociação, garantindo a integridade da transferência do seu ingresso.',
      ),
      OnboardingHintCard(
        image: MPGAssetsPaths.of(context).simplicityLogo,
        title: 'Processo simples e eficiente',
        description:
            ' Para utilizar o MePagaAí, basta transferir seu ingresso para a nossa conta na plataforma. '
            'Depois, geramos um link para o comprador realizar o pagamento e o ingresso vai automaticamente para a conta dele.',
      ),
      OnboardingHintCard(
        image: MPGAssetsPaths.of(context).flexibilityLogo,
        title: 'Flexibilidade e praticidade',
        description:
            ' O MePagaAí oferece a flexibilidade de você desistir da venda do ingresso e resgatá-lo de volta.'
            ' Além disso, todo o processo é automatizado. Você só precisa compartilhar o link de venda, a gente cuida do resto pra você!',
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
                endIndent: context.responsiveWidth(70),
                indent: context.responsiveWidth(70),
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
                    child: Text(
                      doneButtonCondition ? 'Vender' : 'Próximo',
                      style: MPGTextStyles.of(context).mpgColoredButton,
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
