import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/screens/popups.dart';
import 'package:musicroom/screens/suggestion_list.dart';
import 'package:musicroom/utils/models.dart';
import 'dart:math' as math;
import '../routes.dart';
import '../styles.dart';


class EventCard extends StatelessWidget{
  @override
  Widget build(context){
    return Container(
      height: 300,
      width: 300,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Stack(
        children: [
          Positioned.fill(
              child: Align(
                  alignment: Alignment.topRight,
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
          Positioned.fill(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      padding: EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                          left: 20,
                          right: 20),
                      decoration: BoxDecoration(
                        color:
                        Colors.white.withOpacity(0.2),
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                      child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Flexible(
                                child: Column(
                                    mainAxisSize:
                                    MainAxisSize.min,
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text("Owambe Party",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight:
                                              FontWeight
                                                  .w900)),
                                      SizedBox(height: 10),
                                      Text(
                                          "Hosted by - Owambe Hitz",
                                          style: TextStyle(
                                              fontSize: 10))
                                    ])),
                            Flexible(
                                child: Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.3,
                                  height: 35,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          right: 50,
                                          child: CircleAvatar(
                                            backgroundImage:
                                            AssetImage(
                                                "assets/images/circle_avatar_2.png"),
                                          )),
                                      Positioned(
                                          right: 25,
                                          child: CircleAvatar(
                                            backgroundImage:
                                            AssetImage(
                                                "assets/images/circle_avatar_3.png"),
                                          )),
                                      Positioned(
                                          right: 0,
                                          child: Container(
                                            height: 35,
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
                                          ))
                                    ],
                                  ),
                                ))
                          ]))))
        ],
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                  "assets/images/party_people_1.png"))),
    );
  }
}

class EventDetail extends StatefulWidget {
  static const String routeName = "/evetDetail";

  EventDetail({Key? key, this.userType = UserType.partyGuest}) : super(key: key);

  UserType? userType;


  @override
  _EventDetail createState() => _EventDetail();
}

class _EventDetail extends State<EventDetail> {
  bool _showAttendees = false;

  @override
  Widget build(BuildContext context) {
    Widget _attendees = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage:
                    AssetImage("assets/images/circle_avatar_1.png"),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Sandra",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 3),
                    Text("Organizer",
                        style: TextStyle(
                          fontSize: 10,
                        ))
                  ]),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 20);
        },
        itemCount: 15);
    Widget _timingBox = Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text("Starts in"), Text("24h: 30m")]));
    Widget _contextMenuDots = FocusedMenuHolder(
        openWithTap: true,
        menuWidth: MediaQuery.of(context).size.width * 0.4,
        child: Icon(Icons.more_vert, color: Colors.white, size: 50),
        onPressed: () {},
        menuItems: <FocusedMenuItem>[
          FocusedMenuItem(
              title: Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    "Share Event",
                    style: TextStyle(color: Colors.black),
                  )),
              onPressed: () {}),
          FocusedMenuItem(
              title: Text("Edit Event", style: TextStyle(color: Colors.black)),
              onPressed: () {}),
          FocusedMenuItem(
              title: Text("Delete Event", style: TextStyle(color: Colors.red)),
              onPressed: () {})
        ]);

    Widget _backButton = IconButton(
      icon: Icon(IconlyBold.arrow_left),
      color: Colors.white,
      onPressed: () {
        setState(() {
          _showAttendees = false;
        });
      },
    );


    List<Widget> _widgetsList = [];
    List<Widget> _eventDetailOrganizer = [
      Container(
        padding: EdgeInsets.only(top: 50, left: 5, right: 5),
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
                    child: _showAttendees ? _backButton : _timingBox)),
            Positioned.fill(
                child: Align(
                    alignment: Alignment.topRight,
                    child:
                    _showAttendees ? _timingBox : _contextMenuDots)),
            Positioned(
              right: 0,
              bottom: -40,
              child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed(Routes.partyPlaylist);
                  }, child:Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: DarkPalette.borderGradient1,
                ),
                child: Center(
                    child: Image.asset("assets/images/music.png",
                        height: 100, width: 100)),
              )
              ),
            )
          ],
        ),
      ),
      SizedBox(height: 30),
      Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    'WSJ Rock Concert',
                    style: TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w900),
                  ),
                  subtitle: Text(
                    "2019 August, 2021",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                      AssetImage("assets/images/circle_avatar_1.png"),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "You",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 3),
                          Text("Organizer",
                              style: TextStyle(
                                fontSize: 10,
                              ))
                        ])
                  ],
                ),
                SizedBox(height: 20),
                _showAttendees
                    ? _attendees
                    : Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(
                              "assets/images/circle_avatar_1.png"),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Sandra",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 3),
                              Text("Organizer",
                                  style: TextStyle(
                                    fontSize: 10,
                                  ))
                            ]),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _showAttendees = true;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: DarkPalette.borderGradient1,
                            ),
                            child: Center(child: Text("+500")),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 70),
                    Text(
                      "Party Stats",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(Routes.allSuggestions);
                          },
                          child: Container(
                            width:
                            MediaQuery.of(context).size.width *
                                0.45,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: DarkPalette.darkGrey1,
                                borderRadius:
                                BorderRadius.circular(10)),
                            child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/images/waving_hand.png",
                                      height: 30,
                                    ),
                                    SizedBox(height: 15),
                                    Text("257",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight:
                                            FontWeight.w900)),
                                    SizedBox(height: 15),
                                    Text(
                                      "Total Suggestions",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 8),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width *
                              0.048,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  Routes.acceptedSuggestions);
                            },
                            child: Container(
                              width: MediaQuery.of(context)
                                  .size
                                  .width *
                                  0.45,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  gradient:
                                  DarkPalette.borderGradient1,
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        "assets/images/thumbs_up.png",
                                        height: 30,
                                      ),
                                      SizedBox(height: 15),
                                      Text("157",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight:
                                              FontWeight.w900)),
                                      SizedBox(height: 15),
                                      Text(
                                        "Accepted Suggestions",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 8),
                                      ),
                                    ],
                                  )),
                            )),
                      ],
                    ),
                    SizedBox(height: 50),
                    Text(
                      "About",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 20),
                    Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Orci, scelerisque nunc, diam lorem. Nunc ipsum aliquet ornare nec pretium. Morbi semper fermentum, pellentesque tincidunt a, accumsan sodales. Blandit eget nisi consectetur odio fermentum. Praesent elementum ante feugiat non scelerisque pellentesque lectus ultricies sollicitudin. Ipsum a ut sit vel nulla sed odio nulla lectus. Fermentum turpis amet in..."),
                    SizedBox(height: 20),
                    Text("Currently Playing"),
                    SizedBox(height: 20),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: DarkPalette.darkGrey1,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/album_art_1.png"))),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Implication",
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width * 0.02),
                                Text("Single - Burna Boy",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width *
                                            0.028)),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width * 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.26,
                                          height: 20,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                  left: 0,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_1.png"),
                                                  )),
                                              Positioned(
                                                  left: 15,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_2.png"),
                                                  )),
                                              Positioned(
                                                  left: 35,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_3.png"),
                                                  )),
                                              Positioned(
                                                  left: 55,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_1.png"),
                                                  )),
                                            ],
                                          ),
                                        )),
                                    Text(
                                      "3000+ people suggested",
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ])),
                    SizedBox(height: 20),
                    Text("Up next"),
                    SizedBox(height: 20),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: DarkPalette.darkGrey1,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/album_art_1.png"))),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Implication",
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width * 0.02),
                                Text("Single - Burna Boy",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width *
                                            0.028)),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width * 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.26,
                                          height: 20,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                  left: 0,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_1.png"),
                                                  )),
                                              Positioned(
                                                  left: 15,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_2.png"),
                                                  )),
                                              Positioned(
                                                  left: 35,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_3.png"),
                                                  )),
                                              Positioned(
                                                  left: 55,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_1.png"),
                                                  )),
                                            ],
                                          ),
                                        )),
                                    Text(
                                      "3000+ people suggested",
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ])),
                    SizedBox(height: 20),
                    Text("Queued"),
                    SizedBox(height: 20),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: DarkPalette.darkGrey1,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/album_art_1.png"))),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Implication",
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width * 0.02),
                                Text("Single - Burna Boy",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width *
                                            0.028)),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width * 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.26,
                                          height: 20,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                  left: 0,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_1.png"),
                                                  )),
                                              Positioned(
                                                  left: 15,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_2.png"),
                                                  )),
                                              Positioned(
                                                  left: 35,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_3.png"),
                                                  )),
                                              Positioned(
                                                  left: 55,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_1.png"),
                                                  )),
                                            ],
                                          ),
                                        )),
                                    Text(
                                      "3000+ people suggested",
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ])),
                    SizedBox(height: 20),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: DarkPalette.darkGrey1,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/album_art_1.png"))),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Implication",
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width * 0.02),
                                Text("Single - Burna Boy",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width *
                                            0.028)),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width * 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.26,
                                          height: 20,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                  left: 0,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_1.png"),
                                                  )),
                                              Positioned(
                                                  left: 15,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_2.png"),
                                                  )),
                                              Positioned(
                                                  left: 35,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_3.png"),
                                                  )),
                                              Positioned(
                                                  left: 55,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_1.png"),
                                                  )),
                                            ],
                                          ),
                                        )),
                                    Text(
                                      "3000+ people suggested",
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ])),
                    SizedBox(height: 20),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: DarkPalette.darkGrey1,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/album_art_1.png"))),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Implication",
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width * 0.02),
                                Text("Single - Burna Boy",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width *
                                            0.028)),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width * 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.26,
                                          height: 20,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                  left: 0,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_1.png"),
                                                  )),
                                              Positioned(
                                                  left: 15,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_2.png"),
                                                  )),
                                              Positioned(
                                                  left: 35,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_3.png"),
                                                  )),
                                              Positioned(
                                                  left: 55,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_1.png"),
                                                  )),
                                            ],
                                          ),
                                        )),
                                    Text(
                                      "3000+ people suggested",
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ])),
                    SizedBox(height: 20),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: DarkPalette.darkGrey1,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/album_art_1.png"))),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Implication",
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width * 0.02),
                                Text("Single - Burna Boy",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width *
                                            0.028)),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width * 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.26,
                                          height: 20,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                  left: 0,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_1.png"),
                                                  )),
                                              Positioned(
                                                  left: 15,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_2.png"),
                                                  )),
                                              Positioned(
                                                  left: 35,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_3.png"),
                                                  )),
                                              Positioned(
                                                  left: 55,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_1.png"),
                                                  )),
                                            ],
                                          ),
                                        )),
                                    Text(
                                      "3000+ people suggested",
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ])),
                    SizedBox(height: 20),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: DarkPalette.darkGrey1,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/album_art_1.png"))),
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Implication",
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width * 0.02),
                                Text("Single - Burna Boy",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width *
                                            0.028)),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width * 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.26,
                                          height: 20,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                  left: 0,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_1.png"),
                                                  )),
                                              Positioned(
                                                  left: 15,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_2.png"),
                                                  )),
                                              Positioned(
                                                  left: 35,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_3.png"),
                                                  )),
                                              Positioned(
                                                  left: 55,
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/circle_avatar_1.png"),
                                                  )),
                                            ],
                                          ),
                                        )),
                                    Text(
                                      "3000+ people suggested",
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ])),
                  ],
                )
              ]))
    ];

    List<Widget> _currentlyPlaying = [
      Text("Currently Playing"),
      SizedBox(height: 20),
      Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: DarkPalette.darkGrey1,
              borderRadius: BorderRadius.circular(15)),
          child: Row(children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "assets/images/album_art_1.png"))),
            ),
            SizedBox(width: 10),
            Flexible(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Implication",
                        style: TextStyle(
                            fontSize:
                            MediaQuery.of(context).size.width *
                                0.05,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02),
                  Text("Single - Burna Boy",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width *
                              0.028)),
                  SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.26,
                            height: 20,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                    left: 0,
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundImage: AssetImage(
                                          "assets/images/circle_avatar_1.png"),
                                    )),
                                Positioned(
                                    left: 15,
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundImage: AssetImage(
                                          "assets/images/circle_avatar_2.png"),
                                    )),
                                Positioned(
                                    left: 35,
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundImage: AssetImage(
                                          "assets/images/circle_avatar_3.png"),
                                    )),
                                Positioned(
                                    left: 55,
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundImage: AssetImage(
                                          "assets/images/circle_avatar_1.png"),
                                    )),
                              ],
                            ),
                          )),
                      Text(
                        "3000+ people suggested",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  )
                ],
              ),
            )
          ])),
    ];
    List<Widget> _upNext = [
      Text("Up next"),
      SizedBox(height: 20),
      Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: DarkPalette.darkGrey1,
              borderRadius: BorderRadius.circular(15)),
          child: Row(children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "assets/images/album_art_1.png"))),
            ),
            SizedBox(width: 10),
            Flexible(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Implication",
                        style: TextStyle(
                            fontSize:
                            MediaQuery.of(context).size.width *
                                0.05,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02),
                  Text("Single - Burna Boy",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width *
                              0.028)),
                  SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.26,
                            height: 20,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                    left: 0,
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundImage: AssetImage(
                                          "assets/images/circle_avatar_1.png"),
                                    )),
                                Positioned(
                                    left: 15,
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundImage: AssetImage(
                                          "assets/images/circle_avatar_2.png"),
                                    )),
                                Positioned(
                                    left: 35,
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundImage: AssetImage(
                                          "assets/images/circle_avatar_3.png"),
                                    )),
                                Positioned(
                                    left: 55,
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundImage: AssetImage(
                                          "assets/images/circle_avatar_1.png"),
                                    )),
                              ],
                            ),
                          )),
                      Text(
                        "3000+ people suggested",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  )
                ],
              ),
            )
          ])),
    ];

    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: ListView(
          padding: EdgeInsets.only(bottom: 50),
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, left: 5, right: 5),
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
                          child: _showAttendees ? _backButton : _timingBox)),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.topRight,
                          child:
                              _showAttendees ? _timingBox : _contextMenuDots)),
                  Positioned(
                    right: 0,
                    bottom: -40,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed(Routes.partyPlaylist);
                      }, child:Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: DarkPalette.borderGradient1,
                          ),
                          child: Center(
                              child: widget.userType == UserType.partyOrganizer ?
                               Image.asset("assets/images/music.png",
                                  height: 100, width: 100) :
                          Icon(IconlyBold.plus, color: Colors.white, size: 40,)),
                        )
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          'WSJ Rock Concert',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w900),
                        ),
                        subtitle: Text(
                          "2019 August, 2021",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                AssetImage("assets/images/circle_avatar_1.png"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "You",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 3),
                                Text("Organizer",
                                    style: TextStyle(
                                      fontSize: 10,
                                    ))
                              ])
                        ],
                      ),
                      SizedBox(height: 20),
                      _showAttendees
                          ? _attendees
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(
                                          "assets/images/circle_avatar_1.png"),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Sandra",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 3),
                                          Text("Organizer",
                                              style: TextStyle(
                                                fontSize: 10,
                                              ))
                                        ]),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _showAttendees = true;
                                        });
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: DarkPalette.borderGradient1,
                                        ),
                                        child: Center(child: Text("+500")),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 70),
                                Text(
                                  "Party Stats",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed(Routes.allSuggestions);
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            color: DarkPalette.darkGrey1,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              "assets/images/waving_hand.png",
                                              height: 30,
                                            ),
                                            SizedBox(height: 15),
                                            Text("257",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.w900)),
                                            SizedBox(height: 15),
                                            Text(
                                              "Total Suggestions",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 8),
                                            ),
                                          ],
                                        )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.048,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              Routes.acceptedSuggestions);
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              gradient:
                                                  DarkPalette.borderGradient1,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                              child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/images/thumbs_up.png",
                                                height: 30,
                                              ),
                                              SizedBox(height: 15),
                                              Text("157",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.w900)),
                                              SizedBox(height: 15),
                                              Text(
                                                "Accepted Suggestions",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 8),
                                              ),
                                            ],
                                          )),
                                        )),
                                  ],
                                ),
                                SizedBox(height: 50),
                                Text(
                                  "About",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900),
                                ),
                                SizedBox(height: 20),
                                Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Orci, scelerisque nunc, diam lorem. Nunc ipsum aliquet ornare nec pretium. Morbi semper fermentum, pellentesque tincidunt a, accumsan sodales. Blandit eget nisi consectetur odio fermentum. Praesent elementum ante feugiat non scelerisque pellentesque lectus ultricies sollicitudin. Ipsum a ut sit vel nulla sed odio nulla lectus. Fermentum turpis amet in..."),
                                SizedBox(height: 20),
                SongSuggestionList(
                  title: "Currently Playing",
                  itemCount: 1,
                ),
                                SizedBox(height: 30),
                                SongSuggestionList(
                                  title: "Up Next",
                                  itemCount: 1,
                                ),
                                SizedBox(height: 30),
                                SongSuggestionList(
                                  title: "Queued",
                                  itemCount: 4,
                                )
                              ],
                            )
                    ]))
          ],
        ),
      ),
    );
  }
}



class EventListScreen extends StatefulWidget {
  static const String routeName = "/eventList";
  @override
  _EventListScreen createState() => _EventListScreen();
}

class _EventListScreen extends State<EventListScreen> {
  UserType _userType = UserType.partyOrganizer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(IconlyBold.arrow_left),
          color: DarkPalette.darkGold,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        title: Text("Your Events"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Transform.rotate(
              angle: 90 * math.pi / 180,
              child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(backgroundColor: Colors.transparent,
                      context: context,
                            builder: (context)
                    {
                      return PopupWidget(
                        popup: Popup.searchFilter,
                      );
                    });
                  },
                  icon: Icon(
                    IconlyBold.filter,
                    color: DarkPalette.darkGold,
                  )))
        ],
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: ListView.separated(
            padding: EdgeInsets.only(top: 30, left: 18, right: 18),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed(Routes.eventDetail);
                  },
                  child: EventCard());;
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 30);
            },
            itemCount: 5),
      ),
    );
  }
}

