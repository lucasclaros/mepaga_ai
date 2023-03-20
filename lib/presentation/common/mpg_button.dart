import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';

class MPGButton extends StatelessWidget {
  const MPGButton({
    super.key,
    required this.text,
    this.width,
    this.height,
    this.gradient,
    this.onPressed,
  });

  final Text text;
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
            borderRadius: BorderRadius.circular(10),
            gradient: gradient ?? MPGColors.of(context).mpgButtonGradient,
          ),
          child: Center(
            child: text,
          ),
        ),
      );
}
