import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';

class NoTicketsEmptyState extends StatelessWidget {
  const NoTicketsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: surfaceColor,
              shape: BoxShape.circle,
              border: Border.all(color: surfaceBorder),
            ),
            child: Icon(
              Icons.confirmation_number_outlined,
              color: textSecondary,
              size: 36.w,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Nenhum ingresso encontrado',
            style: GoogleFonts.barlow(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Seus ingressos aparecerão aqui\nassim que forem cadastrados.',
            style: GoogleFonts.barlow(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
