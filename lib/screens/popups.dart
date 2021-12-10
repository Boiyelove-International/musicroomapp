import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/styles.dart';

import '../routes.dart';

enum Popup { searchFilter, nowPlayingFilter, eventFilter, resultFilter }

class PopupWidget extends StatefulWidget{

  PopupWidget({Key? key, required this.popup}) : super(key: key);

  Popup popup;

  @override
  _PopupWidget createState() => _PopupWidget();
}
class _PopupWidget extends State<PopupWidget> {

  late Widget _selected;

// Filter Widgets
  final Widget _filterSearchPopup = Column(children: [
    Padding(
      padding:EdgeInsets.all(30),
      child: Text("Filter Search Results", style: GoogleFonts.workSans(
          fontSize: 18,
          fontWeight: FontWeight.bold
      ),)
    ),
    Row(children: [
      Padding(
        padding: EdgeInsets.all(1),
        child: Icon(IconlyBold.arrow_up, size:35, color: DarkPalette.darkGold)
      ),
      SizedBox(width:20),
      Text("Most Suggested", style: GoogleFonts.workSans(
        fontSize: 18,
        fontWeight: FontWeight.w300
      ))
    ]),
    SizedBox(height:30),
    Row(children: [
      Padding(
          padding: EdgeInsets.all(1),
          child: Icon(IconlyBold.arrow_down, color: DarkPalette.darkYellow, size:35)
      ),
      SizedBox(width:20),
      Text("Least Suggested", style: GoogleFonts.workSans(
          fontSize: 18,
          fontWeight: FontWeight.w300
      ))
    ]),
    SizedBox(height:30),
    Row(children: [
      Padding(
          padding: EdgeInsets.all(1),
          child: Icon(IconlyBold.arrow_up, size:35, color: DarkPalette.darkGold)
      ),
      SizedBox(width:20),
      Text("Most Played", style: GoogleFonts.workSans(
          fontSize: 18,
          fontWeight: FontWeight.w300
      ))
    ]),
    SizedBox(height:30),
    Row(children: [
      Padding(
          padding: EdgeInsets.all(1),
          child: Icon(IconlyBold.arrow_down, color: DarkPalette.darkYellow, size:35)
      ),
      SizedBox(width:20),
      Text("Least Played", style: GoogleFonts.workSans(
          fontSize: 18,
          fontWeight: FontWeight.w300
      ))
    ]),
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
  double sliderValue = 50.0;

  @override
  Widget build(BuildContext context) {
    final popup = widget.popup;
    Widget _nowPlayingPopup = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.292,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/player_art.png",
                  ),
                  fit: BoxFit.contain
              )
          ),
        ),
        Text("Essence ft Tems", style: GoogleFonts.workSans(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          height:2
        ),),
        Text("Single - Wizkid", style: GoogleFonts.workSans(
            fontWeight: FontWeight.w300,
            fontSize: 14,
            height:2
        )),
    Row(
    children: [
    Text("0:12"),
    Flexible(child: Slider(value: sliderValue, activeColor: Colors.amber, inactiveColor: Colors.white,
        max:100,onChanged:(double value){
        setState(() {
          sliderValue = value;
        });

    })),
    Text("0:30"),
    ],
    ),
       Padding(
         padding:EdgeInsets.only(left:30,top:10, bottom:10, right:30),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Container(
               padding: EdgeInsets.all(13),

               decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   image: DecorationImage(
                       image: AssetImage(
                           "assets/images/backward_icon.png"
                       ),
                       fit: BoxFit.contain
                   )
               ),
               child: Center(
                 child: Text("5s", style:TextStyle(fontSize: 10), textAlign: TextAlign.center,),
               ),
             ),
             Container(
               margin: EdgeInsets.only(left:10),
               height: 50,
               width:50,
               decoration: BoxDecoration(
                   image: DecorationImage(
                       image: AssetImage(
                           "assets/images/play_icon.png"
                       ),
                       fit: BoxFit.contain
                   )
               ),
             ),
             Container(
               padding: EdgeInsets.all(13),

               decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   image: DecorationImage(
                       image: AssetImage(
                           "assets/images/forward_icon.png"
                       ),
                       fit: BoxFit.contain
                   )
               ),
               child: Center(
                 child: Text("5s", style:TextStyle(fontSize: 10), textAlign: TextAlign.center,),
               ),
             )
           ],
         )
       )
      ],
    );


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
              topLeft: const Radius.circular(35.0),
              topRight: const Radius.circular(35.0),
            )),
        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
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