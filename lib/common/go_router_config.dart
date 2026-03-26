import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mepaga_ai/data/cache/data_source/online_cds.dart';
import 'package:domain/models/payment_charge.dart';
import 'package:mepaga_ai/presentation/home/bottom_navbar_wrapper.dart';
import 'package:mepaga_ai/presentation/home/screens/home/home_page.dart';
import 'package:mepaga_ai/presentation/home/screens/profile/profile_page.dart';
import 'package:mepaga_ai/presentation/registration/platform/platform_registration_view.dart';
import 'package:mepaga_ai/presentation/onboarding/view/onboarding_view.dart';
import 'package:mepaga_ai/presentation/welcome/welcome_page.dart';
import 'package:mepaga_ai/presentation/auth/login/view/login_view.dart';
import 'package:mepaga_ai/presentation/auth/register/email/view/register_email_view.dart';
import 'package:mepaga_ai/presentation/auth/register/password/view/register_password_view.dart';
import 'package:mepaga_ai/presentation/auth/otp_verification/view/otp_verification_view.dart';
import 'package:mepaga_ai/presentation/logistics/buyer/add-email/add_buyer_email_page.dart';
import 'package:mepaga_ai/presentation/logistics/buyer/buyer_page.dart';
import 'package:mepaga_ai/presentation/logistics/buyer/payment/payment_page.dart';
import 'package:mepaga_ai/presentation/logistics/seller/ticket_seller_page.dart';
import 'package:mepaga_ai/presentation/registration/payment/payment_registration_page.dart';
import 'package:mepaga_ai/presentation/registration/platform/add_email_platform/add_email_platform_view.dart';
import 'package:mepaga_ai/presentation/registration/platform/otp_platform_verification/view/otp_platform_verification_view.dart';
import 'package:mepaga_ai/presentation/registration/tickets/transfer_orientation_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

CustomTransitionPage<T> _slidePage<T>({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: child,
      );
    },
  );
}

final GoRouter routerConfig = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/welcome',
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomNavbarWrapper(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) =>
                  HomePage(showFlushbar: state.extra as bool? ?? false),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/platform',
              builder: (context, state) => const PlatformRegistrationView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/welcome',
      pageBuilder: (context, state) =>
          _slidePage(state: state, child: const WelcomePage()),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) =>
          _slidePage(state: state, child: const LoginView()),
    ),
    GoRoute(
      path: '/onboarding',
      pageBuilder: (context, state) =>
          _slidePage(state: state, child: const OnboardingView()),
    ),
    GoRoute(
      path: '/register-email',
      pageBuilder: (context, state) =>
          _slidePage(state: state, child: const RegisterEmailView()),
    ),
    GoRoute(
      path: '/register-password',
      pageBuilder: (context, state) =>
          _slidePage(state: state, child: const RegisterPasswordView()),
    ),
    GoRoute(
      path: '/mpg-otp-verification',
      pageBuilder: (context, state) =>
          _slidePage(state: state, child: const OTPVerificationView()),
    ),
    GoRoute(
      path: '/add-email-platform',
      pageBuilder: (context, state) {
        final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
        return _slidePage(
          state: state,
          child: AddEmailPlatformView(
            platform: args['platform'] as String,
            onSuccess: args['onSuccess'] as Function(),
          ),
        );
      },
    ),
    GoRoute(
      path: '/platform-otp-verification',
      pageBuilder: (context, state) {
        final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
        return _slidePage(
          state: state,
          child: OTPPlatformVerificationView(
            platform: args['platform'] as String,
            onSuccess: args['onSuccess'] as Function(),
            email: args['email'] as String?,
          ),
        );
      },
    ),
    GoRoute(
      path: '/pix-registration',
      pageBuilder: (context, state) {
        final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
        return _slidePage(
          state: state,
          child: PaymentRegistrationPage(
            onSuccess: args['onSuccess'] as VoidCallback,
          ),
        );
      },
    ),
    GoRoute(
      path: '/seller-ticket',
      pageBuilder: (context, state) => _slidePage(
        state: state,
        child: TicketSellerPage(
          ticketId: state.uri.queryParameters['ticketId']!,
          isBuy: state.uri.queryParameters['isBuy'] == 'true',
        ),
      ),
    ),
    GoRoute(
      path: '/ticket/:ticketId',
      pageBuilder: (context, state) => _slidePage(
        state: state,
        child: BuyerPage(ticketId: state.pathParameters['ticketId']!),
      ),
    ),
    GoRoute(
      path: '/buyer-email',
      pageBuilder: (context, state) {
        final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
        return _slidePage(
          state: state,
          child: AddBuyerEmailPage(
            ticketId: args['ticketId'] as String,
            platform: args['platform'] as String,
            onEmailAdded: args['onEmailAdded'] as Function(String),
          ),
        );
      },
    ),
    GoRoute(
      path: '/payment',
      pageBuilder: (context, state) {
        final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
        return _slidePage(
          state: state,
          child: PaymentPage(
            paymentCharge: args['paymentCharge'] as PaymentCharge,
            platform: args['platform'] as String,
          ),
        );
      },
    ),
    GoRoute(
      path: '/platform/orientation',
      pageBuilder: (context, state) => _slidePage(
        state: state,
        child: TransferOrientationPage(platform: state.extra as String),
      ),
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) async {
    final location = state.uri.toString();

    final onlineCds = context.read<OnlineCDS>();
    final String? loggedInToken = await onlineCds.getJWT();
    final bool isLoggedIn = loggedInToken != null;

    // Rota raiz (/ ou /index.html no web): logado → home sem redirect (preserva extra);
    // não logado → welcome.
    if (location == '/' || location.endsWith('/index.html')) {
      return isLoggedIn ? null : '/welcome';
    }

    // Rotas públicas (acessíveis sem login)
    const publicRoutes = [
      '/welcome',
      '/onboarding',
      '/login',
      '/register-email',
      '/register-password',
      '/mpg-otp-verification',
    ];

    final bool isGoingToPublicRoute = publicRoutes.contains(location);

    // Logado tentando acessar rota pública → vai para home
    if (isLoggedIn && isGoingToPublicRoute) {
      return '/';
    }

    // Não logado tentando acessar rota protegida → vai para login
    if (!isLoggedIn && !isGoingToPublicRoute) {
      return '/login';
    }

    // Sem redirecionamento necessário
    return null;
  },
);