import 'package:event_ticketing/screens/buyticketpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'createeventscreen.dart';

class EventInfo extends StatelessWidget {
  final Event eventr;
  const EventInfo({Key? key, required this.eventr});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.6,
                            minHeight: MediaQuery.of(context).size.height * 0.3,
                          ),
                          child: Container(
                            //height: MediaQuery.of(context).size.height * 0.6,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              "${eventr.imgUrl}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          //width: 270,
                          decoration: BoxDecoration(
                              //borderRadius: BorderRadius.circular(24.0),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Colors.black38,
                                Colors.transparent,
                              ])),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${eventr.title}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Organizer–",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    "${eventr.organizer}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Divider(),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Container(
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (() {}),
                                        child: Row(
                                          children: [
                                            Tooltip(
                                              message: "category",
                                              child: Container(
                                                child: Icon(
                                                  FontAwesomeIcons.grip,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.pink[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                "${eventr.cat}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Tooltip(
                                        message: "date",
                                        child: Container(
                                          child: Icon(
                                            FontAwesomeIcons.calendar,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.blue[200],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "${eventr.time.day}".toString() +
                                            " " +
                                            "${DateFormat.MMMM().format(eventr.time)}" +
                                            ", " +
                                            "${eventr.time.year}".toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      const VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        indent: 5,
                                        endIndent: 5,
                                        width: 20,
                                      ),
                                      Tooltip(
                                        message: "time",
                                        child: Container(
                                          child: Icon(FontAwesomeIcons.clock,
                                              color: Colors.white, size: 16),
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.green[200],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "${eventr.time.hour}:${eventr.time.minute}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Tooltip(
                                message: "location",
                                child: Container(
                                  child: Icon(FontAwesomeIcons.locationDot,
                                      color: Colors.white, size: 16),
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.purple[200],
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  "${eventr.loc}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "About this Event",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${eventr.desc}",
                              style: TextStyle(fontSize: 16, height: 1.5),
                              //textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 24),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TicketList(
                                      event: eventr,
                                    )),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.pink[300],
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: Text(
                              "Join",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(FontAwesomeIcons.angleLeft),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
