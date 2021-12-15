import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicroom/styles.dart';

import '../routes.dart';

class SubscriptionScreen extends StatefulWidget {
  static const String routeName = "/subscription";
  @override
  _SubscriptionScreen createState() => _SubscriptionScreen();
}

class _SubscriptionScreen extends State<SubscriptionScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: true,
          bottom: true,
          child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
              "assets/images/premium_illustration.png"
                        ),
          fit:BoxFit.contain,
                      )
                    ),

                ),
                Padding(
                  padding:EdgeInsets.only(left:20, right:20),
                  child: Text("Get rid of adverts,\n"
                      "Upgrade to premium", textAlign: TextAlign.center, style: GoogleFonts.workSans(
                      fontSize: 25, fontWeight: FontWeight.w700, height: 1.5
                  ))
                ),
                SizedBox(height: 20,),
                Padding(
                    padding:EdgeInsets.only(left:5, right:5),
                    child: Text("Get  unlimited time in the party room, no ad \n interruptions and much more...", textAlign: TextAlign.center, style: GoogleFonts.workSans(
                        fontSize: 18, fontWeight: FontWeight.w300, height: 1.5))
                ),
                SizedBox(height: 60,),
                Padding(
                    padding: EdgeInsets.only(left: 5, right:5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: AspectRatio(aspectRatio: 1/1, child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: DarkPalette.borderGradient1
                        ),
                        child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("12", style: GoogleFonts.workSans(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700
                                ),),

                                Text("Months"),
                                Text("\$5.0/Mt")
                              ],
                            )
                        ),
                      ))),
                      SizedBox(width:20),
                      Flexible(child: AspectRatio(aspectRatio: 1/1, child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: DarkPalette.lightFushia
                        ),
                        child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("6", style: GoogleFonts.workSans(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700
                                ),),
                                Text("Months"),
                                Text("\$8.0/Mt")
                              ],
                            )
                        ),
                      ))),
                      SizedBox(width:20),
                      Flexible(child: AspectRatio(aspectRatio: 1/1, child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: DarkPalette.lightBlue
                        ),
                        child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("11", style: GoogleFonts.workSans(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700
                                ),),
                                Text("Months"),
                                Text("\$12.0/Mt")
                              ],
                            )
                        ),
                      ))),


                    ],
                  )
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 4),
                                blurRadius: 5.0)
                          ],
                          gradient: DarkPalette.borderGradient1,
                          // color: Colors.deepPurple.shade300,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(Size(50, 50)),
                            backgroundColor: MaterialStateProperty.all(Colors.transparent),
                            // elevation: MaterialStateProperty.all(3),
                            shadowColor: MaterialStateProperty.all(Colors.transparent),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.premium);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              bottom: 20,
                            ),
                            child: Text("Get 12 months / \$5.00/Mt",
                                style: GoogleFonts.workSans(fontSize: 16, fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
                    ),)
                  ],
                )

              ]
          )
      ),

    );
  }
}



class PremiumScreen extends StatefulWidget {
  static const String routeName = "/premium";

  @override
  _PremiumScreen createState() => _PremiumScreen();
}

class _PremiumScreen extends State<PremiumScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: true,
          bottom: true,
          child: Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/dj_cuate_1.png"
                        ),
                            fit: BoxFit.contain
                      )
                    ),

                ),
                Text("Premium never felt\n so good right...", textAlign: TextAlign.center, style: GoogleFonts.workSans(
                    fontSize: 30, fontWeight: FontWeight.w700, height: 1.5)),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(left:2, right:2),
                  child: Text("You are currently using the music room app as a \n premium user, below is the  status of your \n subscription.", textAlign: TextAlign.center, style: GoogleFonts.workSans(
                      fontSize: 17, fontWeight: FontWeight.w300, height: 1.5))
                ),
                SizedBox(height: 30,),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                          gradient: DarkPalette.borderGradient1
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Subscription Type", style: GoogleFonts.workSans(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 14

                              )),
                              SizedBox(height: 3),
                              Text("Premium", style: GoogleFonts.workSans(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  fontSize: 14

                              )),
                              SizedBox(height:20),
                              Text("Cost", style: GoogleFonts.workSans(
                              fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14

                              )),
                              SizedBox(height: 3),
                              Text("\$8.0", style: GoogleFonts.workSans(
                              fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  fontSize: 14

                              )),
                              SizedBox(height:20),
                              Text("Next Payment Date", style: GoogleFonts.workSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14

                              )),
                              SizedBox(height: 3),
                              Text("24 July 2022", style: GoogleFonts.workSans(
                              fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  fontSize: 14

                              )),
                            ],
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Duration", style: GoogleFonts.workSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 14

                          )),

                              SizedBox(height: 3),
                              Text("3 Months", style: GoogleFonts.workSans(
                              fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  fontSize: 14

                              )),
                              SizedBox(height:20),
                              Text("Payment", style: GoogleFonts.workSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14

                              )),
                              SizedBox(height: 3),
                              Text("3 months",  style: GoogleFonts.workSans(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  fontSize: 14

                              )),
                            ],
                          )
                        ],
                      ),
                    )
                  ),
                )

              ]
          )
      ),

    );
  }
}
