import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:mepaga_ai/presentation/home/screens/profile/bloc/profile_settings_bloc.dart';
import 'package:provider/provider.dart';

class ProfileSettingItem extends StatelessWidget {
  const ProfileSettingItem({
    super.key,
    required this.text,
    this.icon,
    this.onTap,
    this.isLogout = false,
  });

  final String text;
  final IconData? icon;
  final Function()? onTap;
  final bool isLogout;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final radius = BorderRadius.circular(10.r);

    return Material(
      color: surfaceColor,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        splashColor: isLogout
            ? errorColor.withValues(alpha: 0.08)
            : brandPrimary.withValues(alpha: 0.06),
        onTap: isLogout
            ? () => context.read<ProfileSettingsBloc>().add(
                  ProfileSettingsLogout(),
                )
            : onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: isLogout ? errorColor.withValues(alpha: 0.4) : surfaceBorder,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          height: 60.h,
          width: max(width, 300.w),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: isLogout ? errorColor : textSecondary,
                  size: 20.w,
                ),
                SizedBox(width: 12.w),
              ],
              Expanded(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.barlow(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: isLogout ? errorColor : textPrimary,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: isLogout ? errorColor.withValues(alpha: 0.5) : textSecondary,
                size: 20.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
