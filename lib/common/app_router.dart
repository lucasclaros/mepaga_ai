import 'package:auto_route/auto_route.dart';
import 'package:domain/models/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mepaga_ai/data/cache/data_source/online_cds.dart';
import 'package:mepaga_ai/presentation/auth/login/view/login_view.dart';
import 'package:mepaga_ai/presentation/auth/otp_verification/view/otp_verification_view.dart';
import 'package:mepaga_ai/presentation/auth/register/email/view/register_email_view.dart';
import 'package:mepaga_ai/presentation/auth/register/password/view/register_password_view.dart';
import 'package:mepaga_ai/presentation/buyer/buyer_page.dart';
import 'package:mepaga_ai/presentation/home/bottom_navbar_wrapper.dart';
import 'package:mepaga_ai/presentation/home/screens/home/home_page.dart';
import 'package:mepaga_ai/presentation/home/screens/profile/profile_page.dart';
import 'package:mepaga_ai/presentation/onboarding/view/onboarding_view.dart';
import 'package:mepaga_ai/presentation/registration/payment/payment_registration_page.dart';
import 'package:mepaga_ai/presentation/registration/platform/add_email_platform/add_email_platform_view.dart';
import 'package:mepaga_ai/presentation/registration/platform/otp_platform_verification/view/otp_platform_verification_view.dart';
import 'package:mepaga_ai/presentation/registration/platform/platform_registration_view.dart';
import 'package:mepaga_ai/presentation/registration/tickets/transfer_orientation_page.dart';
import 'package:mepaga_ai/presentation/welcome/welcome_page.dart';
import 'package:provider/provider.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page|View|Wrapper,Route',
)
class AppRouter extends _$AppRouter {
  AppRouter({
    super.navigatorKey,
    required this.context,
  });

  final BuildContext context;

  @override
  List<AutoRoute> get routes => [
        MPGRoute(
          path: '/welcome',
          page: WelcomeRoute.page,
          initialRoute: true,
          guards: [AuthGuard(context: context)],
        ),
        MPGRoute(path: '/onboarding', page: OnboardingRoute.page),
        MPGRoute(path: '/register-email', page: RegisterEmailRoute.page),
        MPGRoute(path: '/register-password', page: RegisterPasswordRoute.page),
        MPGRoute(
          path: '/mpg-otp-verification',
          page: OTPVerificationRoute.page,
        ),
        MPGRoute(
          path: '/login',
          page: LoginRoute.page,
          guards: [AuthGuard(context: context)],
        ),
        MPGRoute(
          path: '/bottom-navbar',
          page: BottomNavbarRoute.page,
          children: [
            MPGRoute(path: 'home-page', page: HomeRoute.page),
            MPGRoute(
              path: 'platform',
              page: PlatformTab.page,
              children: [
                AutoRoute(
                  path: '',
                  page: EmptyRouterRoute.page,
                  guards: [
                    BottomNavbarNestedRouteTabGuard(
                      route: const PlatformRegistrationRoute(),
                    ),
                  ],
                ),
                MPGRoute(
                  path: 'platform-registration',
                  page: PlatformRegistrationRoute.page,
                ),
                MPGRoute(
                  path: 'orientation',
                  page: TransferOrientationRoute.page,
                ),
              ],
            ),
            MPGRoute(path: 'profile-page', page: ProfileRoute.page),
          ],
        ),
        MPGRoute(path: '/add-email-platform', page: AddEmailPlatformRoute.page),
        MPGRoute(
          path: '/platform-otp-verification',
          page: OTPPlatformVerificationRoute.page,
        ),
        MPGRoute(
          path: '/pix-registration',
          page: PaymentRegistrationRoute.page,
        ),
        MPGRoute(page: BuyerRoute.page, path: '/buyer-page/:ticketId'),
      ];
}

Widget customTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: animation.drive(
      Tween(
        begin: const Offset(1.5, 0),
        end: Offset.zero,
      ).chain(
        CurveTween(
          curve: Curves.easeInOut,
        ),
      ),
    ),
    child: child,
  );
}

class AuthGuard extends AutoRouteGuard {
  AuthGuard({required this.context});

  final BuildContext context;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final onlineCds = context.read<OnlineCDS>();
    final token = await onlineCds.getJWT();

    FlutterNativeSplash.remove();
    if (token != null) {
      await router.push(BottomNavbarRoute());
    } else {
      resolver.next();
    }
  }
}

class SameRouteGuard extends AutoRouteGuard {
  SameRouteGuard();

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    if (router.current.name != resolver.route.name) {
      resolver.next();
    }
  }
}

class BottomNavbarNestedRouteTabGuard extends AutoRouteGuard {
  BottomNavbarNestedRouteTabGuard({required this.route});

  final PageRouteInfo<dynamic> route;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    await router.push(route);
  }
}

Route<T> modalSheetBuilder<T>(
  BuildContext context,
  Widget child,
  AutoRoutePage<T> page,
) {
  return ModalBottomSheetRoute(
    settings: page,
    builder: (context) => child,
    isScrollControlled: true,
  );
}

class MPGRoute extends CustomRoute {
  MPGRoute({
    required super.page,
    List<AutoRouteGuard> guards = const [],
    super.children,
    super.path,
    super.maintainState = true,
    bool initialRoute = false,
  }) : super(
          transitionsBuilder: customTransition,
          durationInMilliseconds: 650,
          reverseDurationInMilliseconds: 650,
          initial: initialRoute,
          guards: [...guards, SameRouteGuard()],
        );
}

@RoutePage(name: 'HomeTab')
class HomeTabPage extends AutoRouter {
  const HomeTabPage({super.key});
}

@RoutePage(name: 'PlatformTab')
class PlatofrmTabPage extends AutoRouter {
  const PlatofrmTabPage({super.key});
}

@RoutePage(name: 'ProfileTab')
class ProfileTabPage extends AutoRouter {
  const ProfileTabPage({required this.onPop, super.key});

  final VoidCallback onPop;
}

@RoutePage()
class EmptyRouterPage extends AutoRouter {
  const EmptyRouterPage({super.key});
}
