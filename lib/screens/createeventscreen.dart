import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:event_ticketing/screens/createticketscreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'eventinfo.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  //const MyApp({Key? key}) : super(key: key);
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final dateController = TextEditingController();
  final orgController = TextEditingController();
  final urlController = TextEditingController();
  final locController = TextEditingController();
  int currentStep = 0;

  List<String> items = [
    'Select Category...',
    'Fitness',
    'Social',
    'Health & Wellbeing',
    'Career & Business',
    'Environmental',
    'Entertainment',
    'Social Causes',
    'Education',
  ];
  String? selectedItem = 'Select Category...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Create New Event',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(primary: Colors.pink[300]!)),
                child: Stepper(
                  onStepTapped: (step) => setState(() => currentStep = step),
                  steps: getSteps(),
                  currentStep: currentStep,
                  onStepContinue: (() {
                    final isLastStep = currentStep == getSteps().length - 1;
                    setState(() {
                      if (isLastStep) {
                        checkifempty();
                        //isCompleted();
                        print("Completed");
                      } else {
                        currentStep++;
                      }
                    });
                  }),
                  onStepCancel: (() {
                    setState(() {
                      currentStep == 0 ? null : currentStep--;
                    });
                  }),
                  controlsBuilder: (context, ControlsDetails controls) {
                    final isLastStep = currentStep == getSteps().length - 1;
                    return Row(
                      children: [
                        if (currentStep != 0)
                          Expanded(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                            onPressed: controls.onStepCancel,
                            child: Container(
                                height: 45, child: Center(child: Text("Back"))),
                          )),
                        if (currentStep != 0)
                          SizedBox(
                            width: 12,
                          ),
                        Expanded(
                            child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                          onPressed: controls.onStepContinue,
                          child: Container(
                              height: 45,
                              child: Center(
                                child:
                                    Text(isLastStep ? "Proceed" : "Continue"),
                              )),
                        )),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future createEvent(Event event) async {
    final docEvent = FirebaseFirestore.instance.collection("events").doc();
    event.id = docEvent.id;
    final json = event.toJson();
    await docEvent.set(json);
  }

  Future isCompleted() async {
    final event = Event(
      // id: docEvent.id,
      title: titleController.text,
      desc: descController.text,
      loc: locController.text,
      cat: selectedItem!,
      time: DateTime.parse(dateController.text),
      liked: false,
      type: "Music & TV",
      paidevent: false,
      attendees: 1000,
      //likes: 5600,
      joined: false,
      organizer: orgController.text,
      imgUrl: urlController.text,
      //tierlist: tiers,
    );

    clearField();
    setState(() {
      //tiers = {};
    });
    //checkifempty();
    createEvent(event);
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreateTicketScreen(
                eventr: event,
              )),
    );
    //await Future.delayed(const Duration(milliseconds: 300), () {});
    //await Navigator.push(context, MaterialPageRoute(builder: (context) => ListofNames()));
  }

  void checkifempty() {
    titleController.text == "" ||
            descController.text == "" ||
            locController.text == "" ||
            dateController.text == "" ||
            orgController.text == "" ||
            urlController == "" ||
            selectedItem == "Select Category..."
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  contentPadding: EdgeInsets.all(20),
                  title: Text(
                    "Invalid Fields",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  children: <Widget>[
                    Column(
                      children: [
                        Text(
                          "Some fields seem to be empty or invalid. Kindly fill in all fields to create event!",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.pink[300],
                                  borderRadius: BorderRadius.circular(12)),
                              height: 45,
                              child: Center(
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                      ],
                    )
                  ]);
            })
        : isCompleted();
  }

  void clearField() {
    titleController.clear();
    descController.clear();
    dateController.clear();
    orgController.clear();
    locController.clear();
    urlController.clear();
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: Text("Basic Info"),
            content: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Icon(
                        FontAwesomeIcons.heading,
                        color: Colors.pink[300],
                      ),
                      height: 45,
                      width: 45,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextField(
                        controller: titleController,
                        maxLength: 36,
                        maxLines: 2,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        cursorColor: Colors.teal,
                        decoration: InputDecoration(
                            hintText: "Add Title",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Icon(
                        FontAwesomeIcons.alignLeft,
                        color: Colors.indigo,
                      ),
                      height: 45,
                      width: 45,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextField(
                        controller: descController,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800]),
                        cursorColor: Colors.teal,
                        maxLines: 7,
                        decoration: InputDecoration(
                            hintText: "Description",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ],
            )),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text("Event Details"),
          content: Column(
            children: [
              Text("kindly ensure image link is valid"),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Icon(
                      FontAwesomeIcons.solidImage,
                      color: Colors.blue[400],
                    ),
                    height: 45,
                    width: 45,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      controller: urlController,
                      //maxLines: 3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.teal),
                      cursorColor: Colors.teal,
                      decoration: InputDecoration(
                          labelText: 'Cover Photo URL',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          hintText: "",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    child: Icon(
                      FontAwesomeIcons.grip,
                      color: Colors.pink[300],
                    ),
                    height: 45,
                    width: 45,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        value: selectedItem,
                        elevation: 1,
                        iconEnabledColor: Colors.teal,
                        items: items
                            .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    //color: Colors.teal
                                  ),
                                )))
                            .toList(),
                        onChanged: (item) {
                          setState(() {
                            selectedItem = item;
                          });
                        }),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Icon(FontAwesomeIcons.clock,
                        color: Colors.green //[300],
                        ),
                    height: 45,
                    width: 45,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: DateTimeField(
                        controller: dateController,
                        format: DateFormat("yyyy-MM-dd HH:mm"),
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now()),
                            );
                            return DateTimeField.combine(date, time);
                          } else {
                            return currentValue;
                          }
                        }),
                  ),
                ],
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Icon(
                      FontAwesomeIcons.person,
                      color: Colors.amber[400],
                    ),
                    height: 45,
                    width: 45,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      controller: orgController,
                      //maxLines: 3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.teal),
                      cursorColor: Colors.teal,
                      decoration: InputDecoration(
                          labelText: 'Organizer',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          hintText: "",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Icon(
                      FontAwesomeIcons.locationDot,
                      color: Colors.purple[300],
                    ),
                    height: 45,
                    width: 45,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      controller: locController,
                      //maxLines: 3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.teal),
                      cursorColor: Colors.teal,
                      decoration: InputDecoration(
                          labelText: 'Venue',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          hintText: "",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Icon(
                      FontAwesomeIcons.city,
                      color: Colors.pink[300],
                    ),
                    height: 45,
                    width: 45,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      //controller: locController,
                      //maxLines: 3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.teal),
                      cursorColor: Colors.teal,
                      decoration: InputDecoration(
                          labelText: 'City',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          hintText: "",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: Text("Continue"),
          content: Column(
            children: [
              Text(
                "Done creating events? Proceed to create events for your tickets...",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey[700]),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
          //content: createTier(),
        ),
      ];
}

class BigEventList extends StatefulWidget {
  //const BigEventList({Key? key}) : super(key: key);

  @override
  State<BigEventList> createState() => _BigEventListState();
}

class _BigEventListState extends State<BigEventList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Event>>(
        stream: readEvents(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong! ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            final events =
                snapshot.data!.where((Event) => Event.attendees > 1000);
            return Container(
              height: 270,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: events.map(buildEvent).toList(),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }

  Stream<List<Event>> readEvents() => FirebaseFirestore.instance
      .collection('events')
      .orderBy('attendees', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList());

  Widget buildEvent(Event event) => Row(
        children: [
          SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventInfo(eventr: event)),
              );
            },
            child: Stack(
              children: [
                Container(
                  height: 270,
                  width: 270,
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(16.0),
                    color: Colors.transparent,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "${event.imgUrl}",
                      ),
                      placeholder: AssetImage("assets/images/error.jpg"),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Text("data"),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  height: 270,
                  width: 270,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black54])),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    height: 50,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "${event.time.day}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat.MMMM().format(event.time).substring(0, 3),
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 230,
                        child: Text(
                          "${event.title}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.locationDot,
                            color: Colors.white70,
                            size: 14,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "${event.loc}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 4,
          )
        ],
      );
}

class MidEventList extends StatefulWidget {
  const MidEventList({Key? key}) : super(key: key);

  @override
  State<MidEventList> createState() => _MidEventListState();
}

class _MidEventListState extends State<MidEventList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Event>>(
        stream: readEvents(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong! ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            final events = snapshot.data!;
            return Container(
              //width: 140,
              height: events
                      //.where((Event) => Event.title == "Archi")
                      .length
                      .toDouble() *
                  132,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                //scrollDirection: Axis.horizontal,
                children: events.map(buildEvent).toList(),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }

  Stream<List<Event>> readEvents() => FirebaseFirestore.instance
      .collection('events')
      .orderBy('time', descending: false)
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
                            child: FadeInImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "${event.imgUrl}",
                              ),
                              placeholder:
                                  AssetImage("assets/images/error.jpg"),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text("data"),
                                );
                              },
                            ),
                            /*child: Image.network(
                              "${event.imgUrl}",
                              errorBuilder: (context, error, stackTrace) {
                                return Text("Loading");
                              },
                              fit: BoxFit.cover,
                            ),*/
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
                        //Expanded(child: SizedBox()),
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

class Event {
  String id;
  String title;
  String loc;
  DateTime time;
  String desc;
  String cat;

  bool liked;

  String type;
  bool paidevent;

  int attendees;
  //List<Map<String, Object>> tierlist;

  bool joined;

  String organizer;
  String imgUrl;
  //Map<String, List> tierlist;

  Event({
    this.id = "",
    required this.title,
    required this.loc,
    required this.desc,
    required this.liked,
    required this.paidevent,
    required this.type,
    required this.time,
    required this.attendees,
    required this.joined,
    required this.organizer,
    required this.cat,
    required this.imgUrl,
    //required this.tierlist
  });

  Map<String, dynamic> toJson() => {
        //'id': ,
        'title': title,
        'loc': loc,
        'desc': desc,
        'time': time,
        'liked': liked,
        'type': type,
        'paidevent': paidevent,
        'attendees': attendees,
        'cat': cat,

        'joined': joined,
        'organizer': organizer,
        'imgUrl': imgUrl,
        //'tierlist': tierlist
      };

  static Event fromJson(Map<String, dynamic> json) => Event(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      loc: json['loc'] ?? '',
      desc: json['desc'] ?? '',
      time: (json['time'] as Timestamp).toDate(),
      liked: json['liked'] ?? '',
      type: json['type'] ?? '',
      paidevent: json['paidevent'] ?? '',
      attendees: json['attendees'] ?? '',
      joined: json['joined'] ?? '',
      organizer: json['organizer'] ?? '',
      imgUrl: json['imgUrl'] ?? '',
      cat: json['cat'] ?? ''
      //tierlist: json['tierlist'] ?? ''
      );
}
