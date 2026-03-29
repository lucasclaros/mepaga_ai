import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:shimmer/shimmer.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key, required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Olá,',
          style: GoogleFonts.barlow(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: textSecondary,
          ),
        ),
        SizedBox(height: 2.h),
        if (isLoading)
          Shimmer.fromColors(
            baseColor: surfaceColor,
            highlightColor: surfaceLight,
            child: Container(
              height: 28.h,
              width: 160.w,
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
          )
        else
          Text(
            UserMM().name.isNotEmpty ? UserMM().name : 'bem-vindo',
            style: GoogleFonts.barlow(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }
}
