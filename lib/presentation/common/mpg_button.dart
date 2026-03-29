import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';

class MPGButton extends StatelessWidget {
  const MPGButton({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.gradient,
    this.onPressed,
    this.isLoading = false,
  });

  final Widget child;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12.r);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 450),
      width: width ?? 295.w,
      height: height ?? 55.h,
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: gradient ?? MPGColors.of(context).mpgButtonColoredGradient,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          splashColor: brandSecondary.withValues(alpha: 0.3),
          onTap: onPressed,
          child: Center(
            child: isLoading
                ? SizedBox(
                    height: 22.w,
                    width: 22.w,
                    child: CircularProgressIndicator(
                      color: Colors.white.withValues(alpha: 0.8),
                      strokeWidth: 2.w,
                    ),
                  )
                : child,
          ),
        ),
      ),
    );
  }
}
