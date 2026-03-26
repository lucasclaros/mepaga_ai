import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/custom_icons_icons.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';
import 'package:mepaga_ai/presentation/home/components/add_ticket_float_button.dart';

class BottomNavbarWrapper extends StatelessWidget {
  const BottomNavbarWrapper({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (navigationShell.currentIndex != 0) {
          navigationShell.goBranch(0);
        } else {
          if (!kIsWeb) {
            await showMPGConfirmationModal(
              c: context,
              title: 'Sair do App',
              message: 'Tem certeza que deseja sair?',
              confirmButtonText: 'Sair',
              cancelButtonText: 'Cancelar',
              onConfirm: () {
                FlutterExitApp.exitApp();
              },
            );
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: AddTicketFloatingButton(
            onTap: () => navigationShell.goBranch(1),
            selected: navigationShell.currentIndex == 1,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              navigationShell,
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
                    currentIndex: navigationShell.currentIndex,
                    elevation: 0,
                    onTap: (index) {
                      navigationShell.goBranch(
                        index,
                        initialLocation: index == navigationShell.currentIndex,
                      );
                    },
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
      ),
    );
  }
}
