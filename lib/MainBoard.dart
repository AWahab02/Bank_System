import 'dart:developer';

import 'package:bank_system/Bill_Payment.dart';
import 'package:bank_system/Deposit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Transfer.dart';
import 'Settings.dart';
import 'widgets/custom_widget.dart';
import 'dart:developer';


final usersRef = FirebaseFirestore.instance.collection('Account');

class MainBoard extends StatefulWidget {

  final String email;
  final String uID;

  const MainBoard({Key? key, required this.email, required this.uID}) : super(key: key);



  @override
  _MainBoardState createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {

  double opacity_t = 1.0;
  double opacity_b = 1.0;
  double opacity_d = 1.0;
  double opacity_s = 1.0;


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
    getUsersById();
    super.initState();
  }

  getUsersById()
  {

  }

  @override
  Widget build(BuildContext context) {

    //var query = FirebaseFirestore.instance.collection("Account").where("Email", isEqualTo: "awzahid02@gmail.com").snapshots();
    var query = FirebaseFirestore.instance.collection("Account").where("email", isEqualTo: "awzahid02@gmail.com").get();
    return Scaffold(
      backgroundColor: const Color(0xff041f4a),
      appBar: AppBar(
        backgroundColor: const Color(0xff00102a),
        title: Text('Dashboard')
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top:50, bottom: 30, left: 30, right: 30),
          child: Column(
            children: [
              Container(
                width: 350,
                height: 200,
                //color: Color(0xff00102a),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  color: const Color(0xff00102a),
                  borderRadius: BorderRadius.circular(90),
                ),

                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("Account").doc(widget.uID).snapshots(),
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                return Text( "${snapshot.data!.get("fName").toString()}",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                );
                              }
                              return const Text("Not Available");
                            }
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
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("Account").doc(widget.uID).snapshots(),
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                return Text( "${snapshot.data!.get("Balance").toString()} Rs",
                                style: GoogleFonts.montserrat(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                              );
                              }
                              return const Text("Not Available");
                            }
                          ),
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
                        handletimeout_s();
                      },
                      child: const CustomWidget(name: "Transfer", image: "assets/transfer.png",),
                    ),
                    CupertinoButton(
                        child: const CustomWidget(name: "Bill Payment", image: "assets/dollar.png",),
                        onPressed: (){
                      handletimeout_b();
                    })
                  ],
                ),
              ),
              Center(
                child: Row(
                  children: [

                    CupertinoButton(
                      onPressed: (){
                        handletimeout_d();
                      },
                      child: const CustomWidget(name: "Deposit", image: "assets/card.png",),
                    ),
                    CupertinoButton(
                        child: const CustomWidget(name: "Settings", image: "assets/settings.png"),
                        onPressed: (){
                          handletimeout_se();
                        })



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






