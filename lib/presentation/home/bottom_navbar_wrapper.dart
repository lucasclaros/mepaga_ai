import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/common/app_router.dart';
import 'package:mepaga_ai/custom_icons_icons.dart';
import 'package:mepaga_ai/presentation/home/components/add_ticket_float_button.dart';

@RoutePage()
class BottomNavbarWrapper extends StatefulWidget {
  const BottomNavbarWrapper({
    super.key,
    this.showFlushbar = false,
  });

  final bool showFlushbar;

  @override
  State<BottomNavbarWrapper> createState() => _BottomNavbarWrapperState();
}

class _BottomNavbarWrapperState extends State<BottomNavbarWrapper> {
  void handleTabChange(TabsRouter t, int index) {
    t.setActiveIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      duration: const Duration(milliseconds: 350),
      routes: [
        HomeRoute(showFlushbar: widget.showFlushbar),
        const PlatformRegistrationRoute(),
        const ProfileRoute(),
      ],
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);

        return SafeArea(
          child: Scaffold(
            floatingActionButton: AddTicketFloatingButton(
              onTap: () => handleTabChange(tabsRouter, 1),
              selected: tabsRouter.activeIndex == 1,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                child,
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  height: max(70, 70.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r),
                    ),
                    child: BottomNavigationBar(
                      currentIndex: AutoTabsRouter.of(context).activeIndex,
                      elevation: 0,
                      onTap: (index) => handleTabChange(tabsRouter, index),
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: const Color(0xFF5316B6),
                      unselectedItemColor: const Color(0xFFCEC2DA),
                      selectedLabelStyle: GoogleFonts.barlow(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      unselectedLabelStyle: GoogleFonts.barlow(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      iconSize: 26,
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(CustomIcons.home_icon),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: SizedBox.shrink(),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(CustomIcons.user_icon),
                          label: 'Perfil',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
