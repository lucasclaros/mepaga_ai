import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
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
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => GoRouter.of(context).pop(),
          child: Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              vertical: context.responsiveHeight(16),
              horizontal: context.responsiveWidth(18),
            ),
            child: Visibility(
              visible: isBackButtonVisible,
              child: SvgPicture.asset(
                MPGAssetsPaths.of(context).backButton,
                width: 24,
              ),
            ),
          ),
        ),
        // SizedBox(
        //   height: context.responsiveHeight(30),
        // ),
        AutoSizeText(
          title,
          style: ResponsiveLayout.isDesktop(context)
              ? MPGTextStyles.of(context).verificationHeaderTitleWeb
              : MPGTextStyles.of(context).verificationHeaderTitleMobile,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
