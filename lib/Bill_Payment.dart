import 'package:flutter/material.dart';

class Bill_Payment extends StatefulWidget {
  const Bill_Payment({Key? key}) : super(key: key);

  @override
  _Bill_PaymentState createState() => _Bill_PaymentState();
}

class _Bill_PaymentState extends State<Bill_Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff041f4a),
      appBar: AppBar(
        backgroundColor: const Color(0xff00102a),
        title: const Text('Bill Transfer'),
      ),
    );
  }
}
