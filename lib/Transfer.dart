import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  final TextEditingController _recipientEmail = TextEditingController();
  final TextEditingController _recipientAmount = TextEditingController();

  String receipentEmailDoc = "";

  bool isTransferring = false;

  void transfer() async {
    try {
      setState(() {
        isTransferring = true;
      });

      //int x;
      //var currbalance = FirebaseFirestore.instance.collection("Account").doc(FirebaseAuth.instance.currentUser!.uid).get('Balance').then((value) => null);
      //print(currbalance + 'asda');//if(_recipientAmount>FirebaseFirestore.instance.collection('Action').doc(FirebaseAuth.instance.currentUser!.uid).get("Balance"))

      /*if(int.parse(currbalance)<=int.parse(_recipientAmount.text))
      {
        var snackbar_1 = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Insufficient funds!',
            message:
            "Insufficient funds in your account for this transaction",
            contentType: ContentType.success,
          ),
        );

        return;
      }
*/
      int decrement = 0-int.parse(_recipientAmount.text);


      await FirebaseFirestore.instance.collection('Account')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"Balance":FieldValue.increment(decrement)});

      // getting document id of recipient by email
      await FirebaseFirestore.instance
          .collection("Account")
          .where("Email", isEqualTo: _recipientEmail.text)
          .get()
          .then((value) {
        for (var element in value.docs) {
          receipentEmailDoc = element.id;
        }

      });
      // updating balance of that email
      await FirebaseFirestore.instance
          .collection("Account")
          .doc(receipentEmailDoc)
          .update({
        "Balance": FieldValue.increment(int.parse(_recipientAmount.text)),
      }).then((value) {
        setState(() {
          isTransferring = false;
        });
      });

      // a snakcbar to show success message
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Transfer Successful',
          message:
              "Successfully Transfered ${_recipientAmount.text} to ${_recipientEmail.text}",
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
        title: const Text('Transfer'),
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
                'Money Transfer',
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              )),


          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _recipientEmail,
              obscureText: false,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter email of reciepient',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.email, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _recipientAmount,
              obscureText: false,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter Amount',
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
                          onPressed: transfer,
                          style: ElevatedButton.styleFrom(),
                          child: Text(
                            'Transfer',
                            style: GoogleFonts.montserrat(
                                fontSize: 13,
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
