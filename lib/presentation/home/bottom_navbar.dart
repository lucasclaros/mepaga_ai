import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/custom_icons_icons.dart';
import 'package:mepaga_ai/presentation/home/components/add_ticket_float_button.dart';
import 'package:mepaga_ai/presentation/home/screens/home/home_page.dart';
import 'package:mepaga_ai/presentation/home/screens/profile/profile_page.dart';
import 'package:mepaga_ai/presentation/registration/platform/platform_registration_view.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key, this.showFlushbar = false});

  final bool showFlushbar;

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final _navbarTabController = StreamController<int>.broadcast();
  final _pageController = PageController();

  List<Widget> _buildScreens() {
    return [
      HomePage.create(
        showFlushbar: widget.showFlushbar,
        triggerBottomSheet: triggerBottomSheet,
      ),
      PlatformRegistrationView.create(),
      ProfilePage.create(),
    ];
  }

  void triggerBottomSheet(
    Function(BuildContext, Function(int)) modal,
  ) {
    modal(context, _pageController.jumpToPage);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: AddTicketFloatingButton(
          onTap: () => _pageController.jumpToPage(1),
          tabStream: _navbarTabController.stream,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: PageView(
                controller: _pageController,
                onPageChanged: _navbarTabController.sink.add,
                children: [..._buildScreens()],
              ),
            ),
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
                child: StreamBuilder<int>(
                  initialData: 0,
                  stream: _navbarTabController.stream,
                  builder: (context, snapshot) {
                    return BottomNavigationBar(
                      currentIndex: snapshot.data ?? 0,
                      elevation: 0,
                      onTap: _pageController.jumpToPage,
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
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
