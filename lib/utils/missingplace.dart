import 'package:aboutlamjung/navpages/addplace.dart';
import 'package:aboutlamjung/theme/color.dart';
import 'package:flutter/material.dart';

class MissingPlace extends StatelessWidget {
  const MissingPlace({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                      color: AppColor.primaryColor,
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
    );
  }
}
