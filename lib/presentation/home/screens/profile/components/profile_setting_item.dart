import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/home/screens/profile/bloc/profile_settings_bloc.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';

class ProfileSettingItem extends StatelessWidget {
  const ProfileSettingItem({
    super.key,
    required this.text,
    this.onTap,
    this.isLogout = false,
  });

  final String text;
  final Function()? onTap;
  final bool isLogout;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: isLogout
          ? () => context.read<ProfileSettingsBloc>().add(
                ProfileSettingsLogout(),
              )
          : onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color:
              isLogout ? Colors.red.withOpacity(0.8) : const Color(0xFF5316B6),
        ),
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 14.h),
        height: 60.h,
        width: max(width, 300.w),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: isLogout
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            SimpleShadow(
              child: Text(
                text,
                style: GoogleFonts.barlow(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFEBEBEB),
                ),
              ),
            ),
            Visibility(
              visible: isLogout,
              child: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
