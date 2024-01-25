import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/custom_icons_icons.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/home/home_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:simple_shadow/simple_shadow.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key, this.showFlushbar = false});

  final bool showFlushbar;

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final _controller = PersistentTabController();

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CustomIcons.home_icon),
        title: 'Home',
        activeColorPrimary: const Color(0xFF5316B6),
        inactiveColorPrimary: const Color(0xFFCEC2DA),
        textStyle: GoogleFonts.barlow(
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
        ),
        // iconSize: 32.w,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add),
        activeColorPrimary: Colors.transparent,
        inactiveColorPrimary: Colors.transparent,
        onPressed: (_) {},
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CustomIcons.user_icon),
        title: 'Perfil',
        activeColorPrimary: const Color(0xFF5316B6),
        inactiveColorPrimary: const Color(0xFFCEC2DA),
        textStyle: GoogleFonts.barlow(
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      HomePage.create(showFlushbar: widget.showFlushbar),
      const MPGScaffold(
        child: Center(
          child: Text(
            'Add ticket',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      const MPGScaffold(
        child: Center(
          child: Text(
            'Perfil',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: InkWell(
          onTap: () {
            _controller.jumpToTab(1);
          },
          child: SimpleShadow(
            opacity: 0.25,
            offset: const Offset(0, 4),
            child: SvgPicture.asset(
              MPGAssetsPaths.of(context).addTicketIcon,
              width: 90.w,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarItems(),
          resizeToAvoidBottomInset: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(16.r),
            colorBehindNavBar: Colors.white,
          ),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          navBarStyle: NavBarStyle.simple,
          navBarHeight: 65.h,
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
          ),
        ),
      ),
    );
  }
}
