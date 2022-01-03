import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/screens/empty_content.dart';
import 'package:musicroom/screens/event_card.dart';
import 'package:musicroom/screens/event_details.dart';
import 'package:musicroom/screens/events.dart';
import 'package:musicroom/screens/popups.dart';
import 'package:musicroom/utils.dart';
import 'package:musicroom/utils/apiServices.dart';
import 'package:musicroom/utils/models.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:math' as math;
import '../routes.dart';
import '../styles.dart';

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
                        Event event = Event.fromJson(itemList[index]);
                        return InkWell(
                          child: Container(
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
                                                                "${event.name}",
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w900)),
                                                            SizedBox(
                                                                height: 10),
                                                            Text(
                                                                "Hosted by - ${event.organizer}",
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
                                                          children: MRbuildAttendeeIcons(event, alignment: "right"),
                                                        ),
                                                      ))
                                                ]
                                            )
                                        )
                                    )
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(event.image??'')
                                )
                            ),
                          ),
                          onTap: (){
                            Navigator.push(
                                context,PageTransition(type: PageTransitionType.bottomToTop,
                                child: EventDetail(
                                  event: event,
                                  userType: UserType.partyGuest,
                                ))
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 30);
                      },
                      itemCount: itemList.length);
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
