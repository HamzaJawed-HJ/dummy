import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatefulWidget {
  Function(int)? onTap;
  int index;
  final bool isOwner;

  BottomNavBar({super.key, this.onTap, this.index = 0, this.isOwner = false});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    // Build items dynamically based on isOwner
    List<BottomNavigationBarItem> items = [
      // Home
      BottomNavigationBarItem(
        icon: widget.index == 0
            ? const CircleAvatar(
                radius: 20,
                backgroundColor: blueColor,
                child: Icon(
                  Icons.home_rounded,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.home_rounded),
        label: 'Home',
      ),

      // Second Tab
      widget.isOwner
          ? BottomNavigationBarItem(
              icon: widget.index == 1
                  ? const CircleAvatar(
                      backgroundColor: blueColor,
                      child: Icon(
                        Icons.add_box_outlined,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.add_box_outlined),
              label: 'Add',
            )
          : BottomNavigationBarItem(
              icon: widget.index == 1
                  ? const CircleAvatar(
                      backgroundColor: blueColor,
                      child: Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.calendar_month_outlined),
              label: 'Requests',
            ),

      // Third Tab
      widget.isOwner
          ? BottomNavigationBarItem(
              icon: widget.index == 2
                  ? const CircleAvatar(
                      backgroundColor: blueColor,
                      child: Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.calendar_month_outlined),
              label: 'Requests',
            )
          : BottomNavigationBarItem(
              icon: widget.index == 2
                  ? const CircleAvatar(
                      backgroundColor: blueColor,
                      child: Icon(
                        Icons.message_outlined,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.message_outlined),
              label: 'Chats',
            ),
    ];

    // Add 4th tab (Chats) only for owner
    if (widget.isOwner) {
      items.add(
        BottomNavigationBarItem(
          icon: widget.index == 3
              ? const CircleAvatar(
                  backgroundColor: blueColor,
                  child: Icon(
                    Icons.message_outlined,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.message_outlined),
          label: 'Chats',
        ),
      );
    }

    // Profile Tab (always last)
    int profileIndex = widget.isOwner ? 4 : 3;
    items.add(
      BottomNavigationBarItem(
        icon: widget.index == profileIndex
            ? const CircleAvatar(
                backgroundColor: blueColor,
                child: Icon(
                  Icons.person_4_outlined,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.person_4_outlined),
        label: 'Profile',
      ),
    );

    return BottomNavigationBar(
      currentIndex: widget.index,
      iconSize: 30,
      elevation: 2,
      items: items,

      selectedItemColor: blueColor,
      unselectedItemColor: Colors.grey.shade700,
      onTap: widget.onTap,

//       items: [
//         BottomNavigationBarItem(
//           icon: widget.index == 0
//               ? const CircleAvatar(
//                   radius: 20,
//                   backgroundColor: blueColor,
//                   child: Icon(
//                     Icons.home_rounded,
//                     color: Colors.white,
//                   ),
//                 )
//               : Icon(Icons.home_rounded),
//           label: 'Home',
//         ),
//         widget.isOwner
//             ? BottomNavigationBarItem(
//                 icon: widget.index == 1
//                     ? const CircleAvatar(
//                         backgroundColor: blueColor,
//                         child: Icon(
//                           Icons.add_box_outlined,
//                           color: Colors.white,
//                         ),
//                       )
//                     : const Icon(Icons.add_box_outlined),
//                 label: 'Add',
//               )
//             : BottomNavigationBarItem(
//                 icon: widget.index == 1
//                     ? const CircleAvatar(
//                         backgroundColor: blueColor,
//                         child: Icon(
//                           Icons.calendar_month_outlined,
//                           color: Colors.white,
//                         ),
//                       )
//                     : Icon(Icons.calendar_month_outlined),
//                 label: 'Requests',
//               ),
//         widget.isOwner
//             ? BottomNavigationBarItem(
//                 icon: widget.index == 2
//                     ? const CircleAvatar(
//                         backgroundColor: blueColor,
//                         child: Icon(
//                           Icons.calendar_month_outlined,
//                           color: Colors.white,
//                         ),
//                       )
//                     : Icon(Icons.calendar_month_outlined),
//                 label: 'Requests',
//               )
//             : BottomNavigationBarItem(
//                 icon: widget.index == 2
//                     ? const CircleAvatar(
//                         backgroundColor: blueColor,
//                         child: Icon(
//                           Icons.message_outlined,
//                           color: Colors.white,
//                         ),
//                       )
//                     : Icon(Icons.message_outlined),
//                 label: 'Chats',
//               ),
//            if(           widget.isOwner )

// BottomNavigationBarItem(
//                 icon: widget.index == 3
//                     ? const CircleAvatar(
//                         backgroundColor: blueColor,
//                         child: Icon(
//                           Icons.message_outlined,
//                           color: Colors.white,
//                         ),
//                       )
//                     : Icon(Icons.message_outlined),
//                 label: 'Chats',
//               ),

//         BottomNavigationBarItem(
//           icon: widget.index == widget.isOwner?? 3:4,
//               ? const CircleAvatar(
//                   backgroundColor: blueColor,
//                   child: Icon(
//                     Icons.person_4_outlined,
//                     color: Colors.white,
//                   ),
//                 )
//               : const Icon(
//                   Icons.person_4_outlined,
//                 ),
//           label: 'Profile',
//         )
//       ],
      // backgroundColor: whiteColor,
    );
  }
}
