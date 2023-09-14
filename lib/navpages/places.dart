import 'package:aboutlamjung/navpages/details.dart';
import 'package:aboutlamjung/theme/color.dart';
import 'package:aboutlamjung/theme/texts.dart';
import 'package:aboutlamjung/utils/missingplace.dart';
import 'package:aboutlamjung/utils/recommendationcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class PlacesPage extends StatefulWidget {
  const PlacesPage({super.key});

  @override
  State<PlacesPage> createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  final searchContorller = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchContorller.addListener(() => setState(() {}));
  }

  Widget buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: SizedBox(
        child: TextField(
          controller: searchContorller,
          cursorColor: AppColor.primaryColor,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.fillColor,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            prefixIcon: const Icon(
              Icons.search,
              size: 25,
              color: AppColor.primaryColor,
            ),
            suffixIcon: searchContorller.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColor.primaryColor,
                    ),
                    onPressed: () => searchContorller.clear(),
                  ),
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          style: AppTexts.basicText,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return KeyboardDismisser(
      gestures: const [GestureType.onPanUpdateAnyDirection, GestureType.onTap],
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              const Icon(
                Icons.place,
                color: AppColor.primaryColor,
                size: 30,
              ),
              SizedBox(
                width: size.width * 0.015,
              ),
              const Text(
                "Places",
                style: AppTexts.appbarText,
              ),
            ],
          ),
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSearch(),
              SizedBox(
                height: size.height * 0.01,
              ),
              Flexible(
                  child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("place").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error: ${snapshot.error}",
                        textAlign: TextAlign.justify,
                        style: AppTexts.descriptionText,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index].data();
                      if (searchContorller.text.isEmpty) {
                        return RecommendationCard(
                          size: size,
                          imagelink: "assets/images/sky.jpg",
                          placename: data['placename'].toString(),
                          placeaddress: data['placeaddress'].toString(),
                          rating: data['placerating'].toString(),
                          totalreviews: data['totalreviews'].toString(),
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailsPage(
                                    placeName: data['placename'].toString(),
                                    placeAddress:
                                        data['placeaddress'].toString(),
                                    placeRating: data['placerating'].toString(),
                                    placeDescription:
                                        data['placedescription'].toString(),
                                    imagelink: "assets/images/sky.jpg",
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                      if (data['placename']
                          .toString()
                          .toLowerCase()
                          .startsWith(searchContorller.text.toLowerCase())) {
                        return RecommendationCard(
                          size: size,
                          imagelink: "assets/images/sky.jpg",
                          placename: data['placename'].toString(),
                          placeaddress: data['placeaddress'].toString(),
                          rating: data['placerating'],
                          totalreviews: data['totalreviews'].toString(),
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailsPage(
                                    placeName: data['placename'].toString(),
                                    placeAddress:
                                        data['placeaddress'].toString(),
                                    placeRating: data['placerating'].toString(),
                                    placeDescription:
                                        data['placedescription'].toString(),
                                    imagelink: "assets/images/sky.jpg",
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                      if (index == snapshot.data!.docs.length - 1) {
                        return Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              const MissingPlace(),
                            ],
                          ),
                        );
                      }
                      return Container();
                    },
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
