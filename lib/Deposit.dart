import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  bool isDepositing = false;

  void deposit() async {
    setState(() {
      isDepositing = true;
    });
    final num deposition = int.parse(_depositAmount.text);


    await FirebaseFirestore.instance
        .collection("Account")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"Balance": FieldValue.increment(deposition)});

    setState(() {
      isDepositing = false;
    });

    var snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Deposition Successful',
        message:
            "Successfully deposited ${_depositAmount.text}Rs into your account",
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff041f4a),
      appBar: AppBar(
        backgroundColor: const Color(0xff00102a),
        title: const Text('Deposit'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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

          Center(
              child: Text(
                'Balance Deposition',
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              )),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _depositAmount,
              obscureText: false,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter Deposit Amount',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon:
                    Icon(Icons.attach_money_outlined, color: Colors.white),
              ),
            ),
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                  child: isDepositing
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: deposit,
                          style: ElevatedButton.styleFrom(),
                          child: Text(
                            'Deposit',
                            style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                )),
        ],
      ),
    );
  }
}
