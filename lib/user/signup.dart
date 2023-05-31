import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
    usernameController.addListener(() => setState(() {}));
  }

  Widget buildEmail(
      TextEditingController which, IconData icon, TextInputType keyboard) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: SizedBox(
        child: TextField(
          controller: which,
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
            prefixIcon: Icon(
              icon,
              size: 25,
              color: const Color(0xFF1B1B1B),
            ),
            suffixIcon: which.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFF1B1B1B),
                    ),
                    onPressed: () => usernameController.clear(),
                  ),
          ),
          keyboardType: keyboard,
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
    //final size = MediaQuery.of(context).size;
    return Scaffold(
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
                "Sign Up",
                style: TextStyle(
                  color: Color(0xFF1B1B1B),
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 50,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                top: 50,
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
            buildEmail(
              emailController,
              Icons.email,
              TextInputType.emailAddress,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                top: 10,
              ),
              child: Text(
                "Username",
                style: TextStyle(
                  color: Color(0xFF1B1B1B),
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 20,
                ),
              ),
            ),
            buildEmail(
              usernameController,
              Icons.person,
              TextInputType.text,
            ),
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
                  onPressed: () {},
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 20),
              child: Row(
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
                        onPressed: () {},
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
            ),
          ],
        ),
      ),
    );
  }
}
