import 'package:aboutlamjung/theme/color.dart';
import 'package:aboutlamjung/theme/texts.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    super.key,
    required this.placeName,
    required this.placeAddress,
    required this.placeRating,
    required this.placeDescription,
    required this.imagelink,
  });
  final String placeName;
  final String placeAddress;
  final String placeRating;
  final String placeDescription;
  final String imagelink;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isBookmarked = false;
  void addBookmark() {
    if (isBookmarked) {
      isBookmarked = false;
    } else {
      isBookmarked = true;
    }
    setState(() {});
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
                                  widget.placeAddress,
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
                              const Text(
                                "6am - 8pm",
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
                                    widget.placeRating,
                                    style: AppTexts.basicText,
                                  ),
                                  const Text(
                                    "(125 reviews)",
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
                        child: Text(widget.placeDescription,
                            textAlign: TextAlign.justify,
                            softWrap: true,
                            style: AppTexts.descriptionText),
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Contact them",
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
                            "${widget.placeName}, ${widget.placeAddress}");
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
