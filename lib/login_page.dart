import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bank_system/PasswordResetPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login_success.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
late bool _success;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  String user_doc_id = "";

  Future signIn() async {
    try {
      setState(() {
        isLoading = true;
      });
      final User? user =
          (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ))
              .user;

      if (user != null) {
        setState(() {
          //user_doc_id=FirebaseFirestore.instance.collection('Account').where()
          _success = true;
          isLoading = false;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Login_Success(
                  email: _emailController.text, userId: user.uid)));
        });
      } else {
        _success = false;
      }
    } catch (e) {
      setState(() {
        _success = false;
        isLoading = false;
      });
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Login Error',
          message: e.toString(),
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(14.0),
            child: Center(
              child: Image(
                image: AssetImage('assets/apex.png'),
                width: 230,
              ),
            ),
          ),
          Center(
              child: Text(
            'ATLAS Banking',
            style: GoogleFonts.montserrat(
                fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
          )),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 20),
            child: Text(
              'Login to your account.',
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35, left: 10),
            child: TextField(
              controller: _emailController,
              obscureText: false,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.mail, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.password, color: Colors.white),
              ),
            ),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: signIn,
                          style: ElevatedButton.styleFrom(),
                          child: Text(
                            'Login',
                            style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      )),
                ),


          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ResetPassword()));
                },
                child: Text('Forgot Password?',
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Registration_page()));
                },
                child: Text('Dont have an account? Sign Up',
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
