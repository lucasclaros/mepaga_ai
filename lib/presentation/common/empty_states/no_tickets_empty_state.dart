import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';

class NoTicketsEmptyState extends StatelessWidget {
  const NoTicketsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(
            MPGAssetsPaths.of(context).emptyTickets,
            height: 136.h,
            width: 136.w,
          ),
          SizedBox(height: 80.h),
          Text(
            'Você ainda não possui ingressos',
            style: GoogleFonts.barlow(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
