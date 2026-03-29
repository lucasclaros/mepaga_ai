import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:shimmer/shimmer.dart';

class ProfileUserInfo extends StatelessWidget {
  const ProfileUserInfo({
    super.key,
    this.isLoading = false,
  });

  final bool isLoading;

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Shimmer.fromColors(
        baseColor: surfaceColor,
        highlightColor: surfaceLight,
        child: Container(
          height: 80.h,
          width: 220.w,
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 32.r,
          backgroundColor: brandPrimary,
          child: Text(
            _initials(UserMM().name),
            style: GoogleFonts.barlow(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: textPrimary,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          UserMM().name,
          style: GoogleFonts.barlow(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),
        Text(
          UserMM().email,
          style: GoogleFonts.barlow(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: textSecondary,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
