import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
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
            fontSize: 30.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        if (isLoading)
          Shimmer.fromColors(
            baseColor: Colors.white.withOpacity(0.8),
            highlightColor: Colors.white.withOpacity(0.4),
            child: Container(
              height: 40.h,
              width: 220.w,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          )
        else
          Text(
            UserMM().name,
            style: GoogleFonts.barlow(
              fontSize: 36.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
      ],
    );
  }
}
