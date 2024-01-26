import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color:
              isLogout ? Colors.red.withOpacity(0.8) : const Color(0xFF5316B6),
        ),
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 14.h),
        height: 60.h,
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
                  color: Color(0xFFEBEBEB),
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
