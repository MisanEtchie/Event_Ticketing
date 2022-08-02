import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_ticketing/models/categorizer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'createeventscreen.dart';
import 'eventinfo.dart';

class CategoryScreen extends StatefulWidget {
  final Category cat;
  const CategoryScreen({Key? key, required this.cat});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
                    '"${widget.cat.name}" Events',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            widget.cat.name == "View All"
                ? Expanded(
                    child: StreamBuilder<List<Event>>(
                        stream: readEvents(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                  "Something went wrong! ${snapshot.error}"),
                            );
                          } else if (snapshot.hasData) {
                            final events = snapshot.data!
                                //.where((Event) => Event.cat == widget.cat.name)
                                ;
                            return Expanded(
                              child: ListView(
                                children: [
                                  Container(
                                    //width: 120,
                                    height: events.length.toDouble() * 132,
                                    child: Expanded(
                                      child: ListView(
                                        physics: NeverScrollableScrollPhysics(),
                                        //scrollDirection: Axis.horizontal,
                                        children:
                                            events.map(buildEvent).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        })),
                  )
                : Expanded(
                    child: StreamBuilder<List<Event>>(
                        stream: readEvents(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                  "Something went wrong! ${snapshot.error}"),
                            );
                          } else if (snapshot.hasData) {
                            final events = snapshot.data!
                                .where((Event) => Event.cat == widget.cat.name);
                            return Expanded(
                              child: ListView(
                                children: [
                                  Container(
                                    //width: 120,
                                    height: events.length.toDouble() * 132,
                                    child: Expanded(
                                      child: ListView(
                                        physics: NeverScrollableScrollPhysics(),
                                        //scrollDirection: Axis.horizontal,
                                        children:
                                            events.map(buildEvent).toList(),
                                      ),
                                    ),
                                  ),
                                ],
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
    );
  }

  Stream<List<Event>> readEvents() => FirebaseFirestore.instance
      .collection('events')
      //.where((Event) => Event.cat == widget.cat.name)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());

  Widget buildEvent(Event event) => Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EventInfo(eventr: event)),
                );
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(children: [
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          height: 100,
                          width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              "${event.imgUrl}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${event.time.day} ${DateFormat.MMMM().format(event.time).substring(0, 3)}, ${event.time.year}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            Container(
                              width: 180,
                              child: Text(
                                "${event.title}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.locationDot,
                                  size: 12,
                                  color: Colors.teal[300],
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  width: 180,
                                  child: Text(
                                    "${event.loc}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal[300],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Expanded(child: SizedBox()),
                      ]),
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
