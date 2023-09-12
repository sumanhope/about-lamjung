import 'package:aboutlamjung/onboard/onboarding.dart';
import 'package:aboutlamjung/user/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  String _uid = "";
  String username = "Loading";
  String email = "Loading";

  @override
  void initState() {
    super.initState();

    if (user == null) {
    } else {
      getData();
    }
  }

  void getData() async {
    _uid = user!.uid;

    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      username = userDoc.get('username');
      email = userDoc.get('email');
    });
    //print(username);
  }

  showWidget(final size) {
    if (user == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Container(
          width: size.width * 0.9,
          height: size.height * 0.22,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(90, 27, 27, 27),
                blurRadius: 3,
                offset: Offset(1, 5), // Shadow position
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 15.0, left: 15, right: 15),
                child: Text(
                  "Log in to add place, leave review, give rating and access bookmarks.",
                  style: TextStyle(
                    color: Color(0xFF1B1B1B),
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: size.width * 0.7,
                  height: size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B1B1B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Color(0xFFF1F3F4),
                        fontFamily: 'Rubik',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return ProfileMenu(
        text: username,
        firsticon: Icons.person,
        secondicon: Icons.arrow_forward_ios_rounded,
        press: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(226, 231, 231, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Color(0xFF1B1B1B),
            fontFamily: 'Rubik',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 1,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 6, bottom: 6),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage("assets/images/defaultprofile.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
        elevation: 0,
        //backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          showWidget(size),
          ProfileMenu(
            text: "Preferences",
            firsticon: Icons.settings_rounded,
            secondicon: Icons.arrow_forward_ios_rounded,
            press: () {},
          ),
          if (user != null)
            ProfileMenu(
              text: "Bookmarks",
              firsticon: Icons.bookmark,
              secondicon: Icons.arrow_forward_ios_rounded,
              press: () {},
            ),
          if (user != null)
            ProfileMenu(
              text: "Add Place",
              firsticon: Icons.add_box,
              secondicon: Icons.arrow_forward_ios_rounded,
              press: () {},
            ),
          if (user != null)
            ProfileMenu(
              text: "Logout",
              firsticon: Icons.logout_rounded,
              secondicon: Icons.arrow_forward_ios_rounded,
              press: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnboardingScreen(),
                    ),
                  );
                });
              },
            ),
          ProfileMenu(
            text: "Support",
            firsticon: Icons.help_rounded,
            secondicon: Icons.arrow_forward_ios_rounded,
            press: () {},
          ),
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  final String text;
  final IconData firsticon, secondicon;
  final VoidCallback press;
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.firsticon,
    required this.secondicon,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          shadowColor: const Color.fromARGB(181, 27, 27, 27),
          elevation: 5,
          backgroundColor: Colors.white,
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              firsticon,
              size: 25,
              color: const Color(0xFF1B1B1B),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF1B1B1B),
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const Spacer(),
            Icon(
              secondicon,
              size: 20,
              color: const Color(0xFF1B1B1B),
            ),
          ],
        ),
      ),
    );
  }
}
