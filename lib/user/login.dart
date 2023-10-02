import 'package:aboutlamjung/landing.dart';
import 'package:aboutlamjung/theme/color.dart';
import 'package:aboutlamjung/theme/texts.dart';
import 'package:aboutlamjung/user/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  String password = "";
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
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

  Future signIn(String useremail) async {
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
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: useremail, password: password)
          .then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LandingPage(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        errorDialog("Email or password is incorrect");
      } else if (e.code == 'wrong-password') {
        errorDialog("Email or passoword is incorrect.");
      } else if (e.code == 'invalid-email') {
        errorDialog("The email address is badly formatted");
      } else {
        errorDialog(e.toString());
      }
    }
  }

  Widget buildEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: SizedBox(
        child: TextField(
          controller: emailController,
          cursorColor: AppColor.primaryColor,
          decoration: InputDecoration(
            filled: true,
            hintText: "Username",
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
            prefixIcon: const Icon(
              Icons.person,
              size: 25,
              color: AppColor.primaryColor,
            ),
            suffixIcon: emailController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColor.primaryColor,
                    ),
                    onPressed: () => emailController.clear(),
                  ),
          ),
          keyboardType: TextInputType.emailAddress,
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
                      clipper: WaveClipperTwo(),
                      child: Container(
                        color: AppColor.primaryColor,
                        height: 160,
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: WaveClipperTwo(),
                    child: Container(
                      color: AppColor.primaryColor,
                      height: 140,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              const Text(
                "Welcome Back",
                style: AppTexts.bigText,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              buildEmail(),
              SizedBox(
                height: size.height * 0.015,
              ),
              buildPassword(),
              // SizedBox(
              //   height: size.height * 0.01,
              // ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text(
                      'Forgot Password?',
                      style: AppTexts.bluedescriptionText,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 270,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if (emailController.text.trim().isNotEmpty &&
                          password.isNotEmpty) {
                        signIn(emailController.text.trim());
                      } else {
                        errorDialog("Please fill all fields");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B1B1B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have a account?",
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
                                return const SignUpPage();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Color(0xFF016FB9),
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    )
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
