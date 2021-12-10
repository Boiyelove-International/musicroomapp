import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/screens/popups.dart';
import 'package:musicroom/styles.dart';

import '../routes.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "/profile";
  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
        initialIndex: 0,
        child: Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          icon: Icon(IconlyBold.arrow_left),
          color: DarkPalette.darkGold,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Profile"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(Routes.yourRoom);
          },
              color: DarkPalette.darkGold,
              icon: Icon(IconlyBold.scan))
        ],
      ),
      body: SafeArea(
          top: true,
          bottom: true,
          child: Column(
              children: [
          Container(
          padding: EdgeInsets.all(20),
          child: Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(
                    "assets/images/avatars/organizer-profile-icon.png"
                ),
              )
          )
      ),
      Text("Change Profile picture", style: GoogleFonts.workSans(
          fontWeight: FontWeight.w300,
          fontSize: 16
      )),
      SizedBox(height:20),
    TabBar(
      tabs: [
        Tab(
          child: Text("Profile"),
        ),
        Tab(
          child: Text("Settings & More"),
        )
      ],
    ),
                Expanded(child: Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: TabBarView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: 50,
                                bottom: 15
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2,
                                    color: DarkPalette.darkYellow
                                  )
                                )
                              ),
                              child: GestureDetector(
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        actions: [
                                      TextButton(
                                      child: Text("OK"),
                                      onPressed: () { },
                                      ),
                                          TextButton(
                                            child: Text("Cancel"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        backgroundColor: Colors.black,
                                        elevation: 16,
                                        content: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              SizedBox(height: 20),
                                              Center(child: Text('Leaderboard')),
                                              SizedBox(height: 20),
                                              Text("This thing and that")
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("DJ/Event Organizer Name", style: GoogleFonts.workSans(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16
                                  )),
                                  Text("PartyMixers", style: GoogleFonts.workSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18
                                  ),)
                                ],
                              )),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 50,
                                  bottom: 15
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 2,
                                          color: DarkPalette.darkYellow
                                      )
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Email Address", style: GoogleFonts.workSans(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16
                                  ),),
                                  Text("Partymixers@gmail.com", style: GoogleFonts.workSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18
                                  ),)
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 20,
                                  bottom: 5
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 2,
                                          color: DarkPalette.darkYellow
                                      )
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Change Password", style: GoogleFonts.workSans(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16
                                  )),
                                  IconButton(
                                    onPressed: (){},
                                    icon: Icon(
                                        Icons.chevron_right,
                                    size: 30,
                                    color: Colors.amber),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text("Connected Accounts", style: GoogleFonts.workSans(
                                fontWeight: FontWeight.w300,
                                fontSize: 16
                            )),
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset("assets/images/google_icon.png"),
                                SizedBox(
                                  width: 30,
                                ),
                                Image.asset("assets/images/facebook_icon.png"),
                                SizedBox(
                                  width: 30,
                                ),
                                Image.asset("assets/images/apple_icon.png"),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap:(){
                                Navigator.of(context).pushNamed(Routes.subscription);

                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 40,
                                    bottom: 5
                                ),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 2,
                                            color: DarkPalette.darkYellow
                                        )
                                    )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Go Premium"),
                                    IconButton(
                                      onPressed: (){
                                        Navigator.of(context).pushNamed(Routes.subscription);
                                      },
                                      icon: Icon(
                                          Icons.chevron_right,
                                          size: 30,
                                          color: Colors.amber),
                                    )
                                  ],
                                ),
                              )
                            ),
                            SizedBox(height: 35),
                            Text("SETTINGS", style: GoogleFonts.workSans(
                                fontWeight: FontWeight.w700,
                                fontSize: 16
                            )),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 30,
                                  bottom: 5
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Enable Dark Mode", style: GoogleFonts.workSans(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16
                                  )),
                                  CupertinoSwitch(value: false,
                                      trackColor: Colors.grey,
                                      onChanged: null)
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 20,
                                  bottom: 5
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Turn off Notifications", style: GoogleFonts.workSans(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16
                                  )),
                                  CupertinoSwitch(value: true,
                                      activeColor: Colors.amber,
                                      trackColor: Colors.grey,
                                      onChanged: null)
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Text("Send Feedbacks & communicate with us", style: GoogleFonts.workSans(
                                fontWeight: FontWeight.w300,
                                fontSize: 16
                            )),
                            SizedBox(height: 20),
                            Row(
                              children:[
                                InkWell(
                                  onTap:(){},
                                  child: Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: DarkPalette.darkYellow,
                                      borderRadius: BorderRadius.circular(5)

                                    ),
                                    child: Icon(
                                        FeatherIcons.facebook,
                                        color: Colors.amber
                                    )
                                  )
                                ),
                                SizedBox(width: 20,),
                                InkWell(
                                    onTap:(){},
                                    child: Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: DarkPalette.darkYellow,
                                            borderRadius: BorderRadius.circular(5)

                                        ),
                                        child: Icon(
                                            FeatherIcons.twitter,
                                            color: Colors.amber
                                        )
                                    )
                                ),
                                SizedBox(width: 20,),
                                InkWell(
                                    onTap:(){},
                                    child: Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: DarkPalette.darkYellow,
                                            borderRadius: BorderRadius.circular(5)

                                        ),
                                        child: Icon(
                                            FeatherIcons.instagram,
                                            color: Colors.amber
                                        ),
                                    )
                                ),
                                SizedBox(width: 10,),
                                InkWell(
                                    onTap:(){},
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: DarkPalette.darkYellow,
                                          borderRadius: BorderRadius.circular(5)

                                      ),
                                      child: Icon(
                                          FeatherIcons.mail,
                                          color: Colors.amber
                                      ),
                                    )
                                ),
                                SizedBox(width: 10,),
                                InkWell(
                                    onTap:(){},
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: DarkPalette.darkYellow,
                                          borderRadius: BorderRadius.circular(5)

                                      ),
                                      child: Icon(
                                          FeatherIcons.phone,
                                          color: Colors.amber
                                      ),
                                    )
                                ),
                                SizedBox(width: 10,),



                              ]
                            )

                          ]
                        )
                      ],
                    )
                )),
                Text("Copyright 2021 | Music Room | Version 1.1", style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w300,
                    fontSize: 13
                ))
            ]
    )
    ),

      ),
    );
  }
}
