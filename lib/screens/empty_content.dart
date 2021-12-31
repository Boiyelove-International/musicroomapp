import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:musicroom/screens/event_list.dart';
import 'package:musicroom/screens/popups.dart';
import 'package:musicroom/screens/suggestion_list.dart';
import 'package:musicroom/screens/yourRoom.dart';
import 'package:musicroom/utils.dart';
import 'package:musicroom/utils/apiServices.dart';
import 'package:musicroom/utils/models.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:math' as math;
import '../routes.dart';
import '../styles.dart';

class EmptyContent extends StatelessWidget {
  String message;
  EmptyContent({this.message = "Wow! such empty. We can’t have you"
      "live like this. Join an event to"
      "see them appear here."});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/empty_event_icon.png"),
                        fit: BoxFit.contain))),
            SizedBox(height:20),
            Padding(padding: EdgeInsets.symmetric(
                horizontal: 50
            ), child:  Text("$message", style: GoogleFonts.workSans(
                fontWeight: FontWeight.w300,
                height: 1.5
            ),
              textAlign: TextAlign.center,),)
          ],
        ));
  }
}