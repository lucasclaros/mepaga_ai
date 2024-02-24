import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StepWidget extends StatelessWidget {
  const StepWidget({
    super.key,
    required this.step,
    required this.stepText,
  });

  final String step;
  final String stepText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Row(
        children: [
          Container(
            height: 16.w,
            width: 16.w,
            decoration: BoxDecoration(
              color: const Color(0xFFEB3472),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Center(
              child: AutoSizeText(
                step,
                style: GoogleFonts.barlow(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.8),
                ),
                maxLines: 1,
              ),
            ),
          ),
          const SizedBox(width: 10),
          AutoSizeText(
            stepText,
            style: GoogleFonts.barlow(
              fontSize: 21,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.8),
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
