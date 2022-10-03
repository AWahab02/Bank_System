import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'registration_success.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Registration_page extends StatefulWidget {
  const Registration_page({Key? key}) : super(key: key);

  @override
  _Registration_pageState createState() => _Registration_pageState();
}

class _Registration_pageState extends State<Registration_page> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool _success;
  late String _userEmail;

  void _register() async
  {
    final User? user = (
    await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)
    ).user;

    if(user!=null)
      {
        setState(() {
          _success=true;
          _userEmail = user.email!;

          Navigator.of(context)
              .push(
              MaterialPageRoute(builder: (context) => Reg_success())
          );
        });
      }
    else
      {
        _success=false;
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff041f4a),
      body: SingleChildScrollView(
        child: Column(

          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Image(image: AssetImage('assets/apex.png'),width: 200,),
              ),
            ),

            Center(child: Text('ATLAS Banking', style: GoogleFonts.montserrat(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),)),


            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('Account Registration', style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                obscureText: false,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'First Name',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),

            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                obscureText: false,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Last Name',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),

            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _emailController,
                obscureText: false,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.mail, color: Colors.white),
                ),
              ),

            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.password_outlined, color: Colors.white),
                ),
              ),

            ),

            Center(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      onPressed: _register,
                      child: Text('Register', style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                      style: ElevatedButton.styleFrom(

                      ),

                    ),
                  )
              ),
            ),

            Padding(padding: EdgeInsets.all(14.0),
              child: Center(
                child: TextButton(
                  onPressed: (){
                    Navigator
                        .pop(context);
                  },
                  child: Text('Already have an account? Sign In', style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white) ),
                ),
              ),
            ),


          ],



        ),
      )


    );
  }
}

