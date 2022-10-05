import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomWidget extends StatelessWidget {
  const CustomWidget({Key? key, required this.name, required this.image}) : super(key: key);

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        width: 130,
        height: 140,
        decoration: BoxDecoration(
          color: Color(0xff00102a),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image:
                    AssetImage(image),
                    width: 50,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Align(
                alignment: Alignment.center,
                child: Text(name,
                    style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}