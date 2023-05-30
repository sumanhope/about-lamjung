import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(233, 241, 243, 244),
      appBar: AppBar(
        // centerTitle: true,
        // leading: Icon(Icons.place_sharp),
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
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF1B1B1B),
                  width: 2,
                ),
              ),
              child: IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.bell,
                  color: Color(0xFF1B1B1B),
                ),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
