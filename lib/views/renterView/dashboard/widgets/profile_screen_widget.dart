import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  ProfileWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              icon,
              color: Colors.blue,
              size: 25,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded),
        ),
        Divider(
          height: 15,
          thickness: 0.3,
        ),
      ],
    );
  }
}
