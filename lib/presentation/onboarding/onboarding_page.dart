import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
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
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              MPGAssetsPaths.of(context).onboardinBackground,
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
                      style: MPGTextStyles.of(context).onboardingTitle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Transfira seus ingressos com segurança',
                      style: MPGTextStyles.of(context).onboardingSubtitle,
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
                text: Text(
                  'Começar',
                  style: MPGTextStyles.of(context).mpgColoredButton,
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
