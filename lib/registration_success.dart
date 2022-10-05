import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_check/animated_check.dart';

class Reg_success extends StatefulWidget {
  const Reg_success({Key? key}) : super(key: key);

  @override
  _Reg_successState createState() => _Reg_successState();
}

class _Reg_successState extends State<Reg_success>
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
    Navigator.pop(context);
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
            Container(
                child: AnimatedCheck(
              progress: _animation,
              size: 200,
            )),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Registration Succesful',
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
