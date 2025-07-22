import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/routes/route_names.dart';
import 'package:fyp_renterra_frontend/views/onboardingView/welcome_screen.dart';
import 'package:fyp_renterra_frontend/views/onboardingView/splash_screen.dart';
import 'package:fyp_renterra_frontend/views/renterView/auth/renter_login_screen.dart';
import 'package:fyp_renterra_frontend/views/renterView/auth/renter_signUp_screen.dart';
import 'package:fyp_renterra_frontend/views/renterView/dashboard/renter_dashboard_screen.dart';
import 'package:fyp_renterra_frontend/views/ownerView/auth/user_login_screen.dart';
import 'package:fyp_renterra_frontend/views/ownerView/auth/user_signUp_screen.dart';
import 'package:fyp_renterra_frontend/views/ownerView/dashboard/user_dashboard_screen.dart';

class AppPages {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      //Splash Screen
      RoutesName.splashScreen: (context) => SplashScreen(),

      //onboarding Screen
      RoutesName.onboardingScreen1: (context) => WelcomeScreen(),

      //User Routes
      RoutesName.userSignUpScreen: (context) => UserSignUpScreen(),
      RoutesName.userLoginScreen: (context) => UserLoginScreen(),

      //renter Routes
      RoutesName.renterSignUpScreen: (context) => RenterSignUpScreen(),

      RoutesName.renterLoginScreen: (context) => RenterLoginScreen(),

      //renter Dashboard

      RoutesName.renterDashboardScreen: (context) => UserDashboardScreen(),

//User Dashboard
      RoutesName.UserDashboardScreen: (context) => RenterDashboardScreen(),
    };
  }
}
