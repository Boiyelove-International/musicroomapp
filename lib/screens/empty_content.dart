import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyContent extends StatelessWidget {
  String message;
  EmptyContent({this.message = "No content added"});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "$message",
      style: GoogleFonts.workSans(fontWeight: FontWeight.w300, height: 1.5),
      textAlign: TextAlign.center,
    ));
    // return Center(
    //     child: Column(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     Container(
    //         height: MediaQuery.of(context).size.height * 0.3,
    //         decoration: BoxDecoration(
    //             image: DecorationImage(
    //                 image: AssetImage("assets/images/empty_event_icon.png"),
    //                 fit: BoxFit.contain))),
    //     SizedBox(height: 20),
    //     Padding(
    //       padding: EdgeInsets.symmetric(horizontal: 50),
    //       child: Text(
    //         "$message",
    //         style:
    //             GoogleFonts.workSans(fontWeight: FontWeight.w300, height: 1.5),
    //         textAlign: TextAlign.center,
    //       ),
    //     )
    //   ],
    // ));
  }
}
