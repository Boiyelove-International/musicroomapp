import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/screens/popups.dart';
import 'package:musicroom/screens/search.dart';
import 'package:musicroom/styles.dart';
import 'package:musicroom/utils/apiServices.dart';
import 'package:musicroom/utils/models.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes.dart';
import 'events.dart';

class EventOrganizerHome extends StatefulWidget {
  static const String routeName = "/eventOrganizerHome";
  EventOrganizerHome({Key? key }) : super(key: key);

  @override
  _EventOrganizerHome createState() => _EventOrganizerHome();
}

class _EventOrganizerHome extends State<EventOrganizerHome>{
  bool showFab = true;
  String? display_name = "PartyMixers";
  TextEditingController _searchContoller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      display_name  = prefs.getString("display_name");
    });
  }

  @override
  Widget build(context){
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          title:Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Hello,", style: GoogleFonts.workSans(
                  fontSize: 20, fontWeight: FontWeight.w300
              ),), SizedBox(width: 5), Text(
                "$display_name" ,
                style: GoogleFonts.workSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 27,
                ),)],
          ),
          actions: [
            Row(
              children: <Widget>[
                InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.profile);
                    },
                    child: Container(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                            "assets/images/organizer-profile-icon.png"))),
                IconButton(
                    icon: Icon(IconlyBold.notification),
                    color: DarkPalette.darkGold,
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.notifications);
                    })
              ],
            )
          ],
        ),
        body: SafeArea(
            top: true,
            bottom: true,
            child: Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: CustomScrollView(slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/home-gradient-bg.png"),
                              fit: BoxFit.cover,
                            )),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Center(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Find your hits and favourties and add them to events, let's go.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        height: 2),
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: _searchContoller,
                                    validator: (value){
                                      if (value!.isEmpty || value == null){
                                        return "Enter a search query";
                                      }
                                    },
                                    autofocus: false,
                                    autocorrect: false,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(7.0),
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(7.0),
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(7.0),
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "Find those hits",
                                      hintStyle: TextStyle(fontSize: 13),
                                      contentPadding: EdgeInsets.only(
                                          left: 15, right: 15, top: 5, bottom: 5),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          IconlyBold.search,
                                          color: DarkPalette.darkGold,
                                        ),
                                        onPressed: () {

                                          if (_searchContoller.text != null && _searchContoller.text.isNotEmpty){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => SearchResultScreen(
                                                url: "/search/?term=${_searchContoller.text}",
                                              )),
                                            );
                                          }


                                        }),
                                    ),
                                  ),
                                ]))),
                  ),
                  SliverAppBar(
                      backgroundColor: Colors.transparent,
                      pinned: true,
                      flexibleSpace: Padding(
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 10),
                          child: Row(
                            children: [
                              Text("Your Events", style: GoogleFonts.workSans(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700
                              )),
                              Spacer(),
                              Transform.rotate(
                                  angle: 90 * math.pi / 180,
                                  child: IconButton(
                                      onPressed: () {
                                        showFab = false;
                                        showModalBottomSheet(context: context,
                                            backgroundColor:
                                            Colors.transparent,
                                            builder: (context){
                                              return PopupWidget(
                                                popup: Popup.searchFilter,
                                              );
                                            }).whenComplete(() => setState((){
                                          showFab = true;
                                        }));

                                      },
                                      icon: Icon(
                                        IconlyBold.filter,
                                        color: DarkPalette.darkGold,
                                      )))
                            ],
                          ))),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
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
                                                mainAxisSize: MainAxisSize
                                                    .min,
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
                                                            Text(
                                                                "Owambe Party",
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w900)),
                                                            SizedBox(
                                                                height: 10),
                                                            Text(
                                                                "Hosted by - Owambe Hitz",
                                                                style: TextStyle(
                                                                    fontSize: 10))
                                                          ])),
                                                  Flexible(
                                                      child: Container(
                                                        width: MediaQuery
                                                            .of(context)
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
                                        "assets/images/party_people_${index +
                                            1}.png"))),
                          );
                        },
                        childCount: 4, // 1000 list items
                      )
                  )
                ]))),
        floatingActionButton: Visibility(
            visible: showFab,
            child: FloatingActionButton.extended(
                backgroundColor: DarkPalette.darkGold,
                onPressed: () {
                  setState(() {
                    showFab = false;
                  });
                  showModalBottomSheet<void>(
                      builder: (BuildContext context) => Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(40.0),
                                topRight: const Radius.circular(40.0),
                              )),
                          padding: EdgeInsets.only(
                              top: 30, left: 20, right: 20, bottom: 20),
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: CreateEventForm()),
                      backgroundColor: Colors.transparent,
                      context: context)
                      .whenComplete(() => setState(() {
                    showFab = true;
                  }));
                },
                label: Text("Create an Event",
                    style: TextStyle(color: Colors.black)))));
  }
}


class PartyGuestHome extends StatefulWidget {
  static const String routeName = "/homeScreen";
  PartyGuestHome({Key? key, this.userType = UserType.partyOrganizer}) : super(key: key);

  UserType? userType;

  @override
  _PartyGuestHome createState() => _PartyGuestHome();
}

class _PartyGuestHome extends State<PartyGuestHome> {
  bool showFab = true;
  ApiBaseHelper _api = ApiBaseHelper();
  String display_name = "Guest";
  TextEditingController _searchContoller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    SharedPreferences.getInstance().then((prefs) => setState((){
      display_name = prefs.getString("display_name")!;
    }));

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // FocusScopeNode currentFocus = FocusScope.of(context);

    // if (!currentFocus.hasPrimaryFocus) {
    //   currentFocus.unfocus();
    // }


    return Scaffold(

        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.partyGuestProfile);
              },
              child: Container(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                      "assets/images/circle_avatar_1.png"))),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Text("Hello,", style: GoogleFonts.workSans(
              fontSize: 27, fontWeight: FontWeight.w300
            ),), SizedBox(width: 5), Text(
              "${display_name}",
              style: GoogleFonts.workSans(
                fontWeight: FontWeight.w700,
                fontSize: 27,
              ),)],
          ),
          actions: [
            Row(
              children: <Widget>[

                IconButton(
                    icon: Icon(IconlyBold.notification),
                    color: DarkPalette.darkGold,
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.notifications);
                    })
              ],
            )
          ],
        ),
        body: SafeArea(
            top: true,
            bottom: true,
            child: Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: ListView(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          margin: EdgeInsets.only(top: 20, bottom: 20),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/home-gradient-bg.png"),
                                fit: BoxFit.cover,
                              )),
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Center(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Find your hits and favourties and add them to events, let's go.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          height: 2),
                                    ),
                                    SizedBox(height: 20),
                                    TextFormField(
                                      controller: _searchContoller,
                                      validator: (value){
                                        if (value!.isEmpty || value == null){
                                          return "Enter a search query";
                                        }
                                      },
                                      autofocus: false,
                                      autocorrect: false,
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(7.0),
                                            borderSide: BorderSide(
                                                color: Colors.transparent)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(7.0),
                                            borderSide: BorderSide(
                                                color: Colors.transparent)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(7.0),
                                            borderSide: BorderSide(
                                                color: Colors.transparent)),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "Find those hits",
                                        hintStyle: TextStyle(fontSize: 13),
                                        contentPadding: EdgeInsets.only(
                                            left: 15, right: 15, top: 5, bottom: 5),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            IconlyBold.search,
                                            color: DarkPalette.darkGold,
                                          ),
                                          onPressed: () {
                                            if (_searchContoller.text != null && _searchContoller.text.isNotEmpty){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => SearchResultScreen(
                                                  url: "/search/?term=${_searchContoller.text}",
                                                )),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ]))),
                      Container(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height:30),
                              Row(
                                children: [
                                  Text("Trending Suggestions", style: GoogleFonts.workSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700
                                  )),
                                  Spacer(),
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SearchResultScreen(
                                          title: "Trending Result",
                                          url: "/suggestions/?qt=trending",
                                        )),
                                      );
                                    },
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Text("See All", style: TextStyle(
                                                color: Colors.amber
                                            )),
                                            Icon(Icons.arrow_right,
                                                color: Colors.amber)
                                          ],
                                        ),
                                      )
                                  )
                                ],
                              ),
                              SizedBox(height:30),
                              FutureBuilder(
                                future: _api.get("/suggestions/?qt=trending"),
                                builder: (context, snapshot){
                                 if (snapshot.hasData){
                                   var itemList = snapshot.data as List;
                                   if (itemList.isNotEmpty){
                                     return GridView.builder(
                                         shrinkWrap: true,
                                         physics: NeverScrollableScrollPhysics(),
                                         gridDelegate:
                                         SliverGridDelegateWithFixedCrossAxisCount(
                                           // maxCrossAxisExtent: 300,
                                             mainAxisExtent: 230,
                                             // childAspectRatio: 2 / 3,
                                             crossAxisCount: 2,
                                             crossAxisSpacing: 20,
                                             mainAxisSpacing: 20),
                                         itemCount: 2,
                                         itemBuilder: (context, index){
                                           return GestureDetector(
                                               onTap: (){
                                                 showModalBottomSheet<void>(
                                                   isScrollControlled: true,
                                                   backgroundColor: Colors.transparent,
                                                   context: context,
                                                   builder: (BuildContext context) => Container(
                                                       decoration: BoxDecoration(
                                                           color: Colors.black,
                                                           borderRadius: new BorderRadius.only(
                                                             topLeft: const Radius.circular(40.0),
                                                             topRight: const Radius.circular(40.0),
                                                           )),
                                                       padding: EdgeInsets.only(
                                                           top: 30, left: 20, right: 20, bottom: 20),
                                                       height: MediaQuery.of(context).size.height * 0.7,
                                                       child: SuggestEventForm()),
                                                 );

                                               },
                                               child:EventCardGold(
                                                   title: "Essence ft Tems",
                                                   artist: "Wizkid",
                                                   image: "ahsdfggg.jpg"
                                               ));
                                         });
                                   }
                                   return EmptyContent();
                                 } else if (snapshot.hasError){
                                   return Text("Oops! something went wrong");
                                 }
                                 return CircularProgressIndicator(
                                   color: Colors.amber,
                                   strokeWidth: 1,
                                 );
                                },
                              ),
                              SizedBox(height:30),
                            ]
                        ),
                      ),
                      Container(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height:30),
                              Row(
                                children: [
                                  Text("Your Events", style: GoogleFonts.workSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700
                                  )),
                                  Spacer(),
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => EventListScreen(
                                          url: "/events/"
                                        )),
                                      );
                                    },
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Text("See All", style: TextStyle(
                                                color: Colors.amber
                                            )),
                                            Icon(Icons.arrow_right,
                                                color: Colors.amber)
                                          ],
                                        ),
                                      )
                                  )
                                ],
                              ),
                              SizedBox(height:30),
                              FutureBuilder(
                                future: _api.get("/events/"),
                                builder:(context, snapshot){
                                  if (snapshot.hasData){
                                    var itemList = snapshot.data as List;

                                    if (itemList.isNotEmpty){
                                      return GridView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            // maxCrossAxisExtent: 300,
                                              mainAxisExtent: 230,
                                              // childAspectRatio: 2 / 3,
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 20),
                                          itemCount: itemList.length,
                                          itemBuilder: (context, index){
                                            Event event = Event.fromJson(itemList[index]);
                                            return GestureDetector(
                                                onTap: (){
                                                  Navigator.push(
                                                      context,PageTransition(type: PageTransitionType.bottomToTop,
                                                      child: EventDetailPartyGuest(
                                                        userType: UserType.partyGuest,
                                                        event: event,
                                                      )));

                                                },
                                                child:EventCardGold(
                                                    title: "Essence ft Tems",
                                                    artist: "Wizkid",
                                                    image: "ahsdfggg.jpg"
                                                ));
                                          });
                                    }
                                    return EmptyContent();
                                  } else if (snapshot.hasError ){
                                    return Center(
                                      child: Text("Oops Something went wrong"),
                                    );
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.amber,
                                      strokeWidth: 1,
                                    ),
                                  );
                                }
                              ),
                              SizedBox(height:30),
                            ]
                        ),
                      ),


                ]))),
        floatingActionButton: Visibility(
            visible: showFab,
            child: FloatingActionButton.extended(
                backgroundColor: DarkPalette.darkGold,
                onPressed: () {
                  setState(() {
                    showFab = false;
                  });
                  showModalBottomSheet<void>(
                      isScrollControlled: true,
                          builder: (BuildContext context) => Wrap(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(40.0),
                                        topRight: const Radius.circular(40.0),
                                      )),
                                  padding: EdgeInsets.only(
                                      top: 30, left: 20, right: 20, bottom: 20),
                                  height: MediaQuery.of(context).size.height * 7,
                                  child: JoinEventForm())
                            ],
                          ),
                          backgroundColor: Colors.transparent,
                          context: context)
                      .whenComplete(() => setState(() {
                            showFab = true;
                          }));
                },
                label: Text("Join an Event",
                    style: TextStyle(color: Colors.black)))));
  }
}
