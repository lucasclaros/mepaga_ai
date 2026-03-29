import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class OnboardingHintCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            height: 100.h,
          ),
          SizedBox(height: 28.h),
          Text(
            title,
            style: MPGTextStyles.of(context).onboardingHintTitle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          Text(
            description,
            style: MPGTextStyles.of(context).onboardingHintDescription,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
