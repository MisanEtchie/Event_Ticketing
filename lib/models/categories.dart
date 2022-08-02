//import 'package:event_ticketing/screens/categoryevents.dart';
import 'package:event_ticketing/screens/categorypage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'categorizer.dart';

class CategoryButton extends StatelessWidget {
  final Category cat;
  const CategoryButton({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryScreen(cat: cat)),
        );
      },
      child: Container(
        child: Row(
          children: [
            Container(
              child: Icon(
                cat.icon,
                color: Colors.white,
              ),
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  color: cat.bgcolor, borderRadius: BorderRadius.circular(16)),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              cat.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              width: 16,
            )
          ],
        ),
      ),
    );
  }
}
