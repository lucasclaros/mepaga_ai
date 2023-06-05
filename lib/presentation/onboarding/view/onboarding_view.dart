// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/common/routing.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/onboarding/widgets/onboarding_hint_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (ResponsiveLayout.isDesktop(context)) {
          Timer.periodic(
              const Duration(
                seconds: 5,
                milliseconds: 500,
              ), (Timer timer) {
            if (_currentHint < 2) {
              _currentHint++;
            } else {
              _currentHint = 0;
            }
            pageController.animateToPage(
              _currentHint,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
            );
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                endIndent: context.responsiveWidth(
                  ResponsiveLayout.isDesktop(context) ? 60 : 40,
                ),
                indent: context.responsiveWidth(
                  ResponsiveLayout.isDesktop(context) ? 60 : 40,
                ),
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
              if (!ResponsiveLayout.isDesktop(context))
                Padding(
                  padding: EdgeInsets.only(
                    bottom: context.responsiveHeight(20),
                    left: context.responsiveWidth(30),
                    right: context.responsiveWidth(30),
                  ),
                  child: MPGButton(
                    onPressed: doneButtonCondition
                        ? () => GoRouter.of(context).pushEmailVerificationPage()
                        : () => pageController.nextPage(
                              duration: const Duration(
                                milliseconds: 450,
                              ),
                              curve: Curves.easeInOut,
                            ),
                    gradient: MPGColors.of(context).mpgButtonWhitedGradient,
                    child: Text(
                      doneButtonCondition ? 'Criar conta' : 'Próximo',
                      style: MPGTextStyles.of(context).mpgWhitedButton,
                    ),
                  ),
                ),
              SizedBox(
                height: context.responsiveHeight(30),
                child: Visibility(
                  visible: doneButtonCondition,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Já possuo conta',
                          style: MPGTextStyles.of(context)
                              .alreadyHasAccountMessage,
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => GoRouter.of(context).pushRegisterPage(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: context.responsiveHeight(50),
              )
            ],
          ),
        ),
      ),
    );
  }
}
