import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:iconly/iconly.dart';

import '../styles.dart';

class EventDetail extends StatefulWidget {
  @override
  _EventDetail createState() => _EventDetail();
}

class _EventDetail extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top:50, left:5, right:5),
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/party_people_3.png"))),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color:
                                Colors.white.withOpacity(0.2),
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Starts in"),
                                    Text("24h: 30m")
                                  ])))),
                  Positioned.fill(child: Align(
                      alignment: Alignment.topRight,
                      child: FocusedMenuHolder(
                          openWithTap: true,
                          menuWidth: MediaQuery.of(context).size.width * 0.4,
                          child: Icon(Icons.more_vert, color: Colors.white, size:50), onPressed: (){},
                          menuItems: <FocusedMenuItem>[
                        FocusedMenuItem(title: Padding(padding: EdgeInsets.all(4), child: Text("Share Event", style: TextStyle(color: Colors.black),)), onPressed: (){}),
                        FocusedMenuItem(title: Text("Edit Event", style: TextStyle(color: Colors.black)), onPressed: (){}),
                        FocusedMenuItem(title: Text("Delete Event", style: TextStyle(color: Colors.red)), onPressed: (){})
                      ])
                  )),
                  Positioned(
                    right: 0,
                    bottom: -40,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration:
                      BoxDecoration(
                        shape: BoxShape
                            .circle,
                        gradient: DarkPalette
                            .borderGradient1,
                      ),
                      child: Center(
                          child: Image.asset("assets/images/music.png", height: 100, width: 100)),
                    ) ,
                  )

                ],
              ),
            ),
            SizedBox(height: 50),
            ListTile(
              title: Text('WSJ Rock Concert'),
              subtitle:  Text("2019 August, 2021"),
            ),
            SizedBox(height:20),
            Row(
              children: [
                Container(
                  height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                image:  AssetImage("assets/images/circle_avatar_1.png")
            )
            ),
            )
               ,  SizedBox(width: 30,), Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("You"),
                    SizedBox(height: 20,),
                    Text("Organizer")
                  ]
                )
              ],
            ),
            SizedBox(height:20),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:  AssetImage("assets/images/circle_avatar_1.png")
                      )
                  ),
                )
                ,  SizedBox(width: 30,), Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("You"),
                      SizedBox(height: 20,),
                      Text("Organizer")
                    ]
                ), Spacer(), Container(
      height: 60,
      width: 60,
      decoration:
      BoxDecoration(
        shape: BoxShape
            .circle,
        gradient: DarkPalette
            .borderGradient1,
      ),
      child: Center(
          child: Text(
              "+500")),
    )
              ],
            ),
            SizedBox(height:70),
            Text("Party Stats"),
            SizedBox(height:20),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: DarkPalette.darkGrey1,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/images/waving_hand.png"),
                        SizedBox(height:20),
                        Text("257"),
                        SizedBox(height:20),
                        Text("Total Suggestions"),
                      ],
                    )
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      gradient: DarkPalette
                          .borderGradient1,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset("assets/images/thumbs_up.png"),
                          SizedBox(height:20),
                          Text("257"),
                          SizedBox(height:20),
                          Text("Total Suggestions"),
                        ],
                      )
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Text("About"),
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Orci, scelerisque nunc, diam lorem. Nunc ipsum aliquet ornare nec pretium. Morbi semper fermentum, pellentesque tincidunt a, accumsan sodales. Blandit eget nisi consectetur odio fermentum. Praesent elementum ante feugiat non scelerisque pellentesque lectus ultricies sollicitudin. Ipsum a ut sit vel nulla sed odio nulla lectus. Fermentum turpis amet in..."),

      

          ],
        ),
      ),
    );
  }
}
