import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musicroom/routes.dart';
import 'package:musicroom/screens/authentication.dart';
import 'package:musicroom/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            scaffoldBackgroundColor: Colors.black,
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
              headline1: TextStyle(),
              headline2: TextStyle(),
              headline3: TextStyle(),
              headline4: TextStyle(),
              headline5: TextStyle(),
              headline6: TextStyle(),
              subtitle1: TextStyle(),
              subtitle2: TextStyle(),
              bodyText1: TextStyle(),
              bodyText2: TextStyle(),
              caption: TextStyle(),
              button: TextStyle(),
              overline: TextStyle(),
            ).apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            )),
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          Routes.home: (BuildContext context) => new HomePage(title: "Login"),
          Routes.onboarding: (BuildContext context) => OnBoardingPage(),
          Routes.decision: (BuildContext context) => DecisionPage(),
          Routes.registerOrganizer: (BuildContext context) => RegisterScreen(),
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
                            Stack(
                              children: [
                                Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Icon(Icons.check, color: Colors.red, size:30)
                                      )),
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width * 0.43,
                                    height:
                                    MediaQuery.of(context).size.width * 0.55,
                                    color: DarkPalette.darkYellow,
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Image.asset("assets/images/dj.png"),
                                      ),
                                    )),
                                Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Text("DJ / Event Center", style: TextStyle(
                                              color: DarkPalette.darkDark, fontWeight: FontWeight.w300
                                          ))
                                      )),
                                ),

                              ],
                            ),
                            SizedBox(width: 20),
                            Stack(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width * 0.43,
                                    height:
                                    MediaQuery.of(context).size.width * 0.55,
                                    color: DarkPalette.darkYellow,
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Image.asset(
                                            "assets/images/event_guest.png") ,
                                      ),
                                    )),
                                Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Text("Event Guest", style: TextStyle(
                                            color: DarkPalette.darkDark, fontWeight: FontWeight.w300
                                        ))
                                      )),
                                ),

                              ],
                            ),
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
                EdgeInsets.only(top: 20, right: 40, left: 40, bottom:20)),
            foregroundColor: MaterialStateProperty.all<Color>(
                DarkPalette.darkGold),
            shape: MaterialStateProperty.all<
                RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: DarkPalette.darkGold)))),
        onPressed: () {
          Navigator.pushReplacementNamed(
              context, Routes.registerOrganizer);
        },
        child: Text("Let's Get Going")),
                          )
                        ],
                      )
                    ]))));
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  static const String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
