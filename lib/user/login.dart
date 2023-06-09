import 'package:aboutlamjung/landing.dart';
import 'package:aboutlamjung/user/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          cursorColor: const Color(0xFF1B1B1B),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFD2E1DC),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              gapPadding: 4,
            ),
            prefixIcon: const Icon(
              Icons.email,
              size: 25,
              color: Color(0xFF1B1B1B),
            ),
            suffixIcon: emailController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFF1B1B1B),
                    ),
                    onPressed: () => emailController.clear(),
                  ),
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
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

  Widget buildPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: SizedBox(
        child: TextField(
          onChanged: (value) => setState(() {
            password = value;
          }),
          cursorColor: const Color(0xFF1B1B1B),
          decoration: InputDecoration(
            filled: true,

            fillColor: const Color(0xFFD2E1DC),
            // enabledBorder: InputBorder.none,
            // focusedBorder: InputBorder.none,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              gapPadding: 4,
            ),
            prefixIcon: const Icon(
              Icons.key,
              size: 25,
              color: Color(0xFF1B1B1B),
            ),
            suffixIcon: IconButton(
              icon: isPasswordVisible
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onPressed: () =>
                  setState(() => isPasswordVisible = !isPasswordVisible),
              color: const Color(0xFF1B1B1B),
            ),
          ),
          obscureText: isPasswordVisible,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD2E1DC),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF016FB9),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Text(
                  "Hello Again!",
                  style: TextStyle(
                    color: Color(0xFF1B1B1B),
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 40,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    color: Color(0xFF1B1B1B),
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 30,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Text(
                  "back",
                  style: TextStyle(
                    color: Color(0xFF1B1B1B),
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 30,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  top: 30,
                ),
                child: Text(
                  "Email",
                  style: TextStyle(
                    color: Color(0xFF1B1B1B),
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 20,
                  ),
                ),
              ),
              buildEmail(),
              const Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  top: 10,
                ),
                child: Text(
                  "Password",
                  style: TextStyle(
                    color: Color(0xFF1B1B1B),
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 20,
                  ),
                ),
              ),
              buildPassword(),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 270,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      signIn(emailController.text.trim());
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
