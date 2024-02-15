import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';

class PlatformListItem extends StatelessWidget {
  const PlatformListItem({
    super.key,
    required this.logo,
    required this.isLinked,
    required this.platformName,
    this.onTap,
  });

  final String logo;
  final bool isLinked;
  final String platformName;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isLinked ? const Color(0xFF7401FF) : const Color(0xFF98929F),
            width: 2,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        height: 84.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              MPGAssetsPaths.of(context).logoByma,
              width: 90.w,
              // ignore: deprecated_member_use
              color: Colors.red,
            ),
            Text(
              isLinked ? 'Vinculado' : 'Não vinculado',
              style: GoogleFonts.barlow(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: isLinked
                    ? const Color(0xFFE9E9E9)
                    : const Color(0xFF98929F),
                decoration: TextDecoration.underline,
                decorationColor: isLinked
                    ? const Color(0xFFE9E9E9)
                    : const Color(0xFF98929F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
