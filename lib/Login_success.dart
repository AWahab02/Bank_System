import 'dart:async';
import 'package:bank_system/MainBoard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_check/animated_check.dart';

class Login_Success extends StatefulWidget {
  const Login_Success({Key? key, required this.email, required this.userId})
      : super(key: key);

  final String email;
  final String userId;

  @override
  _Login_SuccessState createState() => _Login_SuccessState();
}

class _Login_SuccessState extends State<Login_Success>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutCirc));

    _showCheck();

    Timer(const Duration(seconds: 2), handletimeout);
  }

  void handletimeout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MainBoard(email: widget.email, uID: widget.userId),
      ),
    );
  }

  void _showCheck() {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff041f4a),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedCheck(
              progress: _animation,
              size: 200,
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Login Succesful',
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ), //child: Text('Registration succesful', style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
