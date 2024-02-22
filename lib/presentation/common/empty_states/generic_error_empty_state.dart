import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class GenericErrorEmptyState extends StatelessWidget {
  const GenericErrorEmptyState({
    super.key,
    required this.onRetry,
    this.message,
  });

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          message ?? 'Ops... Ocorreu um erro!',
          style: GoogleFonts.barlow(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFE9E9E9),
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        SizedBox(height: 20.h),
        MPGButton(
          gradient: MPGColors.of(context).mpgButtonWhitedGradient,
          onPressed: onRetry,
          child: Text(
            'Tentar novamente',
            style: MPGTextStyles.of(context).mpgWhitedButton,
          ),
        ),
      ],
    );
  }
}
