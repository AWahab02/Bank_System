import 'package:flutter/material.dart';
import 'package:bank_system/Transfer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';


class Bill_Payment extends StatefulWidget {
  const Bill_Payment({Key? key}) : super(key: key);

  @override
  _Bill_PaymentState createState() => _Bill_PaymentState();
}

class _Bill_PaymentState extends State<Bill_Payment> {
  final TextEditingController _recipientAmount = TextEditingController();

  String receipentEmailDoc = "";

  bool isTransferring = false;

  void PayBill() async {
    try {
      setState(() {
        isTransferring = true;
      });

      int decrement = 0-int.parse(_recipientAmount.text);


      await FirebaseFirestore.instance.collection('Account')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"Balance":FieldValue.increment(decrement)});


      // getting document id of recipient by email
      // updating balance of that email

      setState(() {
        isTransferring=false;
      });

      // a snakcbar to show success message
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Bill Payment Successful',
          message:
          "Successfully Paid a bill of ${_recipientAmount.text}Rs",
          contentType: ContentType.success,
        ),
      );



      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    } catch (error) {
      // any error that comes is recieved here and shown through snackbar
      setState(() {
        isTransferring = false;
      });
      print(error);
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error In Transfer',
          message: error.toString(),
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff041f4a),
      appBar: AppBar(
        backgroundColor: const Color(0xff00102a),
        title: const Text('Bill Payment'),
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
                'Bill Payment',
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              )),


          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _recipientAmount,
              obscureText: false,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter Bill Amount',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon:
                Icon(Icons.attach_money_outlined, color: Colors.white),
              ),
            ),
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: isTransferring
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: PayBill,
                  style: ElevatedButton.styleFrom(),
                  child: Text(
                    'Pay Bill',
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )),
          ),

        ],
      ),
    );
  }
}
