import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class MPGHeader extends StatelessWidget {
  const MPGHeader({
    super.key,
    required this.title,
    this.isBackButtonVisible = true,
  });

  final String title;
  final bool isBackButtonVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        if (isBackButtonVisible)
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              padding: EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 18.w,
              ),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: textPrimary,
                size: 22.w,
              ),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
            ),
          ),
        if (!isBackButtonVisible) SizedBox(height: 54.h),
        AutoSizeText(
          title,
          style: MPGTextStyles.of(context).verificationHeaderTitleMobile,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
