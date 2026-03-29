import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';

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
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: DecoratedBox(
          decoration: const BoxDecoration(
            color: surfaceColor,
            border: Border(
              top: BorderSide(color: surfaceBorder),
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: brandPrimary.withValues(alpha: 0.12),
              highlightColor: brandPrimary.withValues(alpha: 0.06),
              splashFactory: InkRipple.splashFactory,
            ),
            child: BottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              elevation: 0,
              backgroundColor: Colors.transparent,
              onTap: (index) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: brandPrimary,
              unselectedItemColor: textSecondary,
              selectedLabelStyle: GoogleFonts.barlow(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.barlow(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
              iconSize: 24.w,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.confirmation_number_outlined),
                  label: 'Ingressos',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded),
                  label: 'Perfil',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
