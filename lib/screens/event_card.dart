import 'package:flutter/material.dart';
import '../styles.dart';

class EventCard extends StatelessWidget {
  @override
  Widget build(context) {
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
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [Text("Starts in"), Text("24h: 30m")])))),
          Positioned.fill(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text("Owambe Party",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900)),
                                      SizedBox(height: 10),
                                      Text("Hosted by - Owambe Hitz",
                                          style: TextStyle(fontSize: 10))
                                    ])),
                            Flexible(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  height: 35,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          right: 50,
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                "assets/images/circle_avatar_2.png"),
                                          )),
                                      Positioned(
                                          right: 25,
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                "assets/images/circle_avatar_3.png"),
                                          )),
                                      Positioned(
                                          right: 0,
                                          child: Container(
                                            height: 35,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: DarkPalette.borderGradient1,
                                            ),
                                            child: Center(child: Text("+500")),
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
              image: AssetImage("assets/images/party_people_1.png"))),
    );
  }
}