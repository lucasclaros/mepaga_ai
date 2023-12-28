import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
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
        GestureDetector(
          onTap: () => GoRouter.of(context).pop(),
          child: Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 18.w,
            ),
            child: Visibility(
              visible: isBackButtonVisible,
              child: SvgPicture.asset(
                MPGAssetsPaths.of(context).backButton,
                width: 24.w,
              ),
            ),
          ),
        ),
        AutoSizeText(
          title,
          style: MPGTextStyles.of(context).verificationHeaderTitleMobile,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
