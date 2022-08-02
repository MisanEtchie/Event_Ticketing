import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_ticketing/main.dart';
import 'package:event_ticketing/screens/hasbought.dart';
import 'package:event_ticketing/screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'createeventscreen.dart';
import 'createticketscreen.dart';
import 'eventinfo.dart';

class TicketList extends StatefulWidget {
  final Event event;
  const TicketList({Key? key, required this.event}) : super(key: key);

  @override
  State<TicketList> createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
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
                    '"${widget.event.title}" Tickets',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: StreamBuilder<List<Tier>>(
                  stream: readTier(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Something went wrong! ${snapshot.error}"),
                      );
                    } else if (snapshot.hasData) {
                      final tiers = snapshot.data!
                          .where((Tier) => Tier.title == widget.event.title);
                      ;
                      return Container(
                        //width: 140,
                        height: tiers
                                //.where((Event) => Event.title == "Archi")
                                .length
                                .toDouble() *
                            132,
                        child: ListView(
                          //physics: NeverScrollableScrollPhysics(),
                          //scrollDirection: Axis.horizontal,
                          children: tiers.map(buildTier).toList(),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })),
            )
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          //finalproceed();
        },
        child: GestureDetector(
          onTap: (() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HasBought()),
            );
          }),
          child: BottomAppBar(
              color: Colors.pink[300],
              child: Container(
                  height: 40,
                  child: Center(
                      child: Text(
                    "Purchase",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )))),
        ),
      ),
    );
  }

  Stream<List<Tier>> readTier() => FirebaseFirestore.instance
      .collection('tickets')
      .orderBy('price', descending: false)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Tier.fromJson(doc.data())).toList());

  Widget buildTier(Tier tier) {
    final priceController = TextEditingController();
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(children: [
                        SizedBox(
                          width: 12,
                        ),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.ticket,
                              size: 18,
                              color: Colors.pink[300],
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${tier.label}.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Text(
                                    "${tier.desc}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.grey[700]),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        Expanded(
                          child: SizedBox(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tier.price == 0 ? "Free" : "₦ " + "${tier.price}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[300],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4, left: 6),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 2,
                                  controller: priceController,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800]),
                                  cursorColor: Colors.teal,
                                  decoration: InputDecoration(
                                      //counter: Offstage(),
                                      //hintText: "Description/Info",
                                      hintText: '0',
                                      counterText: '',
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                            )
                          ],
                        ),
                        //Expanded(child: SizedBox()),
                      ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
