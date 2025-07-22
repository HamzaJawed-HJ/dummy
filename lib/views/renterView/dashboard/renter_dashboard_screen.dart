import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/generic_widgets/bottom_navbar.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_dashboard_viewModel.dart';
import 'package:provider/provider.dart';

class RenterDashboardScreen extends StatelessWidget {
  const RenterDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final renterViewModel = Provider.of<RenterDashboardViewModel>(context);

    return Scaffold(
        body: renterViewModel.getSelectedScreen(renterViewModel.selectedIndex),
        bottomNavigationBar: BottomNavBar(
          index: renterViewModel.selectedIndex,
          onTap: (index) {
            renterViewModel.setSelectedIndex(index); // Change selected tab
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
