import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/styles.dart';

import '../routes.dart';

enum Popup { searchFilter, nowPlayingFilter, eventFilter, resultFilter }

class PopupWidget extends StatelessWidget {
  Popup popup;
  late Widget _selected;

  PopupWidget({required this.popup});

// Filter Widgets
  final Widget _filterSearchPopup = Column(children: [
    Text("Filter Search Results"),
    Row(children: [
      Icon(IconlyBold.arrow_up, color: DarkPalette.darkGold),
      Text("Most Suggested")
    ]),
    Row(children: [
      Icon(IconlyBold.arrow_down, color: DarkPalette.darkYellow),
      Text("Least Suggested")
    ]),
    Row(children: [
      Icon(IconlyBold.arrow_up, color: DarkPalette.darkGold),
      Text("Most Played")
    ]),
    Row(children: [
      Icon(IconlyBold.arrow_down, color: DarkPalette.darkYellow),
      Text("Least Played")
    ])
  ]);

  final Widget _nowPlayingPopup = Column(children: [
    Container(
      child: Image.asset("assets/images/event_imagery_banner.png"),
    ),
    Text("Essence ft Tems"),
    Text("Single - Wizkid"),
    Row(children: [
      Flexible(child: Text("0:12")),
      Flexible(child: LinearProgressIndicator(value: 40)),
      Flexible(child: Text("0:30"))
    ]),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: null, icon: Icon(IconlyBold.arrow_left_circle)),
        IconButton(onPressed: null, icon: Icon(IconlyBold.play)),
        IconButton(onPressed: null, icon: Icon(IconlyBold.arrow_right_circle))
      ],
    )
  ]);

  final Widget _filterEventPopup = Column(children: [
    Text("Filter Search Results"),
    Row(children: [
      Icon(IconlyBold.arrow_up, color: DarkPalette.darkGold),
      Text("Already Started")
    ]),
    SizedBox(height: 20),
    Row(children: [
      Icon(IconlyBold.arrow_down, color: DarkPalette.darkYellow),
      Text("Concluded Events")
    ]),
    SizedBox(height: 20),
    Row(children: [
      Icon(IconlyBold.arrow_up, color: DarkPalette.darkGold),
      Text("Most Attendees")
    ]),
    SizedBox(height: 20),
    Row(children: [
      Icon(IconlyBold.arrow_down, color: DarkPalette.darkYellow),
      Text("Least TIme Left")
    ])
  ]);

  final Widget _filterResultPopup = Column(children: [
    Text("Filter Search Results"),
    Row(children: [
      Icon(IconlyBold.arrow_up, color: DarkPalette.darkGold),
      Text("Party Playlist")
    ]),
    Row(children: [
      Icon(IconlyBold.arrow_up, color: DarkPalette.white),
      Text("Accepted Suggestions")
    ]),
    Row(children: [
      Icon(IconlyBold.arrow_up, color: DarkPalette.darkGold),
      Text("Newly Suggested")
    ]),
  ]);

  @override
  Widget build(BuildContext context) {
    switch (popup) {
      case Popup.eventFilter:
        _selected = _filterEventPopup;
        break;
      case Popup.nowPlayingFilter:
        _selected = _nowPlayingPopup;
        break;
      case Popup.nowPlayingFilter:
        _selected = _nowPlayingPopup;
        break;
      default:
        _selected = _filterSearchPopup;
    }
    return Container(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(40.0),
              topRight: const Radius.circular(40.0),
            )),
        padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
        height: MediaQuery.of(context).size.height * 0.6,
        child: _selected);
  }
}

class CreateEventForm extends StatefulWidget {
  @override
  _CreateEventForm createState() => _CreateEventForm();
}

class _CreateEventForm extends State<CreateEventForm> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    void _changePage(int curr_page) {
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          curr_page,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    }

    // Create Event FLow
    Widget _createEventForm = Form(
        child: Column(
      children: [
        Text("Let's create the event!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900)),
        SizedBox(height: 30),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
                borderSide: BorderSide(color: Colors.white)),
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            fillColor: Colors.transparent,
            labelText: "Name of the Event",
            labelStyle: TextStyle(fontSize: 13, color: Colors.white),
            contentPadding:
                EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          ),
        ),
        SizedBox(height: 30),
        TextFormField(
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
                borderSide: BorderSide(color: Colors.white)),
            filled: true,
            fillColor: Colors.transparent,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: "About the Event",
            labelStyle: TextStyle(fontSize: 13, color: Colors.white),
            contentPadding:
                EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          ),
        ),
        SizedBox(height: 30),
        Row(children: [
          Expanded(
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
                _changePage(1);
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Text("Proceed",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ))
        ])
      ],
    ));

    Widget _eventTimeForm = Form(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(
        "Time & Date for this event",
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 30),
      TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: BorderSide(color: Colors.white)),
          filled: true,
          fillColor: Colors.transparent,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: "Time of this event",
          labelStyle: TextStyle(fontSize: 13, color: Colors.white),
          contentPadding:
              EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          prefixIcon: Icon(
            IconlyBold.time_circle,
            color: DarkPalette.darkGold,
          ),
        ),
      ),
      SizedBox(height: 20),
      TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: BorderSide(color: Colors.white)),
          filled: true,
          fillColor: Colors.transparent,
          labelText: "Name of the Event",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(fontSize: 13, color: Colors.white),
          contentPadding:
              EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
          prefixIcon: Icon(
            IconlyBold.calendar,
            color: DarkPalette.darkGold,
          ),
        ),
      ),
      SizedBox(height: 20),
      Row(children: [
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
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
              _changePage(2);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Text("Proceed",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
        ))
      ])
    ]));

    Widget _eventImageFormPopup = Form(
        child: Column(children: [
      Text(
        "Time for some imagery",
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 20),
      Container(
        child: Image.asset("assets/images/upload_image_banner.png"),
      ),
      SizedBox(height: 20),
      Text(
        "Click to upload the banner image for this event",
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 20),
      Row(children: [
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
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
              _changePage(3);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Text("Proceed",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
        ))
      ])
    ]));

    Widget _eventCreatedPopup = Form(
        child: Column(children: [
      Container(
        child: Image.asset("assets/images/event_created_success.png"),
      ),
      SizedBox(height: 20),
      Text(
        "Yay!! Your event has been created.",
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 20),
      Text(
          "Proceed to the event page to share and see all suggested songs for this event",
          textAlign: TextAlign.center),
      SizedBox(height: 20),
      Row(children: [
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
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
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(Routes.eventDetail);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Text("Go to Event",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
        ))
      ])
    ]));

    return PageView(
        // physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          _createEventForm,
          _eventTimeForm,
          _eventImageFormPopup,
          _eventCreatedPopup,
        ]);
  }
}
