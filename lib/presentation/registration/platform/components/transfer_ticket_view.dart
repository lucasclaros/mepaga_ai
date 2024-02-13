import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/common/app_router.dart';
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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        final tabsRouter = AutoTabsRouter.of(context);
        if (tabsRouter.activeIndex != 0) {
          tabsRouter.navigate(HomeRoute());
        }
      },
      child: MPGScaffold(
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
              onTap: () => context.navigateTo(
                TransferOrientationRoute(platform: 'byma'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
