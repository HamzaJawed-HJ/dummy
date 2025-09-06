import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fyp_renterra_frontend/routes/app_router.dart';
import 'package:fyp_renterra_frontend/routes/route_names.dart';
import 'package:fyp_renterra_frontend/viewModel/chat_viewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/agreement_detail_viewmodel.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/payment_provider.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/productViewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_auth_viewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_dashboard_viewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_profile_viewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/review_viewmodel.dart';
import 'package:fyp_renterra_frontend/viewModel/user_viewModel/owner_profile_viewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/user_viewModel/user_auth_viewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/user_viewModel/user_dashboard_viewModel.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51S2I2eGWwKIlRbsLY55OmDZujUmWQa5MryBji2SFIXYVt8VCAM88Ux7FPfnefhLBnnuXlHKeutjjS0qcb4OGbcjo00EnGySnoL';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserAuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => RenterAuthViewModel(),
        ),
        ChangeNotifierProvider(create: (context) => UserProfileViewModel()),
        ChangeNotifierProvider(create: (context) => RenterDashboardViewModel()),
        ChangeNotifierProvider(create: (context) => UserDashboardViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => ChatViewModel()),
        ChangeNotifierProvider(create: (_) => OwnerProfileViewModel()),
        ChangeNotifierProvider(create: (_) => AgreementDetailViewModel()),
        ChangeNotifierProvider(create: (_) => ReviewViewmodel()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(backgroundColor: Colors.white),
          bottomNavigationBarTheme:
              BottomNavigationBarThemeData(backgroundColor: Colors.white),
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
        ),
        routes: AppPages.getRoutes(),
        initialRoute: RoutesName.splashScreen,
        // home: UserSignUpScreen(),
      ),
    );
  }
}
