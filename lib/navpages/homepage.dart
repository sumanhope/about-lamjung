import 'package:aboutlamjung/navpages/addplace.dart';
import 'package:aboutlamjung/navpages/details.dart';
import 'package:aboutlamjung/theme/color.dart';
import 'package:aboutlamjung/theme/texts.dart';
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
            style: AppTexts.basicText,
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
              color: AppColor.primaryColor,
              size: 30,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Lamjung,Nepal",
              style: AppTexts.appbarText,
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
                  color: AppColor.shadowColor,
                  width: 1.5,
                ),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.history_edu_rounded,
                  size: 25,
                  color: AppColor.secondaryColor,
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
            SizedBox(height: size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Popular Place",
                    style: AppTexts.basicText,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "See all",
                    style: AppTexts.bluedescriptionText,
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
                    style: AppTexts.basicText,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // print(size.height * 0.15);
                  },
                  child: const Text(
                    "See all",
                    style: AppTexts.bluedescriptionText,
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
                      color: AppColor.shadowColor,
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
                      style: AppTexts.bigText,
                    ),
                    const Text(
                      "missing a place?",
                      style: AppTexts.bigText,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
                      width: size.width * 0.65,
                      height: size.height * 0.08,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const AddPlacePage();
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
                              color: AppColor.primaryColor,
                            ),
                            Text(
                              "Add a missing place",
                              style: AppTexts.basicText,
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
