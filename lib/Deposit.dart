import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Deposit extends StatefulWidget {
  const Deposit({Key? key}) : super(key: key);

  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {

  final TextEditingController _depositAmount = TextEditingController();

  void deposit(){

    
    final num deposition=int.parse(_depositAmount.text);

    FirebaseFirestore.instance.collection("Account").doc("rqDTzwDqIVgQmZHrUc3rT9Xhc1Z2")
        .update({
      "Balance": FieldValue.increment(deposition)});
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff041f4a),
      appBar: AppBar(
        backgroundColor: Color(0xff00102a),
        title: Text('Deposit'),

      ),

      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          Center(child: Text('Deposit Amount', style: GoogleFonts.montserrat(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.white),)),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _depositAmount,
              obscureText: false,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter Amount',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.attach_money_outlined, color: Colors.white),
              ),
            ),
          ),

          Center(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: deposit,
                    child: Text('Deposit', style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                    ),

                  ),
                )
            ),
          ),


        ],

      ),

    );
  }
}
