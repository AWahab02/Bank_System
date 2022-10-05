import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {

  final TextEditingController _recipientEmail = new TextEditingController();
  final TextEditingController _recipientAmount = new TextEditingController();
  String receipentEmailDoc = "";
  void Transfer()
  {
      FirebaseFirestore.instance.collection('Account').where("Email", isEqualTo: _recipientEmail.text).get();
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

          Center(child: Text('Transfer Amount', style: GoogleFonts.montserrat(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.white),)),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _recipientEmail,
              obscureText: false,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter email of reciepient',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.email, color: Colors.white),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _recipientAmount,
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
                    onPressed: Transfer,
                    child: Text('Transfer', style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                    ),

                  ),
                )
            ),



          ),

          Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 100,
                child: Text(receipentEmailDoc, style: TextStyle(color: Colors.white),),

                ),
              )

        ],

      ),

    );
  }
}
