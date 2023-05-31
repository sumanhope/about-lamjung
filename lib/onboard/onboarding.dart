import 'package:aboutlamjung/landing.dart';
import 'package:aboutlamjung/user/login.dart';
import 'package:aboutlamjung/user/signup.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentpage = 0;
  PageController pageController = PageController();
  List<String> imagepaths = [
    'assets/images/skyhill.jpg',
    'assets/images/sky.jpg',
    'assets/images/hills.jpg',
    'assets/images/mountain.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   actions: [
      //     TextButton(
      //       onPressed: () {
      //         // Handle skip button action
      //       },
      //       child: Text(
      //         'Skip',
      //         style: TextStyle(color: Colors.white),
      //       ),
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: imagepaths.length,
                  onPageChanged: (int page) {
                    setState(() {
                      currentpage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.asset(
                      imagepaths[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(height: 120),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LandingPage();
                      },
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(
                    color: Color(0xFFF1F3F4),
                    width: 2,
                  ),
                ),
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    color: Color(0xFFF1F3F4),
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.45),
            child: SizedBox(
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    pageController.jumpTo(0);
                  });
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(
                    color: Color(0xFFF1F3F4),
                    width: 2,
                  ),
                ),
                child: const Text(
                  "Explore Lamjung with us.",
                  style: TextStyle(
                    color: Color(0xFFF1F3F4),
                    fontFamily: 'Rubik',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.52),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: size.width,
              height: size.height * 0.22,
              decoration: const BoxDecoration(
                color: Color(0xFFF1F3F4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: SizedBox(
                      width: 270,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SignUpPage();
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B1B1B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Lets's Get Started ->",
                          style: TextStyle(
                            color: Color(0xFFF1F3F4),
                            fontFamily: 'Rubik',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have a account?",
                          style: TextStyle(
                            color: Color(0xFF1B1B1B),
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const LoginPage();
                                    },
                                  ),
                                );
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Color(0xFF016FB9),
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < imagepaths.length; i++) {
      indicators.add(
        Container(
          width: 25,
          height: 5,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            shape: BoxShape.rectangle,
            color: currentpage == i ? const Color(0xFFF1F3F4) : Colors.grey,
          ),
        ),
      );
    }
    return indicators;
  }
}
