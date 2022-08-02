import 'package:event_ticketing/screens/createeventscreen.dart';
import 'package:event_ticketing/screens/onboarding.dart';
import 'package:event_ticketing/screens/profile.dart';
import 'package:event_ticketing/screens/ticketscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'screens/mainscreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Onboarding()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screens = [MainScreen(), CreateEventScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex, //New
            onTap: _onItemTapped,

            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Colors.teal,

            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.houseChimney,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.circlePlus,
                  ),
                  label: "Add"),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.solidUser), label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
