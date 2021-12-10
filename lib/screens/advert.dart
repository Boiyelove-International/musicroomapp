import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicroom/styles.dart';

import '../routes.dart';

class Advert extends StatefulWidget {
  static const String routeName = "/adver";
  @override
  _Advert createState() => _Advert();
}

class _Advert extends State<Advert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      top: true,
      bottom: true,
      child: Container(
        height: MediaQuery.of(context).size.height * 1.0,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
            children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/advert_bg.png"),
                      fit: BoxFit.fitWidth)),
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          gradient: DarkPalette.borderGradient1,
                          shape: BoxShape.circle
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30
                        )
                      )
                    ),
                  ))
                ],
              )),
          Expanded(
            child: Container(
                color: Colors.black,
                child: Column(


                  children: [
                   Padding(
                     padding: EdgeInsets.all(
                    20
                ),
                     child:  Text("Enjoy Premium Sound", style: GoogleFonts.workSans(
                         color: Colors.white,
                         fontSize: 28,
                         fontWeight: FontWeight.w700
                     ),),
                   ),
                    Padding(
                      padding: EdgeInsets.all(
                        5
                      ),
                      child: Text(
                          "Advertisement popup window could be videos, pictures and the likes predetermined by admob.",
                          style: GoogleFonts.workSans(
                              color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            height: 1.5
                          ), textAlign: TextAlign.center,),
                    ),
SizedBox(height:20),
                    ElevatedButton(
                        style: ButtonStyle(
                            textStyle: MaterialStateProperty.all<TextStyle>(
                                TextStyle(fontSize: 10)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.only(
                                    top: 20,
                                    right: 60,
                                    left: 60,
                                    bottom: 20)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                DarkPalette.darkGold),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: DarkPalette.darkGold)))),
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.subscription);
                        },
                        child: Text("Let's Get Going",
                            style: GoogleFonts.workSans(
                                fontSize: 12,
                                fontWeight:
                                FontWeight.w300
                            )))
                  ],
                )
            )
          )
        ]),
      ),
    ));
  }
}
