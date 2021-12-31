import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/screens/empty_content.dart';
import 'package:musicroom/screens/event_card.dart';
import 'package:musicroom/screens/events.dart';
import 'package:musicroom/screens/popups.dart';
import 'package:musicroom/utils/apiServices.dart';
import 'package:musicroom/utils/models.dart';
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
