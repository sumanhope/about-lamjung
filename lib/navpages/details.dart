import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(226, 231, 231, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 65,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
              child: Container(
                height: 45,
                width: 49,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color.fromARGB(157, 27, 27, 27),
                    width: 1.5,
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.only(left: 10),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                    color: Color(0xFF016FB9),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 45,
            ),
            const Text(
              "Destination Details ",
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
            padding: const EdgeInsets.only(top: 10.0, bottom: 10, right: 10),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color.fromARGB(157, 27, 27, 27),
                  width: 1.5,
                ),
              ),
              child: IconButton(
                padding: EdgeInsets.only(right: 1),
                icon: const Icon(
                  Icons.bookmark_border_outlined,
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
          children: [
            Container(
              height: size.height * 0.4,
              width: size.width,
              color: Colors.teal,
            ),
            Container(
              width: size.width,
              color: Colors.red,
              child: Column(
                children: [
                  Container(
                    child: Text("Suman Kirana and Hotel"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
