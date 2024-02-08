import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';

class AddEmailPlatform extends StatelessWidget {
  const AddEmailPlatform({super.key});

  @override
  Widget build(BuildContext context) {
    return MPGScaffold(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          children: [
            Text(
              'Vincule e-mail válido',
              style: GoogleFonts.barlow(
                fontSize: 32.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
