// import 'package:flutter/material.dart';
// import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';

// class UpcommingSchedule extends StatelessWidget {
//   const UpcommingSchedule({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Container(
//           margin: EdgeInsets.all(24),
//           padding: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 4,
//                 spreadRadius: 3,
//               ),
//             ],
//           ),
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.check_circle,
//                       color: Colors.green,
//                     ),
//                     SizedBox(width: 5),
//                     Text(
//                       "Confirmed",
//                       style: TextStyle(
//                         color: Colors.green.shade500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Text(
//                   "Apertment Cleaning",
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundImage: NetworkImage(
//                           "https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg?t=st=1690584010~exp=1690584610~hmac=61a99790ea214f0780ef9ccc54df669120077f07599d19f61d4497af69d56cab"),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       "Worker: leesa mik",
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Container(
//                   height: 80,
//                   padding: EdgeInsets.all(8),
//                   margin: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 211, 232, 250),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       radius: 20,
//                       backgroundColor: Colors.white,
//                       child: Icon(
//                         Icons.timelapse_sharp,
//                         size: 30,
//                         color: blueColor,
//                       ),
//                     ),
//                     title: Text(
//                       "Date & Time",
//                       style: TextStyle(
//                         fontSize: 14,
//                         wordSpacing: 2,
//                       ),
//                     ),
//                     subtitle: Text(
//                       "Monday, july 25, 9:00 AM",
//                       style: TextStyle(
//                           fontSize: 14,
//                           wordSpacing: 1,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.location_on,
//                       color: blueColor,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text("Kuc d jkf jos vkd kjdkn dfvls "),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.price_change_outlined,
//                       color: blueColor,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text("\$ 34 "),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 OutlinedButton(
//                     onPressed: () {},
//                     child: Text(
//                       "Reschedule",
//                       style: TextStyle(
//                           fontSize: 18, letterSpacing: 2, color: blueColor),
//                     )),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';

class UpcommingSchedule extends StatelessWidget {
  const UpcommingSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(24),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                spreadRadius: 3,
              ),
            ],
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 5),
                    Text(
                      "Confirmed Booking",
                      style: TextStyle(color: Colors.green.shade500),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  "Toyota Corolla (GLi)",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg",
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Vendor: Leesa Mik",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Container(
                  height: 80,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 211, 232, 250),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.timelapse_sharp,
                        size: 30,
                        color: blueColor,
                      ),
                    ),
                    title: Text(
                      "Pickup Date & Time",
                      style: TextStyle(
                        fontSize: 14,
                        wordSpacing: 2,
                      ),
                    ),
                    subtitle: Text(
                      "Monday, July 25, 9:00 AM",
                      style: TextStyle(
                        fontSize: 14,
                        wordSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Icon(Icons.location_on, color: blueColor),
                    SizedBox(width: 10),
                    Text("Pickup Location: DHA Phase 6, Karachi"),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.price_change_outlined, color: blueColor),
                    SizedBox(width: 10),
                    Text("Price: Rs. 5,500/day"),
                  ],
                ),
                SizedBox(height: 15),
                OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    "Reschedule",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 2,
                      color: blueColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
