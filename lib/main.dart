import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicroom/routes.dart';
import 'package:musicroom/screens/advert.dart';
import 'package:musicroom/screens/authentication.dart';
import 'package:musicroom/screens/events.dart';
import 'package:musicroom/screens/home.dart';
import 'package:musicroom/screens/notifications.dart';
import 'package:musicroom/screens/playlist.dart';
import 'package:musicroom/screens/premium.dart';
import 'package:musicroom/screens/profile.dart';
import 'package:musicroom/screens/search.dart';
import 'package:musicroom/screens/suggestion_list.dart';
import 'package:musicroom/screens/yourRoom.dart';
import 'package:musicroom/styles.dart';
import 'package:musicroom/utils.dart';
import 'package:musicroom/utils/models.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(
      MyApp());
}

class MyApp extends StatelessWidget {
  // This widadbget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            primarySwatch: Colors.blue,
            fontFamily: GoogleFonts.workSans().fontFamily,
            textTheme: GoogleFonts.workSansTextTheme(
              Theme.of(context).textTheme,
            ).apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
              fontFamily: GoogleFonts.workSans().fontFamily,
            )),
        debugShowCheckedModeBanner: false,
        home: OnBoardingPage(),
        routes: <String, WidgetBuilder>{
          Routes.guestHome: (BuildContext context) => PartyGuestHome(),
          Routes.organizerHome: (BuildContext context) => EventOrganizerHome(),
          Routes.onboarding: (BuildContext context) => OnBoardingPage(),
          Routes.decision: (BuildContext context) => DecisionPage(),
          Routes.registerOrganizer: (BuildContext context) => RegisterScreen(),
          Routes.login: (BuildContext context) => LoginScreen(),
          Routes.forgotPassword: (BuildContext context) => ForgotPassword(),
          Routes.notifications: (BuildContext context) => NotificationScreen(),
          Routes.search: (BuildContext context) => SearchResultScreen(),
          Routes.profile: (BuildContext context) => ProfileScreen(),
          Routes.allSuggestions: (BuildContext context) => SuggestionScreen(title: "All Suggestions", suggestionType: SuggestionType.All,),
          Routes.acceptedSuggestions: (BuildContext context) => SuggestionScreen(suggestionType: SuggestionType.Accepted, title: "Accepted Suggestions"),
          Routes.partyPlaylist: (BuildContext context) => PartyPlayList(),
          Routes.premium:  (BuildContext context) => PremiumScreen(),
          Routes.subscription: (BuildContext context) => SubscriptionScreen(),
          Routes.yourRoom:  (BuildContext context) => YourRoom(),
          Routes.advert:  (BuildContext context) => Advert(),
          Routes.registerPartyGuest : (BuildContext context) => RegisterPartyGuest(),
          Routes.partyGuestProfile: (BuildContext context)=> PartyGuestProfile(),
          Routes.eventCardList:  (BuildContext context)=> EventListScreen(),
        });
  }
}

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 3), () async {
      Navigator.pushReplacementNamed(context, Routes.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Row(mainAxisSize: MainAxisSize.min, children: [
      Image.asset("assets/images/music_room_logo_gold.png"),
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Container(color: Colors.white, height: 60, width: 1),
      ),
      Flexible(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text("Music",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        Text("Room",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))
      ]))
    ]))));
  }
}

class OnboardPageModel extends StatelessWidget {
  String image;
  String heading;
  String subtitle;

  OnboardPageModel({
    required this.image,
    required this.heading,
    required this.subtitle,
  });

  Widget build(BuildContext context) {
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!;
    final TextStyle subtitle2 = Theme.of(context).textTheme.subtitle2!;
    return Padding(
        padding: EdgeInsets.all(5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.all(2),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("$image"),
                  fit: BoxFit.contain
                )
                ),
              )),
          SizedBox(height: 10),
          Text("$heading",
              style: GoogleFonts.workSans(textStyle: headline4, fontWeight: FontWeight.w700, height:1.3)),
          SizedBox(height: 25),
          Text("$subtitle", style: GoogleFonts.workSans(textStyle: subtitle2, fontWeight: FontWeight.w300, height:2)),
        ]));
  }
}

class OnBoardingPage extends StatefulWidget {
  static const String routeName = '/onboarding';

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int curr_page = 0;
  PageController _onboardPagesController = PageController(initialPage: 0);
  late Timer _timer;


  List<Widget> _onboardPages = [
    OnboardPageModel(
        image: "assets/images/onboard_1.png",
        heading: "Because we know you like to party!",
        subtitle:
            "Tired of not having a say on which song is being played at a party? Music room solves this for you."),
    OnboardPageModel(
        image: "assets/images/onboard_2.png",
        heading: "Because we know you like to party!",
        subtitle:
            "Tired of not having a say on which song is being played at a party? Music room solves this for you."),
    OnboardPageModel(
        image: "assets/images/onboard_3.png",
        heading: "Because we know you like to party!",
        subtitle:
            "Tired of not having a say on which song is being played at a party? Music room solves this for you.")
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer time) {
      if (curr_page < 2) {
        curr_page++;
      } else {
        curr_page = 0;
      }
      _onboardPagesController.animateToPage(
        curr_page,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            top: true,
            bottom: true,
            child: Padding(
                padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: Column(
                  children: [
                    Flexible(
                        child: PageView(
                      controller: _onboardPagesController,
                      children: _onboardPages,
                    )),
                    Row(
                      children: [
                        SmoothPageIndicator(
                          controller: _onboardPagesController,
                          count: _onboardPages.length,
                          effect: WormEffect(
                            activeDotColor: DarkPalette.darkGold,
                            dotHeight: 16,
                            dotWidth: 16,
                            type: WormType.thin,
                            // strokeWidth: 5,
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                            style: ButtonStyle(
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                    TextStyle(fontSize: 10)),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.only(right: 60, left: 60, top:18, bottom: 18)),
                                foregroundColor: MaterialStateProperty.all<Color>(
                                    DarkPalette.darkGold),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        side: BorderSide(color: DarkPalette.darkGold)))),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.decision);
                            },
                            child: Text("Get Started", style:GoogleFonts.workSans(fontSize: 10,
                                fontWeight: FontWeight.w600, height: 1.3)))
                      ],
                    )
                  ],
                ))));
  }
}

class DecisionPage extends StatefulWidget {
  static const String routeName = '/decision';
  @override
  _DecisionPageState createState() => _DecisionPageState();
}

class _DecisionPageState extends State<DecisionPage> {
  UserType _selectedUserType = UserType.partyOrganizer;

  @override
  Widget build(BuildContext context) {
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!;
    final TextStyle subtitle2 = Theme.of(context).textTheme.subtitle2!;
    return Scaffold(
        body: SafeArea(
            top: true,
            bottom: true,
            child: Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Let's make a decision.",
                          style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w700,
                            textStyle: headline4
                          )),
                      SizedBox(height: 20),
                      Text("What would you be suing this application as",
                      style: GoogleFonts.workSans(
                        textStyle: subtitle2,
                        fontWeight: FontWeight.w300
                      ),),
                      SizedBox(height: 50),
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
                                              "assets/images/dj.png"),
                                        ),
                                      )),
                                  Positioned.fill(
                                    child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                            padding: EdgeInsets.all(15),
                                            child: Text("DJ / Event Center",
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
                                                "assets/images/event_guest.png"),
                                          ),
                                        )),
                                    Positioned.fill(
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Text("Event Guest",
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
                      SizedBox(height: 50),
                      _selectedUserType == UserType.partyOrganizer ?
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    textStyle: MaterialStateProperty.all<TextStyle>(
                                        TextStyle(fontSize: 10)),
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                        Colors.transparent),
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.only(
                                            top: 20,
                                            right: 40,
                                            left: 40,
                                            bottom: 20)),
                                    foregroundColor: MaterialStateProperty.all<Color>(
                                        DarkPalette.darkGold),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        side: BorderSide(color: DarkPalette.darkGold)))),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      Routes.registerOrganizer);

                                },
                                child: Text("Let's Get Going",
                                    style: GoogleFonts.workSans(
                                        fontSize: 12,
                                        fontWeight:
                                        FontWeight.w700
                                    ))),
                          )
                        ],
                      ) : Row(children: [
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
                                  Navigator.of(context).pushNamed(
                                      Routes.registerPartyGuest);
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
                    ]))));
  }
}
