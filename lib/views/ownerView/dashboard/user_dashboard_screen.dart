import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/generic_widgets/bottom_navbar.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_dashboard_viewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/user_viewModel/user_dashboard_viewModel.dart';
import 'package:provider/provider.dart';

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserDashboardViewModel>(context);

    return Scaffold(
        body: userViewModel.getSelectedScreen(userViewModel.selectedIndex),
        bottomNavigationBar: BottomNavBar(
          index: userViewModel.selectedIndex,
          onTap: (index) {
            userViewModel.setSelectedIndex(index); // Change selected tab
          },
        )

        //  BottomNavigationBar(
        //   currentIndex: viewModel.selectedIndex,
        //   onTap: (index) {
        //     viewModel.setSelectedIndex(index); // Change selected tab
        //   },
        //   items: const [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: 'Profile',
        //     ),
        //   ],
        // ),
        );
  }
}
