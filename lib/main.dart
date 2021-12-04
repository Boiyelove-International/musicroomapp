import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicroom/routes.dart';
import 'package:musicroom/screens/authentication.dart';
import 'package:musicroom/screens/events.dart';
import 'package:musicroom/screens/home.dart';
import 'package:musicroom/screens/notifications.dart';
import 'package:musicroom/screens/search.dart';
import 'package:musicroom/screens/suggestion_list.dart';
import 'package:musicroom/styles.dart';
import 'package:musicroom/utils.dart';
import 'package:musicroom/utils/models.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.workSansTextTheme(
              Theme.of(context).textTheme,
            ).apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            )),
        debugShowCheckedModeBanner: false,
        home: SuggestionScreen(),
        routes: <String, WidgetBuilder>{
          Routes.home: (BuildContext context) => new HomeScreen(),
          Routes.onboarding: (BuildContext context) => OnBoardingPage(),
          Routes.decision: (BuildContext context) => DecisionPage(),
          Routes.registerOrganizer: (BuildContext context) => RegisterScreen(),
          Routes.login: (BuildContext context) => LoginScreen(),
          Routes.forgotPassword: (BuildContext context) => ForgotPassword(),
          Routes.notifications: (BuildContext context) => NotificationScreen(),
          Routes.search: (BuildContext context) => SearchResultScreen()
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
    return Padding(
        padding: EdgeInsets.all(5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: Image.asset("$image"))),
          SizedBox(height: 10),
          Text("$heading",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          SizedBox(height: 25),
          Text("$subtitle", style: TextStyle(fontSize: 14)),
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
                                    EdgeInsets.only(right: 40, left: 40)),
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
                            child: Text("Get Started"))
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
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      Text("What would you be suing this application as"),
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
                                                style: TextStyle(
                                                    color: DarkPalette.darkDark,
                                                    fontWeight:
                                                        FontWeight.w300)))),
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
                                                  style: TextStyle(
                                                      color:
                                                          DarkPalette.darkDark,
                                                      fontWeight:
                                                          FontWeight.w300)))),
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
                                  Navigator.pushReplacementNamed(
                                      context, Routes.registerOrganizer,
                                      arguments: _selectedUserType);
                                },
                                child: Text("Let's Get Going")),
                          )
                        ],
                      )
                    ]))));
  }
}
