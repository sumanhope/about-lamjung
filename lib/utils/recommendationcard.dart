import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
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
      child: InkWell(
        onTap: press,
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
      ),
    );
  }
}
