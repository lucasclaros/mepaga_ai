import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:responsive_styles/responsive_styles.dart';

class OnboardingHintCard extends StatefulWidget {
  const OnboardingHintCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;

  @override
  State<OnboardingHintCard> createState() => _OnboardingHintCardState();
}

class _OnboardingHintCardState extends State<OnboardingHintCard> {
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: double.infinity,
        width: ResponsiveLayout.isDesktop(context) ? 800 : double.infinity,
        child: Center(
          child: Scrollbar(
            controller: controller,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [
                  SizedBox(
                    height: context.responsiveHeight(60),
                  ),
                  SvgPicture.asset(
                    widget.image,
                    height: context.responsiveHeight(80),
                  ),
                  SizedBox(
                    height: context.responsiveHeight(30),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveWidth(40),
                    ),
                    child: Column(
                      children: [
                        AutoSizeText(
                          widget.title,
                          style: MPGTextStyles.of(context).onboardingHintTitle,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: context.responsiveHeight(37.33),
                        ),
                        AutoSizeText(
                          widget.description,
                          style: MPGTextStyles.of(context)
                              .onboardingHintDescription,
                          textAlign: ResponsiveLayout.isDesktop(context)
                              ? TextAlign.center
                              : TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
