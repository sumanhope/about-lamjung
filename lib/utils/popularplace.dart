import 'package:flutter/material.dart';

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
              Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 2,top:4),
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
                      padding: const EdgeInsets.only(left: 10.0, bottom: 5),
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
            ],
          ),
        ),
      ),
    );
  }
}
