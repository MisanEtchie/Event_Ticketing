import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_ticketing/models/categorizer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'createeventscreen.dart';
import 'eventinfo.dart';

class YourTickets extends StatefulWidget {
  const YourTickets({
    Key? key,
  });

  @override
  State<YourTickets> createState() => _YourTicketsState();
}

class _YourTicketsState extends State<YourTickets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.angleLeft, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Text(
                    'Your Tickets',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Expanded(
                child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Expanded(
                      child: Stack(children: [
                    Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.pink[300],
                        ),
                        child: Row(
                          children: [
                            Expanded(child: SizedBox()),
                            Text(
                              "3",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.06,
                            )
                          ],
                        )),
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Non-Nacossite",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Text(
                              "NACOS National Conference",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              "Free",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.teal[300]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Expanded(
                      child: Stack(children: [
                    Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.pink[300],
                        ),
                        child: Row(
                          children: [
                            Expanded(child: SizedBox()),
                            Text(
                              "1",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.06,
                            )
                          ],
                        )),
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nacossite",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Text(
                              "NACOS National Conference",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              "₦ 4000",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.teal[300]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
