import 'package:event_ticketing/main.dart';
import 'package:confetti/confetti.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HasBought extends StatefulWidget {
  const HasBought({Key? key}) : super(key: key);

  @override
  State<HasBought> createState() => _HasBoughtState();
}

class _HasBoughtState extends State<HasBought> {
  late ConfettiController confetti;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    confetti = new ConfettiController(
      duration: Duration(seconds: 10000),
    );
    confetti.play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    confetti.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: confetti,
                  blastDirectionality: BlastDirectionality.explosive,
                  numberOfParticles: 25,
                  shouldLoop: true,
                  colors: [
                    Colors.blue[300]!,
                    Colors.purple[300]!,
                    Colors.pink[300]!,
                    Colors.green[300]!,
                    Colors.yellow[300]!,
                    //Colors.teal[300]!,
                    //Colors.indigo[300]!
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Spacer(
                      flex: 6,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.pink.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Positioned(
                          top: 15,
                          left: 15,
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.pink.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 25,
                          left: 25,
                          child: Container(
                            child: Icon(
                              Icons.thumb_up_alt,
                              color: Colors.white,
                              size: 50,
                            ),
                            height: 100,
                            width: 100,
                            //color: Colors.blue,
                            decoration: BoxDecoration(
                              color: Colors.pink.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Tickets Booked Succesfully!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.grey[700]),
                    ),
                    Spacer(
                      flex: 6,
                    ),
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.pink[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
