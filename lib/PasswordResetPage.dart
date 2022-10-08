import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final auth = FirebaseAuth.instance;
  var isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff041f4a),
      appBar: AppBar(
        backgroundColor: const Color(0xff00102a),
        title: const Text('Reset Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
        [

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

          Center(
              child: Text(
                'Password Reset',
                style: GoogleFonts.montserrat(
                    fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              )),

          Padding(
            padding: const EdgeInsets.only(top: 35, left: 10),
            child: TextField
              (
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

          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Center(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: (){auth.sendPasswordResetEmail(email: _emailController.text);
                      Navigator.of(context)
                      .pop();
                      },
                    style: ElevatedButton.styleFrom(),
                    child: Text(
                      'Send Request',
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )),
          ),

        ]
      ),
    );
  }
}
