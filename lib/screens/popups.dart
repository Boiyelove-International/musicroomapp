import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/styles.dart';
import 'package:musicroom/utils/models.dart';

import '../routes.dart';
import '../utils.dart';

enum Popup { searchFilter, nowPlayingFilter, eventFilter, resultFilter, suggestionFilter }

class PopupWidget extends StatefulWidget{

  PopupWidget({Key? key, required this.popup, this.userType, this.height = 0.6}) : super(key: key);

  UserType? userType;
  Popup popup;
  double? height;


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
    final userType = widget.userType;
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
       ),
        Visibility(
          visible: userType == UserType.partyGuest ?
          true : false,
          child:
          SizedBox(height: 30),
        ),
    Visibility(
        visible: userType == UserType.partyGuest ?
        true : false,
        child:  Padding(
      padding: EdgeInsets.all(2.0),
      child: Row(
        children: [
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
                  Navigator.pushReplacementNamed(context, Routes.guestHome);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text("Suggest an event",
                      style: GoogleFonts.workSans(
                          color: DarkPalette.darkDark,
                          fontWeight: FontWeight.bold
                      )),
                ),
              ),
            ),
          )
        ],
      ),
    ))

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


    Widget suggestionList = Column(
      mainAxisSize: MainAxisSize.min,
      children:[
        Text("What event are you suggesting this song for?"),
        GridView.builder(
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
              return Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: DarkPalette.borderGradient1

                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/album_art_7.png"
                                  ),
                                  fit: BoxFit.cover
                              )
                          ),
                        )
                    ),
                    SizedBox(height:15),
                    Text("Essence ft. Tems", style: GoogleFonts.workSans(
                        color: Colors.black, fontSize: 12,
                        fontWeight: FontWeight.w500
                    )),
                    SizedBox(height:5),
                    Text("Single - Wizkid", style: GoogleFonts.workSans(
                        color: Colors.black, fontSize: 12,
                        fontWeight: FontWeight.w500
                    ))
                  ],
                ),
              );
            })
      ]
    );
    Widget _yaySuggestionPopup = Column(children: [
      Container(
        child: Image.asset("assets/images/suggesttion_created_Illustration.png"),
      ),
      SizedBox(height: 20),
      Text(
        "Yay!! Your song has been suggested for this event",
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 20),
      Text(
          "You will get updated on the status of your suggestion as soon as soon as the event organizer approves it",
          textAlign: TextAlign.center),
      SizedBox(height: 20),
    ]);
    Widget _suggestionApprovedPopup = Column(children: [
      Container(
        child: Image.asset("assets/images/event_created_success.png"),
      ),
      SizedBox(height: 20),
      Text(
        "Cool Suggestion",
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 20),
      Text(
          "You seem to know your stuff, nice suggestion thanks for adding life to the party",
          textAlign: TextAlign.center),
      SizedBox(height: 20),
    ]);

    return Container(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(35.0),
              topRight: const Radius.circular(35.0),
            )),
        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        height: MediaQuery.of(context).size.height * widget.height!,
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



class SuggestEventForm extends StatefulWidget{
  @override
_SuggestEventForm createState() => _SuggestEventForm();
}

class _SuggestEventForm extends State<SuggestEventForm>{
  @override
  Widget build(BuildContext context){
    return Container();
  }
}

class JoinEventForm extends StatefulWidget{
  @override
  _JoinEventForm createState() => _JoinEventForm();
}

class _JoinEventForm extends State<JoinEventForm>{
  PageController _pageController = PageController(initialPage: 0);
  UserType _selectedUserType = UserType.partyOrganizer;

  @override
  Widget build(BuildContext context) {
    final TextStyle subtitle2 = Theme.of(context).textTheme.subtitle2!;
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


    Widget _eventChoice = Column(
      children: [
        Text("Yay!! We partying soon"),
        Text("Choose your preferred method to join this event"),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedUserType = UserType.partyOrganizer;
                  });
                },
                child: Stack(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width *
                            0.43,
                        height:
                        MediaQuery.of(context).size.width *
                            0.55,
                        decoration: BoxDecoration(
                            color: DarkPalette.darkYellow,
                            border: _selectedUserType ==
                                UserType.partyOrganizer
                                ? GradientBorder.uniform(
                                width: 3.0,
                                gradient: DarkPalette
                                    .borderGradient1)
                                : null,
                            borderRadius:
                            BorderRadius.circular(8)),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.asset(
                                "assets/images/code_icon.png"),
                          ),
                        )),
                    Positioned.fill(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text("Unique Code",
                                  style: GoogleFonts.workSans(
                                      textStyle: subtitle2,
                                      color: DarkPalette.darkDark,
                                      fontWeight:
                                      FontWeight.w400
                                  )))),
                    ),
                    Visibility(
                      visible: _selectedUserType ==
                          UserType.partyOrganizer
                          ? true
                          : false,
                      child: Positioned.fill(
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.check_circle,
                                    color: DarkPalette.darkGold,
                                    size: 20))),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedUserType = UserType.partyGuest;
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                          width:
                          MediaQuery.of(context).size.width *
                              0.43,
                          height:
                          MediaQuery.of(context).size.width *
                              0.55,
                          decoration: BoxDecoration(
                              color: DarkPalette.darkYellow,
                              border: _selectedUserType ==
                                  UserType.partyGuest
                                  ? GradientBorder.uniform(
                                  width: 3.0,
                                  gradient: DarkPalette
                                      .borderGradient1)
                                  : null,
                              borderRadius:
                              BorderRadius.circular(8)),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.asset(
                                  "assets/images/scan_icon.png"),
                            ),
                          )),
                      Positioned.fill(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Text("Scan QR Code",
                                    style:GoogleFonts.workSans(
                                        textStyle: subtitle2,
                                        color: DarkPalette.darkDark,
                                        fontWeight:
                                        FontWeight.w400
                                    )))),
                      ),
                      Visibility(
                        visible: _selectedUserType ==
                            UserType.partyGuest
                            ? true
                            : false,
                        child: Positioned.fill(
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(Icons.check_circle,
                                      color: DarkPalette.darkGold,
                                      size: 20))),
                        ),
                      )
                    ],
                  )),
            ]),
      ],
    );

    Widget _partyCodeForm = Column(
      children: [
        Text("Provide a code"),
        Text("Kindly enter the party code to join the party of your choice"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height:90,
              width: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: DarkPalette.darkYellow)

              ),
              child: Center(
                  child: Text("|", style: GoogleFonts.workSans(
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                      color: Colors.amber
                  ))
              ),
            ),
            Container(
              height:90,
              width: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: DarkPalette.darkYellow)

              ),
              child:  Center(
                  child: Text("|", style: GoogleFonts.workSans(
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                      color: Colors.amber
                  ))
              ),
            ),
            Container(

              height:90,
              width: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: DarkPalette.darkYellow)

              ),
              child:  Center(
                  child: Text("|", style: GoogleFonts.workSans(
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                      color: Colors.amber
                  ))
              ),
            ),
            Container(
              height:90,
              width: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: DarkPalette.darkYellow)

              ),
              child:  Center(
                  child: Text("|", style: GoogleFonts.workSans(
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                      color: Colors.amber
                  ))
              ),
            )
          ],
        ),
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

                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Text("Let's get going",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
              ))
        ])
      ],
    );

    Widget _qrScan = Column(
      children: [
        Text("Scan the QR Code"),
        Text("Place your phone camera over the QR Code provides and scan it"),
        Center(
          child: AspectRatio(aspectRatio: 1/1,
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/qr_bounding_box.png"
                        ),
                        fit: BoxFit.contain
                    )
                )
            ),)
        )
      ]
    );

    Widget _partyDetail =  Column(
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
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("House Party"),
                                Row(
                                  children: [
                                    Text("20th August 2021"),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: DarkPalette.darkYellow
                                      ),
                                      child: Text("Starts in 4hr:25m:20s")
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ))),
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
                                "PartyMixers",
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
                          "will be attending",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10),
                        )
                      ],
                    ),
                    Text("About"),
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Orci, scelerisque nunc, diam lorem. More...."),
                    Row(
                      children: [
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
                                Navigator.pushReplacementNamed(context, Routes.guestHome);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: Text("Suggest an event",
                                    style: GoogleFonts.workSans(
                                        color: DarkPalette.darkDark,
                                        fontWeight: FontWeight.bold
                                    )),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ]))
        ],
    );
    Widget _joinEventDone =  Column(children: [
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
    ]);

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


    return PageView(
      // physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          _eventChoice,
          _partyCodeForm,
          _qrScan,
          _partyDetail ,
          _joinEventDone ,
        ]);
  }
}