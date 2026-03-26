import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/registration/components/platform_list_item.dart';

class TransferTicketView extends StatefulWidget {
  const TransferTicketView({super.key});

  @override
  State<TransferTicketView> createState() => _TransferTicketViewState();
}

class _TransferTicketViewState extends State<TransferTicketView> {
  @override
  Widget build(BuildContext context) {
    return MPGScaffold(
      child: Column(
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
          PlatformListItem(
            logo: MPGAssetsPaths.of(context).logoByma,
            isLinked: true,
            platformName: 'byma',
            onTap: () => context.push(
              '/platform/orientation',
              extra: 'byma', // Passando 'byma' como extra
            ),
          ),
        ],
      ),
    );
  }
}
