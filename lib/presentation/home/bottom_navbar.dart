import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/custom_icons_icons.dart';
import 'package:mepaga_ai/presentation/home/components/add_ticket_float_button.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({
    super.key,
    this.showFlushbar = false,
    required this.child,
  });

  final bool showFlushbar;
  final StatefulNavigationShell child;

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final _navbarTabController = StreamController<int>.broadcast();
  final _pageController = PageController();

  void triggerBottomSheet(
    Function(BuildContext, Function(int)) modal,
  ) {
    modal(context, _pageController.jumpToPage);
  }

  void handleTabChange(int index) {
    _navbarTabController.sink.add(index);
    widget.child.goBranch(
      index,
      initialLocation: index == widget.child.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: AddTicketFloatingButton(
          onTap: () => handleTabChange(1),
          tabStream: _navbarTabController.stream,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            widget.child,
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
                  currentIndex: widget.child.currentIndex,
                  elevation: 0,
                  onTap: handleTabChange,
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
  }
}
