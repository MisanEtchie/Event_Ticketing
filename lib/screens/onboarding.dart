import 'package:event_ticketing/main.dart';
import 'package:event_ticketing/screens/login.dart';
import 'package:event_ticketing/screens/mainscreen.dart';
//import 'package:event_ticketing/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//import '../widgets/roundedbutton.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.transparent),
        ),
        home: Scaffold(
          body: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
              });
            },
            children: [
              Container(
                  child: FittedBox(
                      child: Image.asset("assets/images/EventSplash.jpg"),
                      fit: BoxFit.cover)),
              Container(
                  child: FittedBox(
                      child: Image.asset("assets/images/EventSplash2.jpg"),
                      fit: BoxFit.cover)),
              Container(
                  child: FittedBox(
                      child: Image.asset("assets/images/EventSplash3.jpg"),
                      fit: BoxFit.cover))
            ],
          ),
          bottomSheet: isLastPage
              ? SafeArea(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    color: Colors.transparent,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(),
                        Center(
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.pink[300]),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogInScreen()),
                                );
                              },
                              child: Text(
                                "Explore Events",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(12),
                  color: Colors.transparent,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Center(
                        child: SmoothPageIndicator(
                          controller: controller,
                          count: 3,
                          onDotClicked: (index) {
                            controller.animateToPage(index,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          effect: WormEffect(
                              dotHeight: 12.0,
                              dotWidth: 12.0,
                              spacing: 8,
                              activeDotColor: Colors.pink[300]!,
                              dotColor: Colors.grey[300]!),
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
