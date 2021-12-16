import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/screens/search.dart';
import 'package:musicroom/styles.dart';
import 'package:musicroom/utils/models.dart';

import '../routes.dart';
import '../utils.dart';
import 'events.dart';

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
        Text("What event are you suggesting this song for?",  style: GoogleFonts.workSans(
            fontSize: 23,
            fontWeight: FontWeight.bold
        )),
        SizedBox(height:20),
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
              return GestureDetector(
                onTap: (){
                },
                child:  EventCardGold(),
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

  PageController _pageController = PageController(initialPage: 0);
  UserType _selectedUserType = UserType.partyOrganizer;
  double sliderValue = 50.0;


  @override
  Widget build(BuildContext context){
    void _changePage(int curr_page) {
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          curr_page,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    }

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
        SizedBox(height: 30),
        Padding(
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
                      _changePage(1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Text("Suggest for an event",
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
        )
      ],
    );

    Widget _eventGrid = Column(
      children: [
        Text("What event are you suggesting this song for?",     style: GoogleFonts.workSans(
            fontSize: 25,
            height:1.5,
            fontWeight: FontWeight.bold
        )),
        SizedBox(height:20),
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
              return GestureDetector(
                  onTap: (){
                    // showModalBottomSheet(
                    //     isScrollControlled: true,
                    //     context: context,
                    //     backgroundColor: Colors.transparent,
                    //     builder: (context){
                    //       return Wrap(
                    //         children: [
                    //           PopupWidget(
                    //               popup: Popup.nowPlayingFilter,
                    //               userType: UserType.partyGuest,
                    //               height: 0.8
                    //           )
                    //         ],
                    //       );
                    //     });
                    _changePage(2);
                  },
                  child:EventCardGold());
            })
      ],
    );
    Widget _suggestionDone =   Column(children: [
      Container(
        child: Image.asset("assets/images/suggestion_created_Illustration.png"),
      ),
      SizedBox(height: 20),
      Text(
          "Yay!! Your song has been suggested for this event.",
          style: GoogleFonts.workSans(
              fontSize: 23,
              fontWeight: FontWeight.bold
          ), textAlign: TextAlign.center
      ),
      SizedBox(height: 20),
      Text(
          "You will ge updated on the status of your suggestion as soon as the event organizer approves it. ",
          style: GoogleFonts.workSans(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              height:1.5
          ),
          textAlign: TextAlign.center),
    ]);
    Widget _alreadySuggested =   Column(children: [
      Container(
        child: Image.asset("assets/images/event_created_success.png"),
      ),
      SizedBox(height: 20),
      Text(
          "Coool suggestion.",
          style: GoogleFonts.workSans(
              fontSize: 23,
              fontWeight: FontWeight.bold
          ), textAlign: TextAlign.center
      ),
      SizedBox(height: 20),
      Text(
          "You seem to know your stuff, nice suggestion thanks for adding life to the party. ",
          style: GoogleFonts.workSans(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              height:1.5
          ),
          textAlign: TextAlign.center),
    ]);
    return PageView(
      controller: _pageController,
      children: [
            _nowPlayingPopup,
            _eventGrid,
            _suggestionDone,
        _alreadySuggested
      ],
    );
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
        Text("Yay!! We partying soon.", style: GoogleFonts.workSans(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            height:2
        ), textAlign: TextAlign.center,),
        SizedBox(height:10),
        Text("Choose your preferred method to join this event",
            style: GoogleFonts.workSans(
                fontWeight: FontWeight.w300,
                fontSize: 16,
                height:1.8
            ), textAlign: TextAlign.center,),
        SizedBox(height:30),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedUserType = UserType.partyGuest;
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
                ),
              ),

            ]),
      ],
    );

    Widget _partyCodeForm = Column(
      children: [
        Text("Provide a code", style: GoogleFonts.workSans(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        height:2
    ), textAlign: TextAlign.center,),
        SizedBox(height:20),
        Text("Kindly enter the party code to join the party of your choice",style: GoogleFonts.workSans(
            fontWeight: FontWeight.w300,
            fontSize: 16,
            height:1.8
        ), textAlign: TextAlign.center,),
        SizedBox(height:20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height:70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.amber)

              ),
              child: Center(
                  child: Text("|", style: GoogleFonts.workSans(
                      fontSize: 40,
                      fontWeight: FontWeight.w100,
                      color: Colors.amber
                  ))
              ),
            ),
            Container(
              height:70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.amber)

              ),
              child:  Center(
                  child: Text("|", style: GoogleFonts.workSans(
                      fontSize: 40,
                      fontWeight: FontWeight.w100,
                      color: Colors.amber
                  ))
              ),
            ),
            Container(
              height:70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.amber)

              ),
              child:  Center(
                  child: Text("|", style: GoogleFonts.workSans(
                      fontSize: 40,
                      fontWeight: FontWeight.w100,
                      color: Colors.amber
                  ))
              ),
            ),
            Container(
              height:70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.amber)

              ),
              child:  Center(
                  child: Text("|", style: GoogleFonts.workSans(
                      fontSize: 40,
                      fontWeight: FontWeight.w100,
                      color: Colors.amber
                  ))
              ),
            )
          ],
        ),
        SizedBox(height:40),
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
        Text("Scan the QR Code", style: GoogleFonts.workSans(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            height:2
        ), textAlign: TextAlign.center,),
        SizedBox(height:20),
        Text("Place your phone camera over the QR Code provides and scan it", style: GoogleFonts.workSans(
        fontWeight: FontWeight.w300,
        fontSize: 16,
        height:1.8
        ), textAlign: TextAlign.center,),
        Padding(
          padding: EdgeInsets.all(20),
          child: Center(
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
                        alignment: Alignment.bottomRight,
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal:20.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: DarkPalette.darkYellow
                            ),
                            child: Text("Starts in 4hr:25m:20s", style: GoogleFonts.workSans(
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                              color: Colors.black
                            ),)
                        ))),
                Positioned.fill(
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("House Party", style: GoogleFonts.workSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25,
                                    )),
                                SizedBox(height:15),
                                Text("20th August 2021", style: GoogleFonts.workSans(
    fontWeight: FontWeight.w300,
    fontSize: 16,
    )),
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
                                        radius: 25,
                                        backgroundImage: AssetImage(
                                            "assets/images/circle_avatar_1.png"),
                                      )),
                                  Positioned(
                                      left: 15,
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundImage: AssetImage(
                                            "assets/images/circle_avatar_2.png"),
                                      )),
                                  Positioned(
                                      left: 35,
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundImage: AssetImage(
                                            "assets/images/circle_avatar_3.png"),
                                      )),
                                  Positioned(
                                      left: 55,
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundImage: AssetImage(
                                            "assets/images/circle_avatar_1.png"),
                                      )),
                                ],
                              ),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "will be attending",
                          style: GoogleFonts.workSans(
                              fontSize: 18,
                            fontWeight: FontWeight.w300
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 80),
                    Text("About", style: GoogleFonts.workSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    )),
                    SizedBox(height:20),
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Orci, scelerisque nunc, diam lorem. More....",
                        style: GoogleFonts.workSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w300
                        )),
                    SizedBox(height:40),
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
                                child: Text("Attend this Event",
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
        "Yay!! You're through the door.",
          style: GoogleFonts.workSans(
              fontSize: 23,
              fontWeight: FontWeight.bold
          )
      ),
      SizedBox(height: 20),
      Text(
          "Proceed to the event page to start suggesting songs or you can always do that later.",
          style: GoogleFonts.workSans(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              height:1.5
          ),
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
                  Navigator.of(context).pushNamed(Routes.allSuggestions);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text("Start Suggesting",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ),
            ))
      ])
    ]);



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



class SuggestSongForm extends StatefulWidget{
  @override
  _SuggestSongForm createState() => _SuggestSongForm();
}

class _SuggestSongForm extends State<SuggestSongForm>{

  PageController _pageController = PageController(initialPage: 0);
  UserType _selectedUserType = UserType.partyOrganizer;
  double sliderValue = 50.0;


  @override
  Widget build(BuildContext context){
    void _changePage(int curr_page) {
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          curr_page,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    }

    Widget _songSearch = Column(
      children: [
        Container(
          child: Image.asset("assets/images/event_created_success.png"),
        ),
        SizedBox(height: 20),
        Text(
            "Time to suggest a song",
            style: GoogleFonts.workSans(
                fontSize: 23,
                fontWeight: FontWeight.bold
            ), textAlign: TextAlign.center
        ),
        SizedBox(height: 20),
        Text(
            "Make a suggestion for this party, search for your favourites and add to this event. ",
            style: GoogleFonts.workSans(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                height:1.5
            ),
            textAlign: TextAlign.center),
        SizedBox(height: 20),
        TextFormField(
          autofocus: false,
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
                Navigator.of(context)
                    .pushNamed(Routes.search);
              },
            ),
          ),
        ),
        SizedBox(height: 35),
        Padding(
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
                      _changePage(1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Text("Let's Party",
                          style: GoogleFonts.workSans(
                            fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w700
                          )),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
    Widget _nowPlayingPopup = ListView(
      shrinkWrap: true,
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
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
        SizedBox(height: 30),
        Padding(
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
                      _changePage(1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Text("Suggest for an event",
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
        ),
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
                              title: "Similar Songs",
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
                          child:EventCardGold());
                    }),
                SizedBox(height:30),
              ]
          ),
        ),
      ],
    );

    Widget _eventGrid = Column(
      children: [
        Text("What event are you suggesting this song for?",     style: GoogleFonts.workSans(
            fontSize: 25,
            height:1.5,
            fontWeight: FontWeight.bold
        )),
        SizedBox(height:20),
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
              return GestureDetector(
                  onTap: (){
                    // showModalBottomSheet(
                    //     isScrollControlled: true,
                    //     context: context,
                    //     backgroundColor: Colors.transparent,
                    //     builder: (context){
                    //       return Wrap(
                    //         children: [
                    //           PopupWidget(
                    //               popup: Popup.nowPlayingFilter,
                    //               userType: UserType.partyGuest,
                    //               height: 0.8
                    //           )
                    //         ],
                    //       );
                    //     });
                    _changePage(2);
                  },
                  child:EventCardGold());
            })
      ],
    );
    Widget _suggestionDone =   Column(children: [
      Container(
        child: Image.asset("assets/images/suggestion_created_Illustration.png"),
      ),
      SizedBox(height: 20),
      Text(
          "Yay!! Your song has been suggested for this event.",
          style: GoogleFonts.workSans(
              fontSize: 23,
              fontWeight: FontWeight.bold
          ), textAlign: TextAlign.center
      ),
      SizedBox(height: 20),
      Text(
          "You will ge updated on the status of your suggestion as soon as the event organizer approves it. ",
          style: GoogleFonts.workSans(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              height:1.5
          ),
          textAlign: TextAlign.center),
    ]);
    Widget _alreadySuggested =   Column(children: [
      Container(
        child: Image.asset("assets/images/event_created_success.png"),
      ),
      SizedBox(height: 20),
      Text(
          "Coool suggestion.",
          style: GoogleFonts.workSans(
              fontSize: 23,
              fontWeight: FontWeight.bold
          ), textAlign: TextAlign.center
      ),
      SizedBox(height: 20),
      Text(
          "You seem to know your stuff, nice suggestion thanks for adding life to the party. ",
          style: GoogleFonts.workSans(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              height:1.5
          ),
          textAlign: TextAlign.center),
    ]);
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width *  0.3,
                decoration: BoxDecoration(
                    gradient: DarkPalette.borderGradient1,
                    borderRadius: BorderRadius.circular(10)
                ),
                height:3,
              )
          ),
          SizedBox(height: 20),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                _songSearch,
                _nowPlayingPopup,
                _suggestionDone,
              ],
            ),
          )]);
  }
}