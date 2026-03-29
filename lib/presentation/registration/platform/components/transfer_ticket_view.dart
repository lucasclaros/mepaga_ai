import 'package:domain/models/platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/registration/components/platform_list_item.dart';

class TransferTicketView extends StatelessWidget {
  const TransferTicketView({super.key, required this.platforms});

  final List<Platform> platforms;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 70.h),
        Text(
          'De onde vem seu ingresso?',
          style: GoogleFonts.barlow(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFE9E9E9),
          ),
        ),
        SizedBox(height: 55.h),
        ...platforms.map(
          (p) => Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: PlatformListItem(
              logo: MPGAssetsPaths.of(context).logoForPlatform(p.platform),
              isLinked: true,
              platformName: p.platform,
              onTap: () => context.push(
                '/platform/orientation',
                extra: p.platform,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
