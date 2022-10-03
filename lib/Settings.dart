import 'package:flutter/material.dart';

class Settingss extends StatefulWidget {
  const Settingss({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settingss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff041f4a),
      appBar: AppBar(
        backgroundColor: Color(0xff00102a),
        title: Text('Settings'),
      ),
    );
  }
}
