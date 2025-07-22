import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final List<CategoryItem> categories = [
    CategoryItem(icon: Icons.directions_car, label: 'Cars'),
    CategoryItem(icon: Icons.house, label: 'Houses'),
    CategoryItem(icon: Icons.devices, label: 'Electronics'),
    CategoryItem(icon: Icons.apartment, label: 'Event Halls'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: categories.map((category) {
          return Container(
            margin: EdgeInsets.only(right: 8),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromARGB(255, 231, 231, 231)),
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 227, 242, 253),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(6),
                  child: Icon(
                    category.icon,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  category.label,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CategoryItem {
  final IconData icon;
  final String label;

  CategoryItem({required this.icon, required this.label});
}
