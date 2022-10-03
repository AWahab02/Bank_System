import 'dart:async';
import 'package:bank_system/Bill_Payment.dart';
import 'package:bank_system/Deposit.dart';
import 'package:bank_system/Login_success.dart';
import 'package:bank_system/MainBoard.dart';
import 'package:bank_system/registration_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bank_system/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_check/animated_check.dart';
import 'login_page.dart';
import 'Transfer.dart';
import 'main.dart';
import 'Settings.dart';

final db = FirebaseFirestore.instance.collection('Account');

class MainBoard extends StatefulWidget {
  const MainBoard({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  _MainBoardState createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  double opacity_t = 1.0;
  double opacity_b = 1.0;
  double opacity_d = 1.0;
  double opacity_s = 1.0;

  getUserbyId() {
    final String id = "VHRxgyYubY8SyLCPtU9w";
    db.doc(id).get().then((DocumentSnapshot doc) {
      print(doc.data());
      print(doc.id);
      print(doc.exists);
    });
  }

  void handletimeout_s() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Transfer()));
  }

  void handletimeout_b() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Bill_Payment()));
  }

  void handletimeout_d() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Deposit()));
  }

  void handletimeout_se() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Settingss()));
  }

  @override
  void initState() {
    getUserbyId();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff041f4a),
      appBar: AppBar(
        backgroundColor: const Color(0xff00102a),
        title: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Account')
              .doc("VHRxgyYubY8SyLCPtU9w")
              .snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Text(
                snapshot.data!.get('Name'),
              );
            }
            return Text("User");

          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Container(
                width: 350,
                height: 200,
                //color: Color(0xff00102a),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  color: Color(0xff00102a),
                  borderRadius: BorderRadius.circular(90),
                ),

                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Username',
                          style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 30, top: 10),
                            child: Text(
                              'Balance:',
                              style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, top: 10),
                          child: Text('6700.00 Rs',
                              style: GoogleFonts.montserrat(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                          ),
                          onPressed: null,
                          child: Text(
                            'Add money',
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Row(
                  children: [
                    CupertinoButton(
                      onPressed: (){
                        handletimeout_b();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          width: 130,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Color(0xff00102a),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Image(
                                      image:
                                          AssetImage('assets/transfer.png'),
                                      width: 70,
                                    )),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text('Transfer',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        opacity_b = 0.4;

                        setState(() {});

                        Timer(Duration(milliseconds: 400), handletimeout_b);
                      },
                      onTapCancel: () {
                        opacity_b = 1.0;
                        setState(() {});
                      },
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: opacity_b,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30, left: 10),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Color(0xff00102a),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 30),
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Image(
                                        image: AssetImage('assets/dollar.png'),
                                        width: 70,
                                      )),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text('Bill Payment',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        opacity_d = 0.4;

                        setState(() {});

                        Timer(Duration(milliseconds: 400), handletimeout_d);
                      },
                      onTapCancel: () {
                        opacity_d = 1.0;
                        setState(() {});
                      },
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: opacity_d,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Color(0xff00102a),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 30),
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Image(
                                        image: AssetImage('assets/card.png'),
                                        width: 70,
                                      )),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text('Deposit',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        opacity_s = 0.4;
                        setState(() {});
                        Timer(Duration(milliseconds: 400), handletimeout_se);
                      },
                      onTapCancel: () {
                        opacity_s = 1.0;
                        setState(() {});
                      },
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: opacity_s,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Color(0xff00102a),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 30),
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Image(
                                        image:
                                            AssetImage('assets/settings.png'),
                                        width: 70,
                                      )),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text('Settings',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
