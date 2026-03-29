import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';

class PlatformListItem extends StatelessWidget {
  const PlatformListItem({
    super.key,
    required this.logo,
    required this.isLinked,
    required this.platformName,
    this.onTap,
  });

  final String logo;
  final bool isLinked;
  final String platformName;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isLinked ? brandPrimary : textSecondary,
            width: 2,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        height: 84.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 110.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: logo.endsWith('.svg')
                  ? SvgPicture.asset(logo, fit: BoxFit.contain)
                  : Image.asset(logo, fit: BoxFit.contain),
            ),
            Text(
              isLinked ? 'Vinculado' : 'Não vinculado',
              style: GoogleFonts.barlow(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: isLinked ? textPrimary : textSecondary,
                decoration: TextDecoration.underline,
                decorationColor: isLinked ? textPrimary : textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
