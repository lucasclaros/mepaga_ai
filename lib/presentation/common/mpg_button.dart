import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';

class MPGButton extends StatelessWidget {
  const MPGButton({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.gradient,
    this.onPressed,
  });

  final Widget child;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 450,
          ),
          width: width ?? 295.w,
          height: height ?? 55.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient:
                gradient ?? MPGColors.of(context).mpgButtonColoredGradient,
          ),
          child: Center(
            child: child,
          ),
        ),
      );
}
