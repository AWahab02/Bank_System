import 'package:flutter/material.dart';

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff041f4a),
      appBar: AppBar(
        backgroundColor: Color(0xff00102a),
        title: Text('Transfer'),
      ),
    );
  }
}
