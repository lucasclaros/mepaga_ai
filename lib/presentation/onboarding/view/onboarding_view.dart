// ignore_for_file: lines_longer_than_80_chars
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mepaga_ai/common/app_router.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/onboarding/utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int _currentHint = 0;
  late PageController pageController;

  bool animatedButton = true;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _currentHint);
  }

  Function()? _getButtonAction(bool doneButtonCondition, BuildContext context) {
    return doneButtonCondition
        ? () => context.router.push(const RegisterEmailRoute())
        : () => pageController.nextPage(
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeInOut,
            );
  }

  @override
  Widget build(BuildContext context) {
    final hints = getHints(context);
    final doneButtonCondition = _currentHint == hints.length - 1;

    return MPGScaffold(
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
              endIndent: 40.w,
              indent: 40.w,
            ),
            SizedBox(height: 30.h),
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
            SizedBox(height: 30.h),
            Column(
              children: [
                MPGButton(
                  onPressed: _getButtonAction(doneButtonCondition, context),
                  gradient: MPGColors.of(context).mpgButtonWhitedGradient,
                  child: Text(
                    doneButtonCondition ? 'Criar conta' : 'Próximo',
                    style: MPGTextStyles.of(context).mpgWhitedButton,
                  ),
                ),
                SizedBox(height: 20.h),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 350),
                  opacity: doneButtonCondition ? 1 : 0,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Já possuo uma conta',
                          style: MPGTextStyles.of(context)
                              .alreadyHasAccountMessage,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.router.push(HomeRoute()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
