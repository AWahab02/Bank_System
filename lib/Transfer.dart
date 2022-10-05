import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        title: const Text('Deposit'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'Transfer Amount',
            style: GoogleFonts.montserrat(
                fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
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
                child: SizedBox(
                  width: 100,
                  child: isTransferring
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: transfer,
                          style: ElevatedButton.styleFrom(),
                          child: Text(
                            'Transfer',
                            style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 100,
              child: Text(
                receipentEmailDoc,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
