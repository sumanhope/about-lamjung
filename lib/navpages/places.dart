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
          cursorColor: const Color(0xFF1B1B1B),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFD2E1DC),
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
              color: Color(0xFF1B1B1B),
            ),
            suffixIcon: searchContorller.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFF1B1B1B),
                    ),
                    onPressed: () => searchContorller.clear(),
                  ),
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          style: const TextStyle(
            color: Color(0xFF1B1B1B),
            fontFamily: 'Rubik',
            letterSpacing: 1,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
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
        backgroundColor: const Color.fromRGBO(226, 231, 231, 1),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: const Row(
            children: [
              Icon(
                Icons.place,
                color: Color(0xFF1B1B1B),
                size: 30,
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                "Places",
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
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearch(),
            SizedBox(
              height: size.height * 0.07,
              child: ListView(
                padding: const EdgeInsets.only(bottom: 8),
                scrollDirection: Axis.horizontal,
                children: [
                  FilterOption(
                    size: size,
                    option: "Shops",
                  ),
                  FilterOption(
                    size: size,
                    option: "Hotels",
                  ),
                  FilterOption(
                    size: size,
                    option: "Restaurants",
                  ),
                  FilterOption(
                    size: size,
                    option: "Education",
                  ),
                  FilterOption(
                    size: size,
                    option: "Hospitals",
                  ),
                  FilterOption(
                    size: size,
                    option: "Temples",
                  ),
                  FilterOption(
                    size: size,
                    option: "Places",
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterOption extends StatelessWidget {
  const FilterOption({
    super.key,
    required this.size,
    required this.option,
  });

  final Size size;
  final String option;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Container(
        height: size.height * 0.056,
        width: size.width * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(90, 27, 27, 27),
              blurRadius: 2,
              offset: Offset(1, 3), // Shadow position
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            option,
            style: const TextStyle(
              color: Color(0xFF1B1B1B),
              fontFamily: 'Rubik',
              fontWeight: FontWeight.bold,
              fontSize: 17,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
