import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  IconData icon;
  String name;
  int num;
  Color maincolor;
  Color bgcolor;

  Category({
    required this.icon,
    required this.name,
    required this.num,
    required this.maincolor,
    required this.bgcolor,
  });
}

List catlist = [
  Category(
    icon: FontAwesomeIcons.basketball,
    name: "Fitness",
    num: 26,
    maincolor: Colors.blue,
    bgcolor: Colors.blue[200]!,
  ),
  Category(
    icon: FontAwesomeIcons.handPeace,
    name: "Social",
    num: 13,
    maincolor: Colors.purple,
    bgcolor: Colors.purple[200]!,
  ),
  Category(
    icon: FontAwesomeIcons.stethoscope,
    name: "Health & Wellbeing",
    num: 32,
    maincolor: Colors.amber,
    bgcolor: Colors.amber[200]!,
  ),
  Category(
    icon: FontAwesomeIcons.briefcase,
    name: "Career & Business",
    num: 26,
    maincolor: Colors.red,
    bgcolor: Colors.red[200]!,
  ),
  Category(
    icon: FontAwesomeIcons.tree,
    name: "Environmental",
    num: 8,
    maincolor: Colors.green,
    bgcolor: Colors.green[200]!,
  ),
  Category(
    icon: FontAwesomeIcons.guitar,
    name: "Entertainment",
    num: 38,
    maincolor: Colors.pink,
    bgcolor: Colors.pink[200]!,
  ),
  Category(
    icon: FontAwesomeIcons.handHoldingHeart,
    name: "Social Causes",
    num: 14,
    maincolor: Colors.orange,
    bgcolor: Colors.orange[200]!,
  ),
  Category(
    icon: FontAwesomeIcons.microscope,
    name: "Education",
    num: 32,
    maincolor: Colors.teal,
    bgcolor: Colors.teal[200]!,
  ),
  Category(
    icon: FontAwesomeIcons.ellipsis,
    name: "View All",
    num: 127,
    maincolor: Colors.grey,
    bgcolor: Colors.grey[300]!,
  )
];
