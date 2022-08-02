import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_ticketing/screens/hascreated.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'createeventscreen.dart';

class CreateTicketScreen extends StatefulWidget {
  final Event eventr;

  CreateTicketScreen({Key? key, required this.eventr});

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  //const CreateTicketScreen({Key? key}) : super(key: key);
  final ticTitleController = TextEditingController();
  final descTitleController = TextEditingController();
  final priceTitleController = TextEditingController();
  var amountoftickets = 0;
  //late Map<String, List<String>> tiers = {};

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: GestureDetector(
          onTap: () {
            finalproceed();
          },
          child: BottomAppBar(
              color: Colors.pink[300],
              child: Container(
                  height: 40,
                  child: Center(
                      child: Text(
                    "Proceed",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )))),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Create Event Tickets',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              StreamBuilder<List<Tier>>(
                  stream: readTier(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Something went wrong! ${snapshot.error}"),
                      );
                    } else if (snapshot.hasData) {
                      final tiers = snapshot.data!
                          .where((Tier) => Tier.title == widget.eventr.title);
                      return Expanded(
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 140.0 *
                                      tiers.map(CreatedTier).toList().length,
                                  child: ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    children: tiers.map(CreatedTier).toList(),
                                  ),
                                ),
                                createTier(eventr: widget.eventr)
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        )),
      ),
    );
  }

  Widget createTier({required Event eventr}) {
    //late bool creating = true;
    //final Event eventr;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return CreatedTier();
          },
        ),*/

        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            height: 260,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "${eventr.title}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextFormField(
                    controller: ticTitleController,
                    //initialValue: "General Admission",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                        labelText: 'Ticket Name',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: InputBorder.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: descTitleController,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[800]),
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                        //hintText: "Description/Info",
                        labelText: 'Description/Info',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: InputBorder.none),
                  ),
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.grey[700]),
                      ),
                      Container(
                        width: 120,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: priceTitleController,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                            cursorColor: Colors.teal,
                            decoration: InputDecoration(
                                prefixIcon: Text(
                                  "₦",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey[700]),
                                ),
                                prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                //prefixText: "₦",
                                //prefixStyle: TextStyle(color: Colors.amber),
                                hintText: "0.00",
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                border: InputBorder.none),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(child: SizedBox()),
            GestureDetector(
              onTap: checkifempty,
              child: Container(
                height: 30,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.teal[200],
                ),
                child: Center(
                    child: Text(
                  "Save Ticket",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Future isCompleted() async {
    final label = ticTitleController.text;
    final desc = descTitleController.text;
    final price = priceTitleController.text;
    setState(() {
      addTier(label: label, desc: desc, price: int.parse(price));
      //addtoMap();
      //creating == !creating;
      //print(tiers);
    });
    ticTitleController.clear();
    descTitleController.clear();
    priceTitleController.clear();
  }

  Future finalproceed() async {
    ticTitleController.text != "" &&
            descTitleController.text != "" &&
            priceTitleController.text != ""
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  contentPadding: EdgeInsets.all(20),
                  title: Text(
                    "Unsaved Event",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  children: <Widget>[
                    Column(
                      children: [
                        Text(
                          "Ticket isn't saved. Kindly save ticket to proceed with creation!",
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
        : Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HasCreated()),
          );
  }

  Widget CreatedTier(Tier tiers) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${tiers.label}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  /*IconButton(
                      onPressed: () {
                        setState(() {
                          //deleteTier(tiers: tiers);
                          removeTier(tiers: tiers);

                          //tiers.remove(key);
                        });
                      },
                      icon: Icon(
                        FontAwesomeIcons.trash,
                        color: Colors.grey,
                        size: 16,
                      ))*/
                ],
              ),
              Expanded(
                child: SizedBox(
                  height: double.infinity,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Text(
                  "${tiers.desc}",
                ),
              ),
              SizedBox(
                height: 4,
              ),
              tiers.price == 0
                  ? Text("Free")
                  : Text(
                      "₦" "${(tiers.price).toString()}",
                    )
            ],
          ),
        ),
      ),
    );
  }

  void checkifempty() {
    ticTitleController.text == "" ||
            descTitleController.text == "" ||
            priceTitleController.text == ""
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
                          "Some fields seem to be empty or invalid. Kindly fill in all fields to create ticket!",
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

  Stream<List<Tier>> readTier() => FirebaseFirestore.instance
      .collection('tickets')
      .orderBy("price", descending: false)
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => Tier.fromJson(doc.data())).toList());

  Future addTier(
      {required String label, required String desc, required int price}) async {
    final docTickets = FirebaseFirestore.instance.collection("tickets").doc();
    final tier = Tier(
      title: widget.eventr.title,
      label: label,
      desc: desc,
      price: price,
    );
    final json = tier.toJson();
    await docTickets.set(json);
  }
}

class Tier {
  final String title;
  final String label;
  final String desc;
  final int price;
  Tier({
    required this.title,
    required this.label,
    required this.desc,
    required this.price,
  });
  Map<String, dynamic> toJson() => {
        'title': title,
        'label': label,
        'desc': desc,
        'price': price,
      };

  static Tier fromJson(Map<String, dynamic> json) => Tier(
        title: json['title'] ?? '',
        label: json['label'] ?? '',
        desc: json['desc'] ?? '',
        price: json['price'] ?? '',
      );
}
