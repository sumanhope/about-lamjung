import 'package:aboutlamjung/theme/color.dart';
import 'package:aboutlamjung/theme/texts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:maps_launcher/maps_launcher.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    super.key,
    required this.placeName,
    required this.imagelink,
    required this.placeid,
  });
  final String placeName;
  final String placeid;
  final String imagelink;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isBookmarked = false;
  String placeaddress = "";
  String opentime = "";
  String rating = "0";
  String placedescription = "";
  String totalreviews = "0";

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    final DocumentSnapshot placeDoc = await FirebaseFirestore.instance
        .collection('place')
        .doc(widget.placeid)
        .get();

    setState(() {
      placeaddress = placeDoc.get('placeaddress');
      opentime = placeDoc.get('opentime');
      rating = placeDoc.get('averagerating').toString();
      placedescription = placeDoc.get('placedescription');
      totalreviews = placeDoc.get('totalreviews').toString();
    });
  }

  void addBookmark() {
    if (isBookmarked) {
      isBookmarked = false;
    } else {
      isBookmarked = true;
    }
    setState(() {});
  }

  void addRatingToPlace(String placeId, double newRating) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentReference placeRef =
        firestore.collection('place').doc(placeId);

    // Retrieve the existing data for the place
    DocumentSnapshot placeSnapshot = await placeRef.get();
    Map<String, dynamic> placeData =
        placeSnapshot.data() as Map<String, dynamic>;

    // Extract the existing ratings and total reviews
    List<dynamic> existingRatings = placeData['placerating'];
    int totalReviews = placeData['totalreviews'];

    // Add the new rating to the 'placerating' list
    existingRatings.add(newRating);

    // Calculate the new average rating
    double newAverageRating =
        (existingRatings.reduce((a, b) => a + b) / (totalReviews + 1))
            .toDouble();

    // Update the 'placerating' and 'totalreviews' fields
    await placeRef.update({
      'placerating': existingRatings,
      'totalreviews': totalReviews + 1,
      'averagerating': newAverageRating, // Optionally store the average rating
    });

    print('Rating added successfully');
  }

  Future errorDialog(double rating, Size size) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          backgroundColor: AppColor.selectedItemColor,
          elevation: 5,
          title: Text(
            "Submit your rating of $rating?",
            style: AppTexts.basicText,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: size.height * 0.07,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.shadowColor,
                        blurRadius: 4,
                        offset: Offset(1, 8), // Shadow position
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: AppTexts.whitebasicText,
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.07,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.shadowColor,
                        blurRadius: 4,
                        offset: Offset(1, 8), // Shadow position
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      addRatingToPlace(widget.placeid, rating);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: AppTexts.whitebasicText,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Future reviewdialog(Size size) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            backgroundColor: AppColor.selectedItemColor,
            elevation: 5,
            content: Container(
              height: size.height * 0.15,
              width: size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Rate this place.",
                    style: AppTexts.appbarText,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  RatingBar.builder(
                    minRating: 1,
                    maxRating: 5,
                    allowHalfRating: true,
                    unratedColor: AppColor.shadowColor,
                    itemBuilder: (context, _) {
                      return const Icon(
                        Icons.star,
                        color: Colors.amber,
                      );
                    },
                    onRatingUpdate: (rating) {
                      Navigator.pop(context);
                      errorDialog(rating, size);
                    },
                  ),
                ],
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFE2E7E7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 65,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10, bottom: 10),
          child: Container(
            height: 45,
            width: 49,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColor.shadowColor,
                width: 1.5,
              ),
            ),
            child: IconButton(
              padding: const EdgeInsets.only(left: 10),
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 25,
                color: AppColor.secondaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: const Text(
          "Destination Details",
          style: AppTexts.appbarText,
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10, right: 10),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColor.shadowColor,
                  width: 1.5,
                ),
              ),
              child: IconButton(
                padding: const EdgeInsets.only(right: 1),
                icon: Icon(
                  isBookmarked
                      ? Icons.bookmark
                      : Icons.bookmark_border_outlined,
                  size: 25,
                  color: AppColor.secondaryColor,
                ),
                onPressed: () {
                  addBookmark();
                },
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: size.height * 0.35,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.imagelink),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.shadowColor,
                            blurRadius: 4,
                            offset: Offset(1, 8), // Shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 15),
                            child: Text(
                              widget.placeName,
                              style: AppTexts.headerText,
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8, left: 10),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.place,
                                  size: 25,
                                ),
                                Text(
                                  placeaddress,
                                  style: AppTexts.basicText,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: size.height * 0.1,
                          width: size.width * 0.45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.schedule_rounded),
                                  SizedBox(
                                    width: size.width * 0.01,
                                  ),
                                  const Text(
                                    "Open",
                                    style: AppTexts.basicText,
                                  ),
                                ],
                              ),
                              Text(
                                opentime,
                                style: AppTexts.basicText,
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: size.height * 0.1,
                          width: size.width * 0.45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.01,
                                  ),
                                  const Text(
                                    "Ratings",
                                    style: AppTexts.basicText,
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    rating,
                                    style: AppTexts.basicText,
                                  ),
                                  Text(
                                    "($totalreviews reviews)",
                                    style: AppTexts.reviewText,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      height: size.height * 0.18,
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.shadowColor,
                            blurRadius: 4,
                            offset: Offset(1, 8), // Shadow position
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, right: 12, top: 8, bottom: 8),
                        child: Text(
                          placedescription,
                          textAlign: TextAlign.justify,
                          softWrap: true,
                          style: AppTexts.descriptionText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: size.height * 0.08,
                    width: size.width * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColor.shadowColor,
                          blurRadius: 4,
                          offset: Offset(1, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        reviewdialog(size);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Rate them",
                        style: AppTexts.whitebasicText,
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.08,
                    width: size.width * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColor.shadowColor,
                          blurRadius: 4,
                          offset: Offset(1, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        MapsLauncher.launchQuery(
                            "${widget.placeName}, $placeaddress");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "View on map",
                        style: AppTexts.whitebasicText,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
