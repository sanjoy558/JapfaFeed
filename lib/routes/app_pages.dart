import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:japfa_feed_application/views/splashScreen.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(name: Paths.SPLASH_SCREEN, page: () => SplashScreen()),
    /*GetPage(name: Paths.REQUEST_OTP, page: () => LoginScreen()),
    GetPage(name: Paths.VERIFY_OTP, page: () => VerifyOTPScreen()),
    GetPage(name: Paths.DASHBOARD_SCREEN, page: () => HomeScreen()),
    GetPage(name: Paths.ONBOARDING_SCREEN, page: () => OnboardingScreen()),
    GetPage(name: Paths.MOBILE_VARIFICATION, page: () => VerifyMobileScreen()),*/
  ];
}
