import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/views/ownerView/dashboard/meaasages_view.dart';
import 'package:fyp_renterra_frontend/views/ownerView/dashboard/add_product_screen.dart';
import 'package:fyp_renterra_frontend/views/ownerView/dashboard/rental_requests_screen.dart';
import 'package:fyp_renterra_frontend/views/ownerView/dashboard/user_chat_screen.dart';
import 'package:fyp_renterra_frontend/views/ownerView/dashboard/owner_home_screen.dart';
import 'package:fyp_renterra_frontend/views/ownerView/dashboard/profile_screen.dart';

class UserDashboardViewModel extends ChangeNotifier {
  int _selectedIndex = 0; // To track the selected bottom nav item

  // Get the selected index
  int get selectedIndex => _selectedIndex;

  // Set the selected index and notify listeners
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Widget getSelectedScreen(int index) {
    switch (index) {
      case 0:
        return const OwnerHomeScreen(); // Home tab content
      case 1:
        return AddProductScreen();

      // Profile tab content
      case 2:
        return RentalRequestsScreen();

      case 3:
        return const MessagesScreen();

      case 4:
        return const ProfileScreen();

      default:
        return Center(
          child: Text("no route"),
        ); // Default to Home tab
    }
  }
}
