import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/common/routing.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: FocusDetector(
        onFocusGained: () {
          setState(() {
            isLoading = false;
          });
        },
        child: MPGScaffold(
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (!ResponsiveLayout.isDesktop(context))
                Image.asset(
                  MPGAssetsPaths.of(context).welcomeBackground,
                  fit: BoxFit.cover,
                  width: width,
                  height: height,
                ),
              Positioned(
                bottom: context.responsiveHeight(215),
                child: SizedBox(
                  width: context.responsiveWidth(249),
                  child: Column(
                    children: [
                      Text(
                        'ME PAGA AÍ',
                        style: MPGTextStyles.of(context).welcomeTitle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Transfira seus ingressos com segurança',
                        style: MPGTextStyles.of(context).welcomeSubtitle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                curve: Curves.fastOutSlowIn,
                duration: const Duration(
                  milliseconds: 500,
                ),
                bottom: isLoading
                    ? -context.responsiveHeight(55)
                    : context.responsiveHeight(90),
                child: MPGButton(
                  child: Text(
                    'Começar',
                    style: MPGTextStyles.of(context).mpgColoredButton,
                  ),
                  onPressed: () => GoRouter.of(context).pushOnboardingPage(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
