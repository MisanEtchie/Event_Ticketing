import 'package:event_ticketing/main.dart';
import 'package:event_ticketing/screens/login.dart';
import 'package:event_ticketing/widgets/textinput.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/passwordinput.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final xpasswordController = TextEditingController();
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/signup.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                        ),
                        TextInputField(
                          controller: emailController,
                          hint: 'Email',
                          icon: FontAwesomeIcons.envelope,
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.text,
                        ),
                        PasswordInput(
                          controller: passwordController,
                          icon: FontAwesomeIcons.lock,
                          hint: 'Password',
                          inputType: TextInputType.name,
                          inputAction: TextInputAction.next,
                        ),
                        PasswordInput(
                          controller: xpasswordController,
                          icon: FontAwesomeIcons.lock,
                          hint: 'Confirm Password',
                          inputType: TextInputType.name,
                          inputAction: TextInputAction.done,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.pink[300]),
                          child: TextButton(
                            onPressed: () {
                              checkpass();
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LogInScreen()),
                            );
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Already Have an Account?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[50],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  void checkpass() async {
    passwordController.text != xpasswordController.text
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  contentPadding: EdgeInsets.all(20),
                  title: Text(
                    "Invalid Password",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  children: <Widget>[
                    Column(
                      children: [
                        Text(
                          "Password doesn't match. Kindly check your password and try again!",
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
        : {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text),
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            )
          };
  }
}
