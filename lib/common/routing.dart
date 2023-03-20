import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/presentation/home/home_page.dart';
import 'package:mepaga_ai/presentation/welcome/welcome_page.dart';

const _homePage = '/';
const _otpPage = 'otp';

const _otpPath = _homePage + _otpPage;

final routes = GoRouter(
  routes: [
    GoRoute(
      path: _homePage,
      builder: (context, state) => const WelcomePage(),
    ),
  ],
);

extension PageNavigationExtension on GoRouter {
  void pushOTPPage() => go(_otpPath);
}
