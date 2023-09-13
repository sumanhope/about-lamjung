import 'package:aboutlamjung/navpages/addplace.dart';
import 'package:aboutlamjung/navpages/details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/popularplace.dart';
import '../utils/recommendationcard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final pagecontroller = ScrollController();

  Future errorDialog(String error) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          backgroundColor: Colors.white,
          elevation: 5,
          title: Text(
            error,
            style: const TextStyle(
              letterSpacing: 2.5,
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Rubik',
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(226, 231, 231, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Icon(
              Icons.place_outlined,
              color: Color(0xFF1B1B1B),
              size: 30,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Lamjung,Nepal",
              style: TextStyle(
                color: Color(0xFF1B1B1B),
                fontFamily: 'Rubik',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8, right: 10),
            child: Container(
              height: 40,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color.fromARGB(157, 27, 27, 27),
                  width: 1.5,
                ),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.history_edu_rounded,
                  size: 25,
                  color: Color(0xFF016FB9),
                ),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Popular Place",
                    style: TextStyle(
                      color: Color(0xFF1B1B1B),
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "See all",
                    style: TextStyle(
                      color: Color(0xFF016FB9),
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.29,
              child: ListView(
                padding: const EdgeInsets.only(bottom: 8),
                controller: pagecontroller,
                scrollDirection: Axis.horizontal,
                children: [
                  PopularPlace(
                    size: size,
                    imagelink: "assets/images/skyhill.jpg",
                    placename: "Suman Kirana and Hotel",
                    placeaddress: "Siundibar, Lamjung",
                    rating: "4.5",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const DetailsPage(
                              placeName: "Suman Kirana and Hotel",
                              placeAddress: "Siundibar, Lamjung",
                              placeRating: "4.5",
                              placeDescription:
                                  "This establishment conveniently combines a grocery store and a hotel,"
                                  " offering a delightful emphasis on breakfast cuisine. Renowned for its "
                                  "affordability and delectable flavors, this place is a go-to destination "
                                  "for those seeking delicious meals. ",
                              imagelink: "assets/images/skyhill.jpg",
                            );
                          },
                        ),
                      );
                    },
                  ),
                  PopularPlace(
                    size: size,
                    imagelink: "assets/images/hillstwo.jpg",
                    placename: "Something mountain",
                    placeaddress: "Bhotewodar, Lamjung",
                    rating: "4.0",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const DetailsPage(
                              placeName: "Something mountain",
                              placeAddress: "Bhotewodar, Lamjung",
                              placeRating: "4.0",
                              placeDescription: "A mountain pic",
                              imagelink: "assets/images/hillstwo.jpg",
                            );
                          },
                        ),
                      );
                    },
                  ),
                  PopularPlace(
                    size: size,
                    imagelink: "assets/images/sky.jpg",
                    placename: "Something sky",
                    placeaddress: "Bhotewodar, Lamjung",
                    rating: "4.4",
                    press: () {},
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Recommendation for you",
                    style: TextStyle(
                      color: Color(0xFF1B1B1B),
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // print(size.height * 0.15);
                  },
                  child: const Text(
                    "See all",
                    style: TextStyle(
                      color: Color(0xFF016FB9),
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
            RecommendationCard(
              size: size,
              imagelink: "assets/images/skyhill.jpg",
              placename: "Something Hills",
              placeaddress: "Lamjung",
              rating: "5.0",
              totalreviews: "100",
              press: () {},
            ),
            // const SizedBox(
            //   height: 15,
            // ),
            RecommendationCard(
              size: size,
              imagelink: "assets/images/sky.jpg",
              placename: "Something Sky",
              placeaddress: "Lamjung",
              rating: "4.4",
              totalreviews: "50",
              press: () {},
            ),
            RecommendationCard(
              size: size,
              imagelink: "assets/images/hillsone.jpg",
              placename: "Something Hill One",
              placeaddress: "Lamjung",
              rating: "3.5",
              totalreviews: "70",
              press: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15,
                bottom: 15,
              ),
              child: Container(
                height: size.height * 0.3,
                width: size.width * 0.98,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(90, 27, 27, 27),
                      blurRadius: 4,
                      offset: Offset(1, 8), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Are we",
                      style: TextStyle(
                        color: Color(0xFF1B1B1B),
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        letterSpacing: 1,
                      ),
                    ),
                    const Text(
                      "missing a place?",
                      style: TextStyle(
                        color: Color(0xFF1B1B1B),
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: size.width * 0.65,
                      height: size.height * 0.08,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AddPlacePage();
                          }));
                          // if (user == null) {
                          //   errorDialog("Please login to add places");
                          // } else {
                          //   errorDialog("Opening");
                          // }
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.add_location_rounded,
                              color: Color(0xFF1B1B1B),
                            ),
                            Text(
                              "Add a missing place",
                              style: TextStyle(
                                color: Color(0xFF1B1B1B),
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
