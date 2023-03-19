import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class MPGButton extends StatelessWidget {
  const MPGButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    this.width,
    this.height,
    this.gradient,
    this.onPressed,
  });

  final String text;
  final Color textColor;
  final Color backgroundColor;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onPressed,
        child: Container(
          width: width ?? context.responsiveWidth(295),
          height: height ?? context.responsiveHeight(55),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            gradient: gradient ?? MPGColors.of(context).mpgButtonGradient,
          ),
          child: Center(
            child: Text(
              text,
              style: MPGTextStyles.of(context).mpgButton,
            ),
          ),
        ),
      );
}
