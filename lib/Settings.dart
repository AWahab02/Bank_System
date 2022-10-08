import 'package:bank_system/PasswordResetPage.dart';
import 'package:bank_system/VerifyEmail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settingss extends StatefulWidget {
  const Settingss({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settingss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff041f4a),
      appBar: AppBar(
        backgroundColor: const Color(0xff00102a),
        title: const Text('Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Center(
              child: Text(
                'ATLAS Banking',
                style: GoogleFonts.montserrat(
                    fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
              )),

          Center(
              child: Text(
                'Account Management',
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              )),


          Center(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 280,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ResetPassword()));},
                    style: ElevatedButton.styleFrom(),
                    child: Text(
                      'Reset Password',
                      style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )),
          ),


        ],
      ),
    );
  }
}
