import 'package:aboutlamjung/navpages/places.dart';
import 'package:aboutlamjung/navpages/profile.dart';
import 'package:aboutlamjung/navpages/weather.dart';
import 'package:aboutlamjung/theme/color.dart';
import 'package:flutter/material.dart';

import 'navpages/homepage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({
    super.key,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List<Widget> pages = [
    const HomePage(),
    const PlacesPage(),
    const WeatherPage(),
    const ProfilePage(),
  ];

  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: Stack(
          children: [
            pages.elementAt(currentStep),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
              child: Align(
                alignment: const Alignment(0, 1),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed, // Fixed
                    backgroundColor: AppColor.backGroundColor,
                    selectedItemColor: AppColor.selectedItemColor,
                    unselectedItemColor: AppColor.unselectedItemColor,

                    // fixedColor: Colors.amber,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    currentIndex: currentStep,
                    onTap: (int index) {
                      setState(() {
                        currentStep = index;
                      });
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: currentStep == 0
                            ? const Icon(
                                Icons.home_rounded,
                                size: 30,
                              )
                            : const Icon(
                                Icons.home_outlined,
                                size: 30,
                              ),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: currentStep == 1
                            ? const Icon(
                                Icons.place_sharp,
                                size: 30,
                              )
                            : const Icon(
                                Icons.place_outlined,
                                size: 30,
                              ),
                        label: "Place",
                      ),
                      BottomNavigationBarItem(
                        icon: currentStep == 2
                            ? const Icon(
                                Icons.cloud_rounded,
                                size: 30,
                              )
                            : const Icon(
                                Icons.cloud_outlined,
                                size: 30,
                              ),
                        label: "Weather",
                      ),
                      BottomNavigationBarItem(
                        icon: currentStep == 3
                            ? const Icon(
                                Icons.person,
                                size: 30,
                              )
                            : const Icon(
                                Icons.person_outline,
                                size: 30,
                              ),
                        label: "Me",
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

/**
 * pages[currentStep],
      backgroundColor: const Color.fromARGB(255, 220, 217, 217),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.purple,
        animationDuration: const Duration(milliseconds: 300),
        height: 60,
        items: const [
          Icon(
            LineIcons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            LineIcons.streetView,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            LineIcons.cloud,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            LineIcons.user,
            size: 30,
            color: Colors.white,
          )
        ],
        index: currentStep,
        onTap: (index) {
          setState(() {
            currentStep = index;
          });
        },
      ),
 */
