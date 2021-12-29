import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
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

class EventCard extends StatelessWidget {
  @override
  Widget build(context) {
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
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [Text("Starts in"), Text("24h: 30m")])))),
          Positioned.fill(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Text("Owambe Party",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900)),
                                  SizedBox(height: 10),
                                  Text("Hosted by - Owambe Hitz",
                                      style: TextStyle(fontSize: 10))
                                ])),
                            Flexible(
                                child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 35,
                              child: Stack(
                                children: [
                                  Positioned(
                                      right: 50,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/circle_avatar_2.png"),
                                      )),
                                  Positioned(
                                      right: 25,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/circle_avatar_3.png"),
                                      )),
                                  Positioned(
                                      right: 0,
                                      child: Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: DarkPalette.borderGradient1,
                                        ),
                                        child: Center(child: Text("+500")),
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
              image: AssetImage("assets/images/party_people_1.png"))),
    );
  }
}

class EventDetail extends StatefulWidget {
  static const String routeName = "/eventDetail";

  EventDetail({Key? key,
    this.userType = UserType.partyGuest,
    this.url, this.data,
    required this.event
  }): super(key: key);

  UserType? userType;
  Map<dynamic, dynamic>? data;
  String? url;
  Event event;

  @override
  _EventDetail createState() => _EventDetail();
}

class _EventDetail extends State<EventDetail> {
  bool _showAttendees = false;
  late Widget _rightContext;
  bool _showAbout = false;
  bool _showPartyStats = false;
  ApiBaseHelper _api = ApiBaseHelper();
  Event get _event => widget.event;
  set _event(Event value){
    widget.event = value;
  }

  @override
  Widget build(BuildContext context) {


    switch (widget.userType){
      case UserType.partyGuest:{
        _rightContext = _contextMenuDots;
        _showAbout = false;
      }
      break;
      case UserType.partyOrganizer:{
        _rightContext = _contextMenuDots;
        _showAbout = true;

      }
      break;
    }

    List<Widget> _widgetsList = [];


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
                      image: AssetImage("assets/images/album_art_1.png"))),
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
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  Text("Single - Burna Boy",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.028)),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
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
                      image: AssetImage("assets/images/album_art_1.png"))),
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
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  Text("Single - Burna Boy",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.028)),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
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
                    child: _showAttendees ? _timingBox : _rightContext)),
            Positioned(
              right: 0,
              bottom: -40,
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.partyPlaylist);
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: DarkPalette.borderGradient1,
                    ),
                    child: Center(
                        child: Image.asset("assets/images/music.png",
                            height: 100, width: 100)),
                  )),
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
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
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
                                fontSize: 15, fontWeight: FontWeight.bold),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontSize: 25, fontWeight: FontWeight.w900),
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
                            MediaQuery.of(context).size.width * 0.45,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: DarkPalette.darkGrey1,
                                borderRadius: BorderRadius.circular(10)),
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
                                            fontWeight: FontWeight.w900)),
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
                          width:
                          MediaQuery.of(context).size.width * 0.048,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.acceptedSuggestions);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width *
                                  0.45,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  gradient: DarkPalette.borderGradient1,
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
                                              fontWeight: FontWeight.w900)),
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
                          fontSize: 25, fontWeight: FontWeight.w900),
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Implication",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.05,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.02),
                                Text("Single - Burna Boy",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.028)),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.02),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.26,
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Implication",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.05,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.02),
                                Text("Single - Burna Boy",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.028)),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.02),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.26,
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Implication",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.05,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.02),
                                Text("Single - Burna Boy",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.028)),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.02),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.26,
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Implication",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.05,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.02),
                                Text("Single - Burna Boy",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.028)),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.02),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.26,
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Implication",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.05,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.02),
                                Text("Single - Burna Boy",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.028)),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.02),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.26,
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Implication",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.05,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.02),
                                Text("Single - Burna Boy",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.028)),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.02),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.26,
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Implication",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.05,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.02),
                                Text("Single - Burna Boy",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.028)),
                                SizedBox(
                                    height: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.02),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.26,
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

    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: ListView(
          padding: EdgeInsets.only(bottom: 50),
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, left: 5, right: 5),
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(_event.image??''))
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Positioned.fill(
                  //     child: Align(
                  //         alignment: Alignment.topLeft,
                  //         child: _showAttendees ? _backButton : _timingBox)),
                  Positioned(
                      left: 2,
                      top: 30,
                      child:
                      _showAttendees ? _backButton : _timingBox),
                  Positioned(
                    right: 2,
                      top: 30,
                      child:
                      _showAttendees ? _timingBox : _rightContext),
                  // Positioned.fill(
                  //     child: Align(
                  //         alignment: Alignment.topRight,
                  //         child:
                  //             _showAttendees ? _timingBox : _contextMenuDots)),
                  Positioned(
                    right: 0,
                    bottom: -40,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.partyPlaylist);
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: DarkPalette.borderGradient1,
                          ),
                          child: Center(
                              child: widget.userType == UserType.partyOrganizer
                                  ? Image.asset("assets/images/music.png",
                                      height: 100, width: 100)
                                  : Icon(
                                      IconlyBold.plus,
                                      color: Colors.white,
                                      size: 40,
                                    )),
                        )),
                  ),
                  Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width *  0.3,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              height:3,
                            )
                        ),
                      )),
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
                          '${_event.name}',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w900),
                        ),
                        subtitle: Text(
                            "${DateFormat("dd MMMM, yyyy").format(_event.event_date)}",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage(_event.organizer_display_picture ?? ''),
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
                                _buildAttendeeToggle(),
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
                                            Text("${_event.suggestions?.length ?? 0}",
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
                                    "${_event.about}"),
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

  Widget _buildAttendeeToggle(){
    if(_event.attendees.length == 0) return Container();

    Map attendee = _event.attendees[0];

    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage("${attendee['profile_picture']}"),
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
                "${attendee['display_name']}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3),
              Text("Attendee",
                  style: TextStyle(
                    fontSize: 10,
                  ))
            ]
        ),
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
            child: Center(child: Text("+${_event.attendees.length - 1}")),
          ),
        )
      ],
    );
  }

  Widget get _attendees => ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        Map attendee = _event.attendees[index];
        return Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage:NetworkImage(attendee['profile_photo']?? ''),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${attendee['display_name']}",
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3),
                  Text("Attendee",
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
      itemCount: _event.attendees.length
  );
  Widget get _timingBox => Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text("Starts in"), Text("24h: 30m")]));
  Widget get _contextMenuDots => FocusedMenuHolder(
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
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context)=> YourRoom(
                      code: _event.code!,
                    )
                )
              );
            }),
        FocusedMenuItem(
            title: Text("Edit Event", style: TextStyle(color: Colors.black)),
            onPressed: () {
              toggleEditEvent();
            }
        ),
        FocusedMenuItem(
            title: Text("Delete Event", style: TextStyle(color: Colors.red)),
            onPressed: _deleteEvent
        )
      ]);

  Widget get _backButton => IconButton(
    icon: Icon(IconlyBold.arrow_left),
    color: Colors.white,
    onPressed: () {
      setState(() {
        _showAttendees = false;
      });
    },
  );
  Widget get _infoBox => IconButton(
    icon: Icon(IconlyBold.arrow_left),
    color: Colors.white,
    onPressed: () {
      setState(() {
        _showAttendees = false;
      });
    },
  );

  toggleEditEvent(){
    showModalBottomSheet<void>(
        builder: (BuildContext context) => Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0),
                )),
            padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
            height: MediaQuery.of(context).size.height * 0.6,
            child: CreateEventForm(
                event: _event,
                callback: (Event updateEvent){
                  setState(() { _event = updateEvent;   });
                  Navigator.pop(context);
                },
            )
        ),
        backgroundColor: Colors.transparent,
        context: context
    ).whenComplete((){

    });
  }
  _deleteEvent()async {
    ApiBaseHelper _api = ApiBaseHelper();
    _api.delete("/event/${_event.id}/", {});
    Navigator.pop(context, {"rm_event":_event.id});
  }
}

class EventDetailPartyGuest extends StatefulWidget {
  static const String routeName = "/evetDetail";

  EventDetailPartyGuest({Key? key,
    this.userType = UserType.partyGuest,
    this.eventStatus = EventStatus.EventPending, required this.event})
      : super(key: key);

  UserType? userType;
  EventStatus? eventStatus;
  Event event;

  @override
  _EventDetailPartyGuest createState() => _EventDetailPartyGuest();
}

class _EventDetailPartyGuest extends State<EventDetailPartyGuest> {
  bool _showAttendees = false;
  bool _showAbout = false;
  List<Widget> _suggestionPlaylist = [];
  late String _timingTitle;
  Event get event=> widget.event;

  @override
  void initState(){
    // super.initState();
    setState(() {

      switch (widget.eventStatus){
        case EventStatus.EventPending:{
          _timingTitle = "Starts in";
          _suggestionPlaylist = [
            SongSuggestionList(
              title: "All Suggestions",
              itemCount: 3,
              trailing: true,
            ),
            SizedBox(height: 50),
            SongSuggestionList(
              title: "Your Suggestions",
              itemCount: 3,
              trailing: true,
            ),
          ];
        }
        break;
        case EventStatus.EventStarted:{
          _timingTitle = "Started";
          _suggestionPlaylist = [
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
              trailing: true
            )
          ];
        }
        break;
        case EventStatus.EventEnded:{
          _timingTitle = "Event Ended";
          _suggestionPlaylist = [
            SongSuggestionList(
                title: "Event Playlist",
                itemCount: 8,
                trailing: true
            )
          ];
        }
        break;
      }
    });
}


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
                NetworkImage("${event.organizer_display_picture}"),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${event.organizer}",
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
            children: [Text("$_timingTitle",
            style: GoogleFonts.workSans(
              fontSize: 12,
              fontWeight: FontWeight.w300
            ),), Text("24h: 30m",
                style: GoogleFonts.workSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ))]));
    Widget _backButton = IconButton(
      icon: Icon(IconlyBold.arrow_left),
      color: Colors.white,
      onPressed: () {
        setState(() {
          if (_showAttendees){
            _showAttendees = false;
          }
          if(_showAbout){
            _showAbout = false;
          }
        });
      },
    );
    Widget _infoBox = IconButton(
      icon: Icon(IconlyBold.info_circle,
      size: 30),
      color: Colors.white,
      onPressed: () {
        setState(() {
          _showAbout = true;
        });
      },
    );;

    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: ListView(
          padding: EdgeInsets.only(bottom: 50),
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, left: 5, right: 5),
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("${event.image}")
                  )
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                      left: 2,
                      top: 30,
                      child:
                      (_showAttendees || _showAbout) ? _backButton : _timingBox),
                  Positioned(
                      right: 2,
                      top: 30,
                      child:
                      (_showAttendees || _showAbout) ? _timingBox : _infoBox),
                  Positioned(
                    right: 0,
                    bottom: -40,
                    child: GestureDetector(
                        onTap: () {

                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) => Wrap(
                                children: [Container(
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(40.0),
                                      topRight: const Radius.circular(40.0),
                                    )),
                                padding: EdgeInsets.only(
                                    top: 30, left: 20, right: 20, bottom: 20),
                                height: MediaQuery.of(context).size.height * 0.7,
                                child: SuggestSongForm())]),
                          );


                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: DarkPalette.borderGradient1,
                          ),
                          child: Center(
                              child: widget.userType == UserType.partyOrganizer
                                  ? Image.asset("assets/images/music.png",
                                  height: 100, width: 100)
                                  : Icon(
                                IconlyBold.plus,
                                color: Colors.white,
                                size: 40,
                              )),
                        )),
                  ),
                  Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width *  0.3,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              height:3,
                            )
                        ),
                      )),
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
                          '${event.name}'.capitalize(),
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w900),
                        ),
                        subtitle: Text(
                          "${event.renderDate()}",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                            NetworkImage("${event.organizer_display_picture}"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${event.organizer}',
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
                          _buildAttendeeToggle(),
                          Visibility(visible: _showAbout,
                          child: SizedBox(height: 50)),
                          Visibility(visible: _showAbout,
                          child:Text(
                            "About",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900),
                          )),
                          Visibility(visible: _showAbout,
                          child:SizedBox(height: 20)),
                          Visibility(visible: _showAbout,
                          child:Text(
                              "${event.about}".capitalize())),
                          SizedBox(height: 30),
                          Visibility(
                              visible: !_showAbout,
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [..._suggestionPlaylist],
                          ))
                        ],
                      )
                    ]))
          ],
        ),
      ),
    );
  }

  Widget _buildAttendeeToggle(){
    if(event.attendees.length == 0) return Container();

    Map attendee = event.attendees[0];

    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage("${attendee['profile_picture']}"),
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
                "${attendee['display_name']}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3),
              Text("Attendee",
                  style: TextStyle(
                    fontSize: 10,
                  ))
            ]
        ),
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
            child: Center(child: Text("+${event.attendees.length - 1}")),
          ),
        )
      ],
    );
  }
}


class EventListScreen extends StatefulWidget {
  EventListScreen({Key? key,  this.url = "/events/"})
      : super(key: key);

  static const String routeName = "/eventList";
  String url;
  @override
  _EventListScreen createState() => _EventListScreen();
}

class _EventListScreen extends State<EventListScreen> {
  UserType _userType = UserType.partyOrganizer;
  ApiBaseHelper _api = ApiBaseHelper();

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
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
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
        child: FutureBuilder(
          future: _api.get("${widget.url}"),
          builder: (context, snapshot){
            if (snapshot.hasData){
              var itemList = snapshot.data as List;
              if (itemList.isNotEmpty){
                return ListView.separated(
                    padding: EdgeInsets.only(top: 30, left: 18, right: 18),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            // Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop,
                            //     child: EventDetail()));

                            // Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop,
                            //     child: EventDetailPartyGuest()));
                          },
                          child: EventCard());
                      ;
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 30);
                    },
                    itemCount: 5);
              }
              return EmptyContent();
            } if (snapshot.hasError){
              return Text("Oops! something went wrong");
            }
            return CircularProgressIndicator(
              color: Colors.amber,
              strokeWidth: 1,
            );
          }
        ),
      ),
    );
  }
}

class PartyGuestEventCardList extends StatelessWidget {
  @override
  Widget build(BuildContext) {
    return EventListScreen();
  }
}
