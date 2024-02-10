import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mepaga_ai/data/cache/data_source/online_cds.dart';
import 'package:mepaga_ai/presentation/auth/login/view/login_view.dart';
import 'package:mepaga_ai/presentation/auth/otp_verification/view/otp_verification_view.dart';
import 'package:mepaga_ai/presentation/auth/register/email/view/register_email_view.dart';
import 'package:mepaga_ai/presentation/auth/register/password/view/register_password_view.dart';
import 'package:mepaga_ai/presentation/home/bottom_navbar_wrapper.dart';
import 'package:mepaga_ai/presentation/home/screens/home/home_page.dart';
import 'package:mepaga_ai/presentation/home/screens/profile/profile_page.dart';
import 'package:mepaga_ai/presentation/onboarding/view/onboarding_view.dart';
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
        CustomRoute(
          page: WelcomeRoute.page,
          initial: true,
          guards: [
            AuthGuard(
              context: context,
            )
          ],
        ),
        CustomRoute(
          page: OnboardingRoute.page,
          transitionsBuilder: customTransition,
          durationInMilliseconds: 650,
          reverseDurationInMilliseconds: 650,
        ),
        CustomRoute(
          page: RegisterEmailRoute.page,
          transitionsBuilder: customTransition,
          durationInMilliseconds: 650,
          reverseDurationInMilliseconds: 650,
        ),
        CustomRoute(
          page: RegisterPasswordRoute.page,
          transitionsBuilder: customTransition,
          durationInMilliseconds: 650,
          reverseDurationInMilliseconds: 650,
        ),
        CustomRoute(
          page: OTPVerificationRoute.page,
          transitionsBuilder: customTransition,
          durationInMilliseconds: 650,
          reverseDurationInMilliseconds: 650,
        ),
        CustomRoute(
          page: LoginRoute.page,
          transitionsBuilder: customTransition,
          durationInMilliseconds: 650,
          reverseDurationInMilliseconds: 650,
        ),
        CustomRoute(
          page: AddEmailPlatformRoute.page,
          transitionsBuilder: customTransition,
          durationInMilliseconds: 650,
          reverseDurationInMilliseconds: 650,
        ),
        CustomRoute(
          page: OTPPlatformVerificationRoute.page,
          transitionsBuilder: customTransition,
          durationInMilliseconds: 650,
          reverseDurationInMilliseconds: 650,
        ),
        CustomRoute(
          page: BottomNavbarRoute.page,
          transitionsBuilder: customTransition,
          durationInMilliseconds: 650,
          reverseDurationInMilliseconds: 650,
          children: [
            CustomRoute(page: HomeRoute.page),
            CustomRoute(page: PlatformRegistrationRoute.page),
            CustomRoute(page: ProfileRoute.page),
          ],
        ),
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
