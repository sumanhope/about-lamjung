import 'package:aboutlamjung/landing.dart';
import 'package:aboutlamjung/theme/color.dart';
import 'package:aboutlamjung/theme/texts.dart';
import 'package:aboutlamjung/user/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

/// white: const Color(0xE9F1F3F4)
/// black: const Color(0xFF1B1B1B)
class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  String password = "";
  bool isPasswordVisible = false;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
    usernameController.addListener(() => setState(() {}));
  }

  Future errorDialog(String error) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          backgroundColor: Colors.white,
          elevation: 5,
          title: Text(
            error,
            style: const TextStyle(
              letterSpacing: 2.5,
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Rubik',
            ),
          ),
        );
      },
    );
  }

  Future signUp(String email, String pass, String name) async {
    try {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      final User user = auth.currentUser!;
      final uid = user.uid;
      // String dateStr = "${today.day}-${today.month}-${today.year}";

      //debugPrint(dateStr);
      FirebaseFirestore.instance.collection('users').doc(uid).set({
        'UserId': uid,
        'username': name,
        'email': email,
        'profile': ''
      }).then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LandingPage(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      errorDialog(e.toString());
    }
  }

  Widget buildEmail(TextEditingController controller, String hinttext,
      IconData icon, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: SizedBox(
        child: TextField(
          controller: controller,
          cursorColor: AppColor.primaryColor,
          decoration: InputDecoration(
            filled: true,
            hintText: hinttext,
            fillColor: AppColor.fillColor,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            prefixIcon: Icon(
              icon,
              size: 25,
              color: AppColor.primaryColor,
            ),
            suffixIcon: controller.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColor.primaryColor,
                    ),
                    onPressed: () => controller.clear(),
                  ),
          ),
          keyboardType: type,
          textInputAction: TextInputAction.next,
          style: AppTexts.basicText,
        ),
      ),
    );
  }

  Widget buildPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: SizedBox(
        child: TextField(
          onChanged: (value) => setState(() {
            password = value;
          }),
          cursorColor: AppColor.primaryColor,
          decoration: InputDecoration(
            filled: true,
            hintText: "Password",

            fillColor: AppColor.fillColor,
            // enabledBorder: InputBorder.none,
            // focusedBorder: InputBorder.none,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            prefixIcon: const Icon(
              Icons.key,
              size: 25,
              color: AppColor.primaryColor,
            ),
            suffixIcon: IconButton(
              icon: isPasswordVisible
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onPressed: () =>
                  setState(() => isPasswordVisible = !isPasswordVisible),
              color: AppColor.primaryColor,
            ),
          ),
          obscureText: isPasswordVisible,
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
      gestures: const [GestureType.onTap, GestureType.onPanUpdateDownDirection],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 0,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: ClipPath(
                      clipper: OvalBottomBorderClipper(),
                      child: Container(
                        color: AppColor.primaryColor,
                        height: 110,
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: OvalBottomBorderClipper(),
                    child: Container(
                      color: AppColor.primaryColor,
                      height: 100,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              const Text(
                "Register Account",
                style: AppTexts.bigText,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              buildEmail(
                emailController,
                "Email",
                Icons.email,
                TextInputType.emailAddress,
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              buildEmail(
                usernameController,
                "Username",
                Icons.person,
                TextInputType.text,
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              buildPassword(),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              SizedBox(
                width: 270,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if (usernameController.text.trim().isNotEmpty &&
                        emailController.text.trim().isNotEmpty &&
                        password.isNotEmpty) {
                      signUp(
                        emailController.text,
                        password,
                        usernameController.text,
                      );
                    } else {
                      errorDialog("Please fill all details");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B1B1B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have a account?",
                    style: TextStyle(
                      color: Color(0xFF1B1B1B),
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const LoginPage();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xFF016FB9),
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
