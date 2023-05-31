import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pagecontroller = ScrollController();
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
              width: 2,
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
                    placename: "Something Hills",
                    placeaddress: "Bhotewodar, Lamjung",
                    rating: "5.0",
                    press: () {},
                  ),
                  PopularPlace(
                    size: size,
                    imagelink: "assets/images/hillstwo.jpg",
                    placename: "Something mountain",
                    placeaddress: "Bhotewodar, Lamjung",
                    rating: "4.0",
                    press: () {},
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
                    "Recomendation for you",
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
            RecomendationCard(
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
            RecomendationCard(
              size: size,
              imagelink: "assets/images/sky.jpg",
              placename: "Something Sky",
              placeaddress: "Lamjung",
              rating: "4.4",
              totalreviews: "50",
              press: () {},
            ),
            RecomendationCard(
              size: size,
              imagelink: "assets/images/hillsone.jpg",
              placename: "Something Hill One",
              placeaddress: "Lamjung",
              rating: "3.5",
              totalreviews: "70",
              press: () {},
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

class RecomendationCard extends StatelessWidget {
  const RecomendationCard({
    super.key,
    required this.size,
    required this.imagelink,
    required this.placename,
    required this.placeaddress,
    required this.rating,
    required this.totalreviews,
    required this.press,
  });

  final Size size;
  final String imagelink;
  final String placename;
  final String placeaddress;
  final String rating;
  final String totalreviews;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10,
        bottom: 15,
      ),
      child: Container(
        height: size.height * 0.15,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(90, 27, 27, 27),
              blurRadius: 4,
              offset: Offset(1, 8), // Shadow position
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width * 0.25,
                height: size.height * 0.14,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagelink),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.48,
                  child: Text(
                    placename,
                    style: const TextStyle(
                      color: Color(0xFF1B1B1B),
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 1),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.place_rounded,
                        size: 18,
                        color: Color(0xFF1B1B1B),
                      ),
                      SizedBox(
                        width: size.width * 0.48,
                        child: Text(
                          " $placeaddress",
                          style: const TextStyle(
                            color: Color(0xFF1B1B1B),
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0, bottom: 0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 18,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: size.width * 0.48,
                        child: Text(
                          " $rating ($totalreviews reviews)",
                          style: const TextStyle(
                            color: Color(0xFF1B1B1B),
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color.fromARGB(157, 27, 27, 27),
                    width: 1.5,
                  ),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xFF016FB9),
                    size: 18,
                  ),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PopularPlace extends StatelessWidget {
  const PopularPlace({
    super.key,
    required this.size,
    required this.press,
    required this.placename,
    required this.placeaddress,
    required this.rating,
    required this.imagelink,
  });

  final Size size;
  final VoidCallback press;
  final String placename;
  final String placeaddress;
  final String rating;
  final String imagelink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10,
      ),
      child: InkWell(
        onTap: press,
        child: Container(
          height: size.height * 0.26,
          width: size.width * 0.75,
          decoration: BoxDecoration(
            //color: Colors.red,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(imagelink),
              fit: BoxFit.cover,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(90, 27, 27, 27),
                blurRadius: 4,
                offset: Offset(1, 8), // Shadow position
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 2),
                child: Text(
                  placename,
                  style: const TextStyle(
                    color: Color(0xFFF1F3F4),
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.place_rounded,
                      size: 20,
                      color: Color(0xFFF1F3F4),
                    ),
                    SizedBox(
                      width: size.width * 0.52,
                      child: Text(
                        placeaddress,
                        style: const TextStyle(
                          color: Color(0xFFF1F3F4),
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.star_rounded,
                      size: 25,
                      color: Colors.amberAccent,
                      //color: Color(0xFFF1F3F4),
                    ),
                    Text(
                      rating,
                      style: const TextStyle(
                        color: Color(0xFFF1F3F4),
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
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
