import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../styles.dart';

class EventCardGold extends StatelessWidget {

  EventCardGold({
    required this.title,
    required this.artist,
    required this.image
  });

  String title;
  String artist;
  String image;

  @override
  Widget build(context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: DarkPalette.borderGradient1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/album_art_7.png"),
                        fit: BoxFit.cover)),
              )),
          SizedBox(height: 15),
          Text("$title",
              style: GoogleFonts.workSans(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
          SizedBox(height: 5),
          Text("Single - Wizkid",
              style: GoogleFonts.workSans(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}