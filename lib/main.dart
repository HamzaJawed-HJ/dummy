import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/routes/app_router.dart';
import 'package:fyp_renterra_frontend/routes/route_names.dart';
import 'package:fyp_renterra_frontend/viewModel/chat_viewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/productViewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_auth_viewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_dashboard_viewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_profile_viewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/user_viewModel/user_auth_viewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/user_viewModel/user_dashboard_viewModel.dart';
import 'package:provider/provider.dart';

void main() {
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
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ChangeNotifierProvider(create: (context) => RenterDashboardViewModel()),
        ChangeNotifierProvider(create: (context) => UserDashboardViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => ChatViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: AppPages.getRoutes(),
        initialRoute: RoutesName.splashScreen,
        // home: UserSignUpScreen(),
      ),
    );
  }
}
